const assert = require("node:assert/strict");
const { readFileSync } = require("node:fs");
const { join } = require("node:path");
const { test } = require("node:test");
const vm = require("node:vm");

const root = join(__dirname, "..");
const helper = readFileSync(join(root, "assets/js/csound-audio-session.js"), "utf8");
const home = readFileSync(join(root, "_layouts/home.html"), "utf8");

function environment(navigator = { userAgent: "iPhone", audioSession: { type: "auto" } }) {
  const context = vm.createContext({ navigator });
  vm.runInContext(helper, context);
  return context;
}

for (const [userAgent, maxTouchPoints] of [
  ["iPhone", 0], ["iPad", 0], ["iPod", 0], ["Macintosh", 5]
]) {
  test(`${userAgent}: playback overrides Silent mode and restores the prior type`, () => {
    const context = environment({ userAgent, maxTouchPoints, audioSession: { type: "ambient" } });
    const session = context.beginPlaybackAudioSession();
    assert.equal(context.navigator.audioSession.type, "playback");
    session.release();
    assert.equal(context.navigator.audioSession.type, "ambient");
    context.navigator.audioSession.type = "playback";
    session.release();
    assert.equal(context.navigator.audioSession.type, "playback", "release only acts once");
  });
}

test("leaves desktop and Android audio alone", () => {
  for (const userAgent of ["Macintosh", "Windows", "Linux Android"]) {
    const context = environment({ userAgent, maxTouchPoints: 0, audioSession: { type: "auto" } });
    assert.equal(context.beginPlaybackAudioSession(), undefined);
    assert.equal(context.navigator.audioSession.type, "auto");
  }
});

test("leaves recording and later changes alone", () => {
  const context = environment();
  context.navigator.audioSession.type = "play-and-record";
  assert.equal(context.beginPlaybackAudioSession(), undefined);
  assert.equal(context.navigator.audioSession.type, "play-and-record");
  context.navigator.audioSession.type = "auto";
  const session = context.beginPlaybackAudioSession();
  context.navigator.audioSession.type = "play-and-record";
  session.release();
  assert.equal(context.navigator.audioSession.type, "play-and-record");
});

test("missing or rejected Audio Session APIs do not block playback", () => {
  const unavailable = [
    {},
    { userAgent: "iPhone" },
    { userAgent: "iPhone", get audioSession() { throw new Error("unavailable"); } },
    { userAgent: "iPhone", audioSession: {
      get type() { return "auto"; },
      set type(value) { throw new Error("unsupported"); }
    } }
  ];
  for (const navigator of unavailable) {
    assert.doesNotThrow(() => environment(navigator).beginPlaybackAudioSession());
  }
  const context = environment();
  delete context.navigator;
  assert.equal(context.beginPlaybackAudioSession(), undefined);
});

test("release tolerates a rejected restore", () => {
  const context = environment();
  const session = context.beginPlaybackAudioSession();
  Object.defineProperty(context.navigator.audioSession, "type", {
    get: () => "playback",
    set: () => { throw new Error("unavailable"); }
  });
  assert.doesNotThrow(() => session.release());
});

async function player(name, failure) {
  const context = environment();
  const elements = new Map();
  const instances = [];
  const errors = [];
  let imports = 0;
  const fetched = [];
  const written = [];
  const compiled = [];
  const page = name === "home" ? "" : readFileSync(join(root, `learn/examples/${name}.md`), "utf8");
  const script = page.match(/<script src="\{\{ '\/assets\/js\/csound-example-player\.js' \| relative_url \}\}"[\s\S]*?<\/script>/)?.[0];
  const pageAsset = (attribute) => {
    const path = script?.match(new RegExp(`data-${attribute}="\\{\\{ '([^']+)' \\| relative_url \\}\\}"`))?.[1];
    return path && `/preview${path}`;
  };
  context.console = { error: (error) => errors.push(error) };
  context.document = {
    currentScript: { dataset: {
      csd: pageAsset("csd"),
      sample: pageAsset("sample")
    } },
    getElementById(id) {
      if (!elements.has(id)) elements.set(id, {
        value: "", textContent: "", classList: { add() {}, remove() {} }
      });
      return elements.get(id);
    },
    querySelectorAll: () => []
  };
  context.fetch = async (url) => {
    fetched.push(url);
    if (failure === "fetch") throw new Error("fetch failed");
    return { arrayBuffer: async () => new ArrayBuffer(0) };
  };
  const module = new vm.SyntheticModule(["Csound"], function () {
    this.setExport("Csound", async () => {
      assert.equal(context.navigator.audioSession.type, "playback", "set the type before creating Csound");
      if (failure === "factory") throw new Error("factory failed");
      const listeners = new Map();
      const instance = {
        listeners,
        terminated: false,
        on: (event, callback) => listeners.set(event, callback),
        setOption: async () => {},
        fs: { writeFile: async (filename) => written.push(filename) },
        compileCSD: async (filename) => {
          compiled.push(filename);
          return failure === "compile" ? -1 : 0;
        },
        start: async () => failure === "start" ? -1 : 0,
        pause: async () => {},
        resume: async () => {},
        stop: async () => {
          if (failure === "stop") throw new Error("stop failed");
          listeners.get("realtimePerformanceEnded")?.();
        },
        cleanup: async () => {},
        terminateInstance: async () => { instance.terminated = true; }
      };
      instances.push(instance);
      return instance;
    });
  }, { context });
  await module.link(() => {});
  await module.evaluate();
  const source = name === "home"
    ? home.match(/<script>([\s\S]*?)<\/script>/)[1]
    : readFileSync(join(root, "assets/js/csound-example-player.js"), "utf8");
  new vm.Script(source, {
    importModuleDynamically: async () => {
      imports++;
      if (failure === "import") throw new Error("import failed");
      return module;
    }
  }).runInContext(context);
  return {
    context, instances, errors, fetched, written, compiled,
    imports: () => imports,
    start: () => name === "home" ? context.toggleHeroCsound() : context.start(),
    pause: () => name === "home" ? context.toggleHeroCsound() : context.pause(),
    type: () => context.navigator.audioSession.type
  };
}

for (const [name, sample] of [["pling"], ["waveguide"], ["vibes", "marmstk1.wav"], ["vocoder", "fox.wav"]]) {
  test(`${name}: page configuration loads the correct files under a base URL`, async () => {
    const p = await player(name);
    await p.start();
    const files = [...(sample ? [sample] : []), `${name}.csd`];
    assert.deepEqual(p.fetched, files.map((file) => `/preview/learn/examples/${file}`));
    assert.deepEqual(p.written, files);
    assert.deepEqual(p.compiled, [`${name}.csd`]);
    assert.equal(p.errors.length, 0);
  });
}

for (const name of ["home", "pling", "waveguide", "vibes", "vocoder"]) {
  test(`${name}: pause/resume keeps playback active; the end event restores audio`, async () => {
    const p = await player(name);
    await p.start();
    assert.equal(p.instances.length, 1);
    await p.pause();
    assert.equal(p.type(), "playback");
    await p.start();
    assert.equal(p.instances.length, 1);
    p.instances[0].listeners.get("realtimePerformanceEnded")();
    assert.equal(p.type(), "auto");
    assert.equal(p.errors.length, 0);
  });

  test(`${name}: repeated Play clicks start one session`, async () => {
    const p = await player(name);
    await Promise.all([p.start(), p.start()]);
    assert.equal(p.imports(), 1);
    assert.equal(p.instances.length, 1);
  });

  for (const failure of ["import", "factory", "fetch", "compile", "start"]) {
    test(`${name}: ${failure} failure restores audio and permits a retry`, async () => {
      const p = await player(name, failure);
      await p.start();
      assert.equal(p.type(), "auto");
      assert.equal(p.errors.length, 1);
      assert.ok(p.instances.every((instance) => instance.terminated));
      await p.start();
      assert.equal(p.imports(), 2);
      assert.equal(p.type(), "auto");
    });
  }
}

test("home: switching presets releases the old session before acquiring the next", async () => {
  const p = await player("home");
  await p.start();
  await p.context.selectHeroPreset("vibes");
  assert.equal(p.instances.length, 2);
  assert.equal(p.type(), "playback");
  p.instances[0].listeners.get("realtimePerformanceEnded")();
  assert.equal(p.type(), "playback", "a late event cannot release the new session");
  await p.context.stopHeroCsound();
  assert.equal(p.type(), "auto");
});

test("home: Stop restores audio even when Csound cannot stop", async () => {
  const p = await player("home", "stop");
  await p.start();
  await p.context.stopHeroCsound();
  assert.equal(p.type(), "auto");
});

test("both player layouts load the audio helper before the player scripts", () => {
  const helperTag = '<script src="{{ \'/assets/js/csound-audio-session.js\' | relative_url }}"></script>';
  assert.ok(home.indexOf(helperTag) >= 0);
  assert.ok(home.indexOf(helperTag) < home.indexOf("<script>"));
  const examples = readFileSync(join(root, "_layouts/examples.html"), "utf8");
  assert.ok(examples.indexOf(helperTag) >= 0);
  assert.ok(examples.indexOf(helperTag) < examples.indexOf("{{ content }}"));
});

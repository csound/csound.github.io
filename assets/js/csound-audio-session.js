// Request audible Web Audio on iOS when the Silent switch is on.
// https://bugs.webkit.org/show_bug.cgi?id=237322#c6
function beginPlaybackAudioSession() {
  if (typeof navigator === "undefined") return;
  const isIOS = /iPad|iPhone|iPod/.test(navigator.userAgent) ||
    (/Macintosh/.test(navigator.userAgent) && navigator.maxTouchPoints > 1);
  if (!isIOS) return;

  try {
    const session = navigator.audioSession;
    if (!session) return;
    const previous = session.type;
    if (previous === "play-and-record") return;
    session.type = "playback";
    const applied = session.type;
    let released = false;

    return {
      release() {
        if (released) return;
        released = true;
        try {
          // Leave changes made by other audio on the page alone.
          if (session.type === applied) session.type = previous;
        } catch (error) {}
      }
    };
  } catch (error) {
    // Older browsers may lack this API or reject the requested type.
  }
}

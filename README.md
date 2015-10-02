# csound.github.io

[![Join the chat at https://gitter.im/csound/csound.github.io](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/csound/csound.github.io?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

Jekyll-based website for http://csound.github.io

# Editing Locally 

## Requirements

1. Ruby
2. RubyGems - most ruby distributions should come with gem installed
3. Bundler - install using `gem install bundler`

## Instructions

First, make a clone of the project locally: 

    git clone git://github.com/csound/csound.github.io.git
    cd csound.github.io

From this directory, run Bundler to install the required gems:
    
    bundle install

This installed the github-pages gem.

To view the site locally with `jekyll`, run:

    bundle exec jekyll serve --watch

This will start up a jekyll server. You can view the pages as they are rendered by Jekyll in your browser at:

    http://localhost:4000
    
Also, with the --watch command, anytime you change a page, you can view the updates by refreshing the browser.

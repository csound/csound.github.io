# csound.github.io

This Git repository holds the source code for the csound.github.io website,
found at [https://csound.com](https://csound.com). The source is made
up of Markdown (.md) files, which hold the content for pages and posts.  These
files are further processed by Jekyll, together with template files, to
generate the final HTML site.  

# How to contribute 

This site is an open-source, collaborative project. The Csound community is
encouraged to contribute to the maintenance of the site by adding news posts,
modifying pages, updating the structure of the site, and developing the style
of the pages. The following describes how to perform these tasks.  These tasks
may be performed directly by members of the site maintainers team, or
indirectly via pull request by third parties. 

Users who would like to contribute, but who are not comfortable with the
technical details to make a direct contribution, are encouraged to either file
an issue on the [issue tracker](http://github.com/csound/csound.github.io/issues) 
describing the news entry or requested change, or contact one of the site
maintainers who will work to evaluate and integrate any changes. 

## Adding a News post 

News posts are created using Markdown files placed in the \_posts folder. Each
post must have a header that states the title, categories, layout, and date of
the post.  (For news, the layout should be "post".) After the header, news is
written using standard Markdown text.  Images and other content may be put into
the post by using standard HTML content (i.e. for images, use the image tag).
The actual image should be placed in the images folder. If you have a question,
it may help to look at one of the existing posts to use as a reference. 

## Modifying and Creating Pages 

Pages are also Markdown files. They require headers that specify the layout
(most should use "default") and title.  Top-level pages are found in the root
of the Git repository. Pages may also be placed in sub-folders.  The pages must
be linked to in some way for users to access them.  This is generally done by
modifying one of the templates in the \_templates or \_includes folder. 

New pages can be made by copying one of the existing pages and updating it for
the new content.  Add an item at \_data/cms.yaml.

Existing pages may be modified locally and pushed to the
repository, or submitted as a change via pull request.  Pages may also be
modified directly through the GitHub project site, which allows modifying the
page within the browser. Users can navigate to the file in the project, select
the edit button, then finish the edit. 

## Modifying the site structure 

The structure of the site is organized through the links of the navigation.
The links are placed in the \_templates and \_includes so that they are shared
by all pages and posts. To modify the structure, update one of the template
files.  

## Modifying the site theme 

The site uses Bootstrap 5 and a modified template by [Saul Roll](https://github.com/soulroll/jekyll-bootstrap-5). The [Bootstrap CSS](assets/css/main/bootstrap.css) should not changed at all; it can be replaced by a more recent version if necessary.

Changes in styling must go to [csound.site.css](assets/css/main/csound-site.css). These two stylesheets are referenced in "default.html" in this order, so that Bootstrap settings are overwritten by our own styles.

Syntax highlighting is done via [rainbow](https://github.com/ccampbell/rainbow).  The source files live in assets/css/highlight and assets/js/highlight.

Font-Awesome is used for some icons, too.

## Changing the landing page

The code is in \_layouts/home-html. It is easy to change a carousel item.

Images for the landing page (carousel) must have 1140 width and 620 height as size.

## Syntax highlighing for code examples

To add Csound syntax highlighting to a code block, start with  
\`\`\`csound  
and end the block with three backticks  
\`\`\`


# Editing the Site Locally 

## Requirements

1. Ruby
2. RubyGems - most ruby distributions should come with gem installed
3. Bundler - install using `gem install bundler`

## Instructions

First, make a clone of the project locally: 

    git clone https://github.com/csound/csound.github.io.git
    cd csound.github.io

From this directory, run Bundler to install the required gems:
    
    bundle install

This installed the github-pages gem.

To view the site locally with `jekyll`, run:

    bundle exec jekyll serve

This will start up a jekyll server. You can view the pages as they are rendered by Jekyll in your browser at:

    http://localhost:4000
    
Anytime you change a page, you can view the updates by refreshing the browser.



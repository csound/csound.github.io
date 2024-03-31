# csound.github.io

This Git repository holds the source code for the csound.github.io website,
found at [https://csound.com](https://csound.com). The source is made
up of Markdown (.md) files, which hold the content for pages and posts.  These
files are further processed by Jekyll, together with template files, to
generate the final HTML site.  


## How to contribute 

This site is an open-source, collaborative project. The Csound community is
encouraged to contribute to the maintenance of the site by adding news posts,
modifying pages, updating the structure of the site, and developing the style
of the pages. The following describes how to perform these tasks.  These tasks
may be performed directly by members of the site maintainers team, or
indirectly via pull request by third parties. 

Users who would like to contribute, but who are not comfortable with the
technical details to make a direct contribution, are encouraged to either file
an issue on the [issue tracker](http://github.com/csound/csound.github.io/issues) describing the news entry or requested change, or contact one of the site maintainers who will work to evaluate and integrate any changes. 


### Updating Download Links

Edit \_data/download.yaml.

In case you want to add a new download item, add it in \_data/download.yaml and edit \_layouts/download.html.


### Adding a News or Projects post

It is always most easy to use an existing post, save it with a new name and modify it.

News are located in the \_posts folder.  
Projects are located in the \posts/showcase folder.

Each post must have a header that states the title, categories, layout, and date of the post. After the header, the post is written using [Github Flavored Markdown](https://github.github.com/gfm/) text.


### Including Images

Add the image file (*.png* or *.jpeg*) in the /images folder.

To show the image, you have two possibilities:

1. You can use the markdown syntax for images:  
	`![ADSR](images/ADSR.png)`  
2. It might be better to use html and include Bootstrap's "img-fluid" class to make the image responsive and optionally scale it:  
	`<img src="images/ADSR.png" class="img-fluid" alt="ADSR" width=75% />`
	

### Syntax Highlighing for Code Examples

To add Csound syntax highlighting to a code block, start with  
\`\`\`csound  
and end the block with three backticks  
\`\`\`


### Modifying and Creating Pages 

Pages are also Markdown files. They require headers that specify the layout
(most should use "page") and title.

The pages markdown files follow the site structure:  
- *get-started.md* and others are in the /learn folder
- *conferences.md* and others are in the /community folder

New pages can be made by copying one of the existing pages and updating it for
the new content.  Add an item at \_data/navigation.yaml.

Existing pages may be modified locally and pushed to the
repository, or submitted as a change via pull request.  Pages may also be
modified directly through the GitHub project site, which allows modifying the
page within the browser. Users can navigate to the file in the project, select
the edit button, then finish the edit. 


### The docs Folder

This folder contains the most recent version of the manual and other references. **Never** change its name. (As well not for any existing page; otherwise you will create dead links.)



## Modifying the Site Theme 

The site uses Bootstrap 5 and a modified template by [Saul Roll](https://github.com/soulroll/jekyll-bootstrap-5). The [Bootstrap CSS](assets/css/main/bootstrap.css) should not changed at all; it can be replaced by a more recent version if necessary.

Syntax highlighting is done via [rainbow](https://github.com/ccampbell/rainbow).  The source files live in assets/css/highlight and assets/js/highlight.

Font-Awesome is used for some icons, too.


### css

Changes in styling must go to [csound.site.css](assets/css/main/csound-site.css). These two style sheets are referenced in "default.html" in this order, so that Bootstrap settings are overwritten by our own styles.


### Changing the Landing Page

The code is in \_layouts/home-html. It is easy to change a carousel item.

Images for the landing page (carousel) must have 1140 width and 620 height as size.


## Editing the Site Locally 

### Requirements

1. Ruby
2. RubyGems - most ruby distributions should come with gem installed
3. Bundler - install using `gem install bundler`

### Instructions

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





# Latex devcontainer

Environment for writing AFIT theses (or other latex documents).

This environment is intended to be general-purpose and flexible. You can have multiple documents in the same repository, and you can mix Markdown, Latex, and code. I also made sure you can relatively easily migrate between this environment and Overleaf.

The initial setup time is a bit painful, but once the image is built/downloaded, building PDFs is fast. 

This makes use of `texlive/texlive:latest` as the base image. This image includes a full TexLive installation. TexLive versions in `apt` repositories and other images are years out-of-date.

Warning: This is a work-in-progress. Contributions are welcome.


## Getting started

Fork or copy this repo, open the folder in VSCode, and `reopen in container`. This will take a while for the image to download/build.

Next, open `graphing/graphing_main.tex`, click the play icon, then the preview icon.

![Build Process](tex_resources/img/build.png)


## Included

1. thesis_template - This is the standard thesis template found on Overleaf. I did a direct copy with no modifications. Chapters are broken out into individual files. No references are made to files outside the thesis_template directory.

1. alt_thesis_template - This is a modified version of the standard thesis template. It has been modified to use `/tex_resources/*` and includes the drawio import. It also uses a different (but configurable) setup for glossary/acronym/nomenclature.
   
1. tex_resources - These files are intended to be shared between Latex projects. For example, `/tex_resources/refs.bib` can be maintained as the master list of references, so you don't need to maintain copies for different projects. I use Zotero and "Better BibTex for Zotero" to manage my references. Better BibTex creates a static citation key, so you can make sure your keys don't get modified.

1. drawio - Draw.io is an open-source equivalent to Visio. This environment includes the VSCode extension for Draw.io so you can work offline. To create a drawing, simply create a file in the drawio directory with the extension `.drawio`. I have included a plugin to automatically convert a `.drawio` file to PDF whenever you're building a Latex project. See `graphing/graphing_main.tex` for more an example. 
  Note: to include drawio figures in `thesis_template/main.tex` you will need to copy some lines from `alt_thesis_template/thesis.tex`.

1. graphing - Simple example project for writing general documentaion. Includes two methods for creating graphs (tikz and drawio).

1. `synctex` allows you to jump between the code and the PDF preview. This is very useful for large documents:
    - To go from code to pdf:
      - windows/linux: `ctrl` + `alt` + `j`
      - mac: `cmd` + `option` + `j`
    - To go from pdf to code:
      - windows/linux: `ctrl` + `click`
      - mac: `cmd` + `click`

2. `ltex` provides grammar and spell checking in the editor.


## Not included, but recommended

Github Copilot is very useful for writing Latex. It can help with syntax, smart copy-paste, and even writing text. You can get a free academic license and install the VSCode extension.


## Random notes

I have VSCode set to hide gitignore files to make things cleaner. This can cause confusion if you're not aware. You can change this in `.vscode/settings.json`. 

Gitignore in project directories (e.g., `alt_thesis_template/.gitignore`) excludes PDF files from the repo. Only directories with additional `.gitignore` files ignore PDFs. Make sure you are not committing copious numbers of large PDF files. PDFs that should be included in the repo are things like figures, not compiled documents.

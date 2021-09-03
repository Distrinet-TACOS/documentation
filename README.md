# Documentation of TACOS

## Prerequisites

Python3, Pandoc, GNU make, virtualenv and LaTeX are required to build the documentation. They can be installed and initialized by running the following in a terminal on Ubuntu. Pandoc is downloaded from the Github repository as the version included in the Ubuntu repositories is very outdated.

``` bash
sudo apt install python3 make texlive virtualenv

wget https://github.com/jgm/pandoc/releases/download/2.14.2/pandoc-2.14.2-1-amd64.deb -O /tmp/pandoc-2.14.2
sudo dpkg -i /tmp/pandoc-2.14.2


virtualenv .venv
source .venv/bin/activate
pip install -r requirements.txt
deactivate
```

## Building the documentation

Building the documentation is as simple as running

``` bash
make
```

This will compile a pdf output and a html output, both located in the `out` directory.

## Editing the documentation

The documentation is written in Markdown, with Pandoc extensions. The file `main.md` in the root folder is the "entry point" of the documentation. Each top level section is written in a section file (also called `main.md`) placed in its own folder and then included in the root `main.md` via an include directive:

``` Markdown
!include <folder>/main.md
```

If there are specific instructions for different platforms, these should be seperated from the section file into their own file (e.g. `qemu.md`) in the same section folder and included in the section file using the same include directive.

## Opening html documentation using make

To open the html file using the documentation, a file name `make.conf` should first be created where the variables `BROWSER` and `DIR` are set to the browser executable and root dir of the documentation respectively. This file should not be added to git.

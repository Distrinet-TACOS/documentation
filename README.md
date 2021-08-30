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

## Opening using make

To open the html file using the documentation, a file name `make.conf` should first be created where the variables `BROWSER` and `DIR` are set to the browser executable and root dir of the documentation respectively. This file should not be added to git.

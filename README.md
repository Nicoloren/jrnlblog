# jrnlblog
Simple blogging static website generator based on jrnl ( http://jrnl.sh ).

Based on *jrnl* you can export the content of jour journal.txt file in a simple website.

**PLEASE this is still a work in progress : do not use it**

## Requirements

You'll need theses softwares on your system to use **jrnlblog** :

 * bash
 * sed
 * cat
 * markdown ( sudo apt-get install markdown )
 * mkdir
 * echo
 * rm 

## Install

Simply download the zip file or clone the repo : 

git clone https://github.com/Nicoloren/jrnlblog.git

Make the file *jrnlblog.sh* executable : 

chmod u+x jrnlblog.sh

## Configure

You must enter a name for your blog and you may want to change some behavior.

You can open *jrnlblog.sh* in your favorite editor to change some options.

## How to use 

./jrnlblog.sh tag

The parameter `tag` must be a valid jrnl tag without the arobase character (@).

You can see your tags with :

jrnl --tags




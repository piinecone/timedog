Timedog
=======

Timedog travels back in time to restore your files.

![Alt text](https://s3.amazonaws.com/piinecone/github/timedog/timedog.jpg)

Dependencies
------------

* ruby 2.x

Installation
------------

### OS X ###

* `git clone https://github.com/piinecone/timedog.git ~/cool/timedog/path/`
* add /cool/timedog/path/bin to your $PATH; e.g.:

   `echo 'export PATH=$PATH:/cool/timedog/path/bin' >> ~/.bash_profile`

* ensure `which timedog` returns something
* ensure /cool/timedog/path/bin/timedog is executable (chmod +x timedog)

### Windows ###

** Currently completely untested **

* install ruby (http://rubyinstaller.org/) (allow it to add ruby to your $PATH)
* install [git bash for windows](http://git-scm.com/downloads)
* run git bash
* `git clone https://github.com/piinecone/timedog.git ~/cool/timedog/path/`
* add ~/cool/timedog/path/bin to your $PATH; e.g.:

   `echo 'export PATH=$PATH:~/cool/timedog/path/bin' >> ~/.bash_profile`

* ensure `which timedog` returns something
* ensure ~/cool/timedog/path/bin/timedog is executable (chmod +x timedog)

Usage
-----

* cd ~/codebase/with/crashy/files
* `timedog add *.file_extensions_to_backup`
* `timedog watch <seconds>` to tell timedog to watch the current directory for changes and create restore points every `seconds` seconds (default is 120)
* `timedog list` to list backup points:
    
   ```
   [1] 1403920093 created at 2014-06-27 18:48:13 -0700
   [2] 1403920088 created at 2014-06-27 18:48:08 -0700
   [3] 1403920083 created at 2014-06-27 18:48:03 -0700
   ```
   

* `timedog restore <number>` to reset your matching working directory files to that of the chosen restore point

How it works
------------

Caveats
-------

Todo
----

* Reduce dependencies
* Automated tests

Contributing
------------
* Fork it
* Make sure the hypothetical automated test suite passes
* Pull Request a feature branch with your changes

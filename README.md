Timedog
=======

Timedog

Dependencies
------------

* ruby

Installation
------------

### OS X ###

* `git clone https://github.com/piinecone/timedog.git ~/cool/timedog/path/`
* add /cool/timedog/path/bin to your $PATH; e.g.:

   `echo 'export PATH=$PATH:/cool/timedog/path/bin' >> ~/.bash_profile`

* ensure `which timedog` returns something
* ensure /cool/timedog/path/bin/timedog is executable (chmod +x timedog)

### Windows ###

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
* `timedog watch` to tell timedog to watch the current directory for changes and create restore points
* `timedog list` to list backup points:
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

osxbootstrap
============

Custom bootstrap installation and configuration for Mac OS X.

<br />
Introduction
============

In order to have easier reinstalls of my Mac, I wrote scripts based off of
[fBootstrap](https://github.com/fbeeper/fBootstrap) and [Wilto's dotfiles](https://github.com/Wilto/dotfiles).
The files are organized as follows:

* **bootstrap.sh**: Command script to run the process.
* **brew/*.sh**: Scripts to install software.
* **config/osx.sh**: Script to set custom settings to OSX.

<br />
Installation
============

Run the following:

	git clone git://github.com/krimkus/OSXBootstrap.git ~/.bootstrap 
	cd ~/.bootstrap && ./bootstrap.sh

If the Mac this is being installed on has a ssd boot drive or a battery, 
use the appropriate flags, `--ssd` and `--battery`

  cd ~/.fBootstrap && ./bootstrap.sh --ssd --battery

During the installation/configuration process, you will be prompted for
your username/email and root credentials.

<br />
Customization
=============

I think that most of these scripts are perfectly useful for anybody. However,
there are parts that you should consider to adapt to fit your own needs: 

* The applications installed under **/brew/brew.sh** could be customized to your needs. More casks available at [https://github.com/phinze/homebrew-cask](https://github.com/phinze/homebrew-cask)
* Everything under **/config/osx.sh** is relatively personal. Take a look and decide for yourself.

<br />
What you get
============

An essential pack of software for your Mac:

* [Homebrew](http://mxcl.github.com/homebrew/)
* [Homebrew-Cask](https://github.com/phinze/homebrew-cask) SUPER HANDY!!!
* [Zsh](http://www.zsh.org) + [Oh my
  sh!](https://github.com/robbyrussell/oh-my-zsh)!
* [Dropbox](https://www.dropbox.com) 
* [The Unarchiver](http://wakaba.c3.cx/s/apps/unarchiver.html) 
* [Google Chrome](https://www.google.com/intl/en/chrome/browser/)
* [VLC Media Player](http://www.videolan.org/vlc/)
* [Spotify](https://www.spotify.com/)
* [Bartender](http://www.macbartender.com)
* [BetterTouchTool](http://blog.boastr.net)
* [Coconutbattery](http://www.coconut-flavour.com/coconutbattery/)
* [DaisyDisk](http://www.daisydiskapp.com)

You also get these tools for developement:

* [CMake + CMake GUI](http://www.cmake.org)
* [X-Quartz](http://xquartz.macosforge.org)
* [Imagemagick](http://www.imagemagick.org)
* [Graphviz](http://www.graphviz.org)
* [SourceTree](http://www.sourcetreeapp.com)
* [iTerm2](http://www.sourcetreeapp.com)
* [Makeicns](http://www.amnoid.de/icns/makeicns.html)
* [Postgresql](https://wiki.postgresql.org/wiki/Homebrew)
* [Readline](https://pypi.python.org/pypi/readline)

And last but not least, this bootstrap will install:

* ``Ctrl`` + ``⌥`` + ``⌘`` + ``c`` to copy file/dir paths from Finder. I know
  *drag and drop* is cool, but not as much as this shortcut!
  
<br /> 
What's the future of OSXBootstrap?
--------------------------------

**Nothing planned yet.**

I'd be happy to hear any comments, ideas, code, questions.

You can find me at: [github.com/krimkus](https://github.com/krimkus), or
[@kylerimkus](http://twitter.com/kylerimkus).

<br />
Licensing and thanks...
-----------------------

I kept as much references as I could (in-line with the code) to the work of others. But I'm going to be more clear: 

* Much of the structure is based on [fbeeper's fBootstrap](https://github.com/fbeeper/fBootstrap), which is freely licensed.

* Code adapted from [Thoughtbot's
  Laptop](https://github.com/thoughtbot/laptop) has an [MIT License](https://raw.github.com/thoughtbot/laptop/master/LICENSE).

* [Root FS 'noatime' mounting](https://gist.github.com/pklaus/931579) comes from
  another unlicensed code. Thanks to [Philipp
  Klaus](https://gist.github.com/pklaus/931579).

* Code that is not already licensed is free software, and may be redistributed under the terms specified in the LICENSE file.

* Thanks for all the people who wrote all the software installed using this script.


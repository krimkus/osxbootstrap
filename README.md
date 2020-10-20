osxbootstrap
============

Custom bootstrap installation and configuration for Mac OS X.


Introduction
============

In order to have easier reinstalls of my Mac, I wrote scripts based off of
[fBootstrap](https://github.com/fbeeper/fBootstrap) and [Wilto's dotfiles](https://github.com/Wilto/dotfiles).
The files are organized as follows:

* **bootstrap.sh**: Command script to run the process.
* **brew/*.sh**: Scripts to install software.
* **config/osx.sh**: Script to set custom settings to OSX.


Installation
============
First, install XCode from the Mac App Store.

Then, run the following:

	git clone git://github.com/krimkus/OSXBootstrap.git ~/.bootstrap 
	cd ~/.bootstrap && ./bootstrap.sh

If the Mac this is being installed on has a ssd boot drive or a battery, 
use the appropriate flags, `--ssd` and `--battery`

  cd ~/.fBootstrap && ./bootstrap.sh --ssd --battery

During the installation/configuration process, you will be prompted for
your username/email and root credentials.


Customization
=============

I think that most of these scripts are perfectly useful for anybody. However,
there are parts that you should consider to adapt to fit your own needs: 

* The applications installed under **/brew/brew.sh** could be customized to your needs. More casks available at [https://github.com/phinze/homebrew-cask](https://github.com/phinze/homebrew-cask)
* Everything under **/config/osx.sh** is relatively personal. Take a look and decide for yourself.


What you get
============

An essential pack of software for your Mac:

* [Homebrew](http://mxcl.github.com/homebrew/)
* [Homebrew-Cask](https://github.com/phinze/homebrew-cask)
* [Zsh](http://www.zsh.org) + [Oh my zsh!](https://github.com/robbyrussell/oh-my-zsh)
* [The Unarchiver](http://wakaba.c3.cx/s/apps/unarchiver.html) 
* [Google Chrome](https://www.google.com/intl/en/chrome/browser/)
* [VLC Media Player](http://www.videolan.org/vlc/)
* [Spotify](https://www.spotify.com/)
* [Bartender](http://www.macbartender.com)
* [BetterTouchTool](http://blog.boastr.net)
* [Coconutbattery](http://www.coconut-flavour.com/coconutbattery/)
* [DaisyDisk](http://www.daisydiskapp.com)
* [Transmit](https://panic.com/transmit)
* [1Password](https://1password.com)

You also get these tools for development:

* [Nova](https://nova.app)
* [Fork](https://git-fork.com)
* [iTerm2](https://www.iterm2.com)
* [Notion](https://notion.so)
* [Pyenv](https://github.com/pyenv/pyenv#homebrew-on-macos)
* [Postgresql](https://wiki.postgresql.org/wiki/Homebrew)
* [Readline](https://pypi.python.org/pypi/readline)

And last but not least, this bootstrap will install:

* ``Ctrl`` + ``⌥`` + ``⌘`` + ``c`` to copy file/dir paths from Finder. I know
  *drag and drop* is cool, but not as much as this shortcut!
  

What's the future of OSXBootstrap?
--------------------------------

There are tasks that I would still like to automate:

Installing homebrew currently prompts to install dev tools because it isn't by default with XCode (Checking for clang is not enough). But the shortcut for that could be run first. 

Turn on (or warn) full-disk encryption if installing on a laptop
Customize finder sidebar:
* Hide all-my-files, movies, music, pictures, bonjour, idisk
* Show ~, ~/Code, boot disk 

Customize Alfred and Spotlight more:
* Launch Alfred at login
* change Spotlight hotkey to alt-space
* change Alfred hotkey to command-space

Customize iTerm2:
* Set theme to https://draculatheme.com/iterm
* Set windows to open Columns: 120, Rows: 60
* Set font to Menlo Powerline, regular 14pt https://github.com/Lokaltog/powerline-fonts

Code to add to this repo:
* check that mysql and postgres are working properly, add Django db_settings defaults
* remove default mac apps from the dock

Add tasks to the Reminders app to do the following:
* Copy in private keys
* Copy in OS X keychains
* Copy in 1Password library, or turn on cloud storage
* Copy in Transmit favorites
* Add mail accounts


Licensing and thanks...
-----------------------

I kept as much references as I could (in-line with the code) to the work of others. But I'm going to be more clear: 

* Much of the structure is based on [fbeeper's fBootstrap](https://github.com/fbeeper/fBootstrap), which is freely licensed.

* Code adapted from [Thoughtbot's
  Laptop](https://github.com/thoughtbot/laptop) has an [MIT License](https://raw.github.com/thoughtbot/laptop/master/LICENSE).

* Code that is not already licensed is free software, and may be redistributed under the terms specified in the LICENSE file.

* Thanks for all the people who wrote all the software installed using this script.


I'd be happy to hear any comments, ideas, code, questions.

You can find me at: [github.com/krimkus](https://github.com/krimkus), or
[@kylerimkus](http://twitter.com/kylerimkus).


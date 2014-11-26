# blinkbox books Customer Service Admin Panel Test Suite

## Pre-Setup

Get Ruby running on your system.

### OS X Only

[Install RVM](http://octopress.org/docs/setup/rvm/) which lets you easily manage your Ruby versions.

Next make sure you've got Ruby 2.1.3 installed:

```
$ rvm install 2.1.3
```

Alternatively you can use [rbenv](https://github.com/sstephenson/rbenv) and `ruby-build` from brew and once installed do much the same.

```
rbenv install 2.1.3-p242
```

The Ruby version to use is in the Gemfile and .ruby-version, so when you `cd` to the root directory RVM/rbenv should automatically switch to using 2.1.3. You can verify this by running:

```
$ ruby -v
```

## Setup

Install bundler:

```
$ sudo gem install bundler
```

And finally install all the requirements for this suite. You might need to `rbenv rehash` beforehand.

```
$ bundle
```

## Running

The default option is to test locally using Firefox with target site nodejs-internal

```
$ cucumber
```

To test via the Selenium Grid server

There are a number of profiles defined in the cucumber.yml file

* mac-safari
* mac-firefox
* mac-chrome
* win7-ie
* win7-firefox
* win7-chrome
* win-vista-ie
* win-vista-firefox
* win-vista-chrome
* win8-ie
* win8-firefox
* win8-chrome
* win-vista-ie
* win-vista-firefox
* win-vista-chrome

There are also command line options to choose the target device and target server

* SERVER = LOCALHOST, DEV, TEST, PRODUCTION
* DEVICE = DESKTOP (resizes the browser window to suit target device)

e.g. to test Firefox on Windows 7, on the QA server, simulating a tablet in landscape :

```
cucumber -p win7-firefox SERVER=QA DEVICE=TABLET-LANDSCAPE
```



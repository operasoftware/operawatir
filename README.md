# Readme

[OperaWatir](http://operawatir.org/) is a part of the [Watir](http://watir.com/) (pronounced _water_) family of free software Ruby libraries for automating web browsers.  OperaWatir provides a querying engine and Ruby bindings for a backend Java library, OperaDriver, for driving the [Opera web browser](http://opera.com/).  It aims for full compliance with the [watirspec](https://github.com/jarib/watirspec) specification.

License:: [New BSD](https://github.com/operasoftware/operawatir/blob/master/LICENSE)
Project Home:: [http://operawatir.org/](http://operawatir.org/)
Source Code:: [https://github.com/operasoftware/operawatir](https://github.com/operasoftware/operawatir)
Mailing List:: [https://list.opera.com/mailman/listinfo/operawatir-users](https://list.opera.com/mailman/listinfo/operawatir-users)
Issues:: [https://github.com/operasoftware/operawatir/issues](https://github.com/operasoftware/operawatir/issues)
Gem:: [https://rubygems.org/operawatir](http://rubygems.org/gems/operawatir)

## Third-Party Libraries

OperaDriver uses the following third-party Java libraries:

- [Google protobuf](http://code.google.com/p/protobuf/) (New BSD License)
- [Apache Commons JXPath](http://commons.apache.org/jxpath/) (Apache 2.0 License)

More information about the New BSD (AKA Modified BSD or BSD-3) and Apache 2.0 licenses can be found in the appropriate text files in ``lib/operadriver``.

## Install

### Requirements

OperaWatir runs on GNU/Linux and Windows operating systems.  Other UNIX-like systems, such as BSD and OS X, are not currently supported, but support is planned.  Required dependencies are _Java_ >= 1.6.0, _JRuby_ >= 1.5.1 (ruby 1.8.7 patchlevel 249), _RubyGems_ >= 1.3.5, _RSpec_ >= 2.0.0, and a somewhat recent desktop or nightly build of Opera.

### Installation procedure

Make sure that you have the right requirements for installing and running OperaWatir.  Please note that OperaWatir will only run on the JRuby platform. For more detailed installation instructions, please see our [Getting Started](http://operasoftware.github.com/operawatir/tutorial.html) guide.

To install (leave out the “sudo” command if you're installing on Windows):

    % sudo jruby -S gem install operawatir

Next, make sure that JRuby's ``bin`` directory is a part of your ``PATH`` environmental variable on GNU/Linux.

## Limitations

__Before you get started playing with OperaWatir, there are a few important things you need to keep in mind.__

This is a __pre-release__ of OperaWatir (0.3), and should not be considered stable or suitable for use in production.  It should be treated as a proof of concept. 

It is not possible to run OperaWatir without specifying the ``OPERA_PATH`` (full path to Opera binary) and ``OPERA_LAUNCHER`` (full path to Opera launcher binary) environmental variables. 

Since the launcher applications are not shipped with the latest public release of Opera, we have bundled them with the gem.  They can be found in ``./utils/launchers/`` under the gem's directory (typically ``/usr/lib/jruby/lib/ruby/gems/1.8/gems/operawatir-0.3-java/utils/launchers/`` on GNU/Linux systems and ``C:\\JRuby-1.5.2\\lib\\ruby\\gems\\1.8\\gems\\operawatir-0.3-java\\utils\\launchers\\`` on Windows).  The launchers provided will work on 32-bit GNU/Linux and Windows operating systems.  OS X support is planned.

## Examples

The Watir API allows you to write scripts that interact with any web page.  Its primary purpose is to ease test automation for web applications.  Your scripts can, for example, before you deploy automatically go through all the steps your users normally would and alert you of any regressions. 

Let's take a closer look at how this works. 

    require 'rubygems'
    require 'operawatir'
    
    browser = OperaWatir::Browser.new
    
    browser.goto 'http://en.wikipedia.org/'
    browser.text_field(:id => 'searchInput').set 'Opera'
    browser.button(:id => 'searchButton').click

The script above will tell the browser to load the front page of Wikipedia, write “Opera” in the search field and click the search button.  If all goes as intended, the browser will end up at a relevant article. 

To run the script, use the following command:

    % jruby example.rb

As Watir scripts are run in a full-featured browser, all keypresses and clicks will be interpreted as if they were real, and invoke attached JavaScript event listeners.  If we want to test the JavaScript-powered suggestion feature on the Wikipedia search box, we can do this: 

    require 'rubygems'
    require 'operawatir'
    
    browser = OperaWatir::Browser.new
    
    browser.goto 'http://en.wikipedia.org/'
    browser.text_field(:id => 'searchInput').click
    browser.type 'Hello world'
    browser.key 'Down'
    browser.key 'Enter'

The first suggested link will be selected by pressing arrow down (``'Down'``) and navigated to (``'Enter'``).  Using the same key events, you could even teach a script to play platform games: 

    require 'rubygems'
    require 'operawatir'
  
    browser.goto 'http://www.phoboslab.org/biolab/'
    sleep 2
    browser.key 'X'
    sleep 1
    browser.key_down 'Right'
    5.times { browser.key 'X' }
    2.times { browser.key 'C' }
    browser.key_up 'Right'

Sending commands to the browser is great, but sometimes we want to get something back too.  The following lines of code will have the browser automatically look up the phone number of Opera Software in the [yellow pages](http://gulesider.no/) and write it to the console.

    require 'rubygems'
    require 'operawatir'
    
    browser = OperaWatir::Browser.new
    
    browser.goto 'http://gulesider.no/'
    browser.text_field(:name => 'search_word').set 'Opera Software'
    browser.button(:name => 'btn_cs').click
    puts browser.li(:class => 'tel').text

When running proper functional tests on your web application with Watir, you might want a bit more structured output.  To define assertions and get pretty test reports, you can use [RSpec](http://rspec.info/), a behaviour-driven testing framework. 

When writing test suites you can use the OperaWatir::Helper class to help ease some tasks, such as constructing and tearing down the Browser object.  A simple test suite looks like this:

    describe 'Yellow Pages' do
      before :each do
        browser.goto 'http://gulesider.no/'
      end
    
      it 'finds the phone number to Opera Software' do
        browser.text_field(:name => 'search_word').set 'Opera Software'
        browser.button(:name => 'btn_cs').click
        browser.li(:class => 'tel').text.should == '24 16 40 00'
      end
    
      it 'finds the phone number to the Norwegian Opera and Ballet' do
        browser.text_field(:name => 'search_word').set 'Den Norske Opera'
        browser.button(:name => 'btn_cs').click
        browser.li(:class => 'tel').text.should == '21 42 21 00'
      end
    end

Since this is an RSpec test you can run it using the operawatir binary, which is simply a shortcut for running tests: 

    % operawatir yellow_pages.rb

Each block of code corresponds to a single named test case returning PASS or FAIL.  Whether you got back the expected and correct return value is evaluated with ``.should``.  If all tests pass, you will see the following output: 

    ..
  
    Finished in 2.04 seconds
    2 examples, 0 failures

If anything fails, more information about each failure will be provided.

## Merry Christmas!

Despite its shortcomings, we hope you will enjoy playing around with the Watir libraries for using OperaDriver driving Opera. We decided that we would rather see it go out to the public before Christmas than waiting for another month or two until it is pristine and perfect. 

One of the things we are most excited about is the new Watir 2 API that we have made a prototype implementation of, which is based on [Jari Bakken's ideas for a new API](https://github.com/jarib/watir-webdriver/wiki/Comparison-with-Watir-1.X). On top of this, we have written a Watir 1 compatibility layer which is switched on by default. We are looking forward to the design discussions that this will bring. Oh, and by the way, will you be able to find the magic switch for Watir 2? (-; 

We hope you'll enjoy this little Christmas gift! Furthermore, we wish you a Merry Christmas and a Happy New Year from us here at Opera Software in Oslo!

# Readme

[OperaWatir](http://operawatir.org/) is a part of the [Watir](http://watir.com/) (pronounced _water_) family of free software Ruby libraries for automating web browsers.  OperaWatir provides a querying engine and Ruby bindings for a backend Java library, OperaDriver, for driving the [Opera web browser](http://opera.com/).  It aims for full compliance with the [Watir 2](https://github.com/jarib/watirspec) and the [Watir 3](https://github.com/operasoftware/watir3-spec) specifications.

* __License:__ [New BSD](https://github.com/operasoftware/operawatir/blob/master/LICENSE)
* __Project Home:__ [http://www.opera.com/developer/tools/operawatir/](http://www.opera.com/developer/tools/operawatir/)
* __Source Code:__ [https://github.com/operasoftware/operawatir](https://github.com/operasoftware/operawatir)
* __Mailing List:__ [https://list.opera.com/mailman/listinfo/operawatir-users](https://list.opera.com/mailman/listinfo/operawatir-users)
* __Issues:__ [https://github.com/operasoftware/operawatir/issues](https://github.com/operasoftware/operawatir/issues)
* __Gem:__ [https://rubygems.org/operawatir](http://rubygems.org/gems/operawatir)

## Install

### Requirements

OperaWatir runs on GNU/Linux, Mac OS X and Windows operating systems. Required dependencies are _Java_ >= 1.6.0, _JRuby_ <= 1.5.5, _RubyGems_ >= 1.3.5, _RSpec_ <= 2.5, and a somewhat recent desktop or nightly build of Opera.  For Windows you must also have the Microsoft Visual C++ 2008 Redistributable Package.

### Installation procedure

Make sure that you have the right requirements for installing and running OperaWatir.  Please note that OperaWatir will only run on the JRuby platform. For more detailed installation instructions, please see our [Getting Started](http://dev.opera.com/articles/view/opera-watir-tutorial/) guide.

To install (leave out the “sudo” command if you're installing on Windows):

    % sudo jruby -S gem install operawatir

Next, make sure that JRuby's ``bin`` directory is a part of your ``PATH`` environmental variable on GNU/Linux.

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

You can also see ``operawatir -h`` for more usage information:

    Usage: operawatir [-m|--manual] [-l|--launcher=BINARY] [-b|--binary=BINARY]
           [-a|--args=ARGUMENTS] [-q|--no-quit] [--no-opera-idle] [--no-color]
           [-f|--format=FORMAT] [-o|--out=FILE] [-h|--help] [-v|--version] FILES
    
    Specific options:
        -m, --manual                     Wait for a manual connection from opera:debug
        -l, --launcher=BINARY            Path to launcher binary, will use environmental 
                                         variable OPERA_LAUNCHER if not specified
        -b, --binary=BINARY              Browser to run the test with, will use guess the 
                                         path or use environmental variable OPERA_PATH if 
                                         not specified
        -a, --args=ARGUMENTS             Arguments passed to the binary, will override  
                                         environmental variable OPERA_ARGS
        -q, --no-quit                    Disable quitting of Opera at the end of a test run
            --no-opera-idle              Disable OperaIdle
            --no-color                   Disable colorized output
        -o, --out=FILE                   Send output to a file instead of STDOUT
        -f, --format=FORMAT              Specify RSpec output formatter (documentation, 
                                         html, progress (default), textmate)
    
    Common options:
        -h, --help                       Show this message
        -v, --version                    Show version

## Third-Party Libraries

OperaWatir uses the following libraries:

- [OperaDriver](http://www.opera.com/developer/tools/operadriver/) (Apache 2.0 License)
- [rspec](https://github.com/rspec/rspec) (MIT License)
- [jeweler](https://github.com/technicalpickles/jeweler) (MIT License)
- [rake](https://github.com/jimweirich/rake) (MIT License)
- [yard](https://github.com/lsegal/yard) (MIT License)
- [mongrel](http://rubyforge.org/projects/mongrel) (Ruby License)
- [sinatra](http://www.sinatrarb.com/) (MIT License)
- [rr](http://rubyforge.org/projects/double-ruby) (MIT License)
- [bluecloth](http://deveiate.org/projects/BlueCloth) (BSD License)
- [clipboard](https://github.com/janlelis/clipboard) (MIT License)
- [deprecated](https://github.com/erikh/deprecated) (BSD License)
- [bundler](http://gembundler.com/) (MIT License)


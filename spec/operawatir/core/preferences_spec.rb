# -*- coding: utf-8 -*-
require File.expand_path('../../watirspec_helper', __FILE__)

describe OperaWatir::Preferences do

  before :all do
    @prefs = browser.preferences
    @old_prefs = @prefs.to_a
  end

  describe '#new' do
    it 'constructs a new instance' do
      @prefs.should exist
      @prefs.should be_kind_of OperaWatir::Preferences
    end
  end

  describe '#each' do
    it 'contains a list of entries' do
      @prefs.each do |p|
        p.should be_kind_of OperaWatir::Preferences::Section
      end
    end
  end

  describe '#length' do
    it 'has a valid length' do
      @prefs.length.should be_kind_of Integer
    end

    it 'has several sections' do
      @prefs.length.should > 10
    end

    it 'responds to alias #size' do
      @prefs.size.should == @prefs.length
    end
  end

  describe '#first' do
    it 'is a valid entry' do
      @prefs.first.should be_kind_of OperaWatir::Preferences::Section
    end

    it 'has a key' do
      @prefs.first.key.should_not be_empty
    end

    it 'has a method' do
      @prefs.first.method.should match /^([a-z_]+)/
    end
  end

  describe '#last' do
    it 'is a valid entry' do
      @prefs.last.should be_kind_of OperaWatir::Preferences::Section
    end

    it 'has a key' do
      @prefs.last.key.should_not be_empty
    end

    it 'has a method' do
      @prefs.last.method.should match /^([a-z_]+)/
    end
  end

  describe '#empty?' do
    it 'returns a valid type' do
      @prefs.empty?.should be_kind_of FalseClass
    end

    it 'is not empty' do
      @prefs.should_not be_empty
    end
  end

  describe '#to_s' do
    before :all do
      @string = @prefs.to_s
    end

    it 'returns a string' do
      @string.should be_kind_of String
    end

    it 'contains sections' do
      @string.should match /^([a-z_]+)/
    end

    it 'contains keys' do
      @string.should match /^\s{2}([a-z_]+)/
    end

    it 'contains values' do
      @string.should match /^\s{4}value:.+\"(.+)\"/
    end

    it 'contains defaults' do
      @string.should match /^\s{4}default:.+\"(.+)\"/
    end
  end

  describe '#to_a' do
    before :all do
      @array = @prefs.to_a
    end

    it 'returns an array' do
      @array.should be_kind_of Array
    end

    it 'returns entries of the type Preference::Section' do
      @array[0].should be_kind_of OperaWatir::Preferences::Section
    end

    it 'has several entries' do
      @array.size > 10
    end

    it 'contains keys' do
      @array[0].key.should_not be_empty
      @array[0].method.should match /([a-z_]+)/
    end
  end

  describe OperaWatir::Preferences::Section do

    before :all do
      @section = @prefs.link
    end

    describe '#new' do
      it 'constructs a new instance' do
        @section.should be_kind_of OperaWatir::Preferences::Section
      end
    end

    describe '#parent' do
      it 'contains the parent class' do
        @section.parent.should be_kind_of OperaWatir::Preferences
      end
    end

    describe '#method' do
      it 'has a valid method name' do
        @section.method.should match /([a-z_]+)/
      end
    end

    describe '#key' do
      it 'has a key name' do
        @section.key.should_not be_empty
      end
    end

    describe '#each' do
      it 'contains a list of entries' do
        @section.each do |k|
          k.should be_kind_of OperaWatir::Preferences::Section::Key
        end
      end
    end

    describe '#length' do
      it 'has a valid length' do
        @section.length.should be_kind_of Integer
      end

      it 'has one or more keys' do
        @section.length.should >= 1
      end

      it 'responds alias #size' do
        @section.size.should == @section.length
      end
    end

    describe '#first' do
      it 'is a valid entry' do
        @section.first.should be_kind_of OperaWatir::Preferences::Section::Key
      end

      it 'has a key' do
        @section.first.key.should_not be_empty
      end

      it 'has a key with a method' do
        @section.first.method.should match /^([a-z_]+)/
      end
    end

    describe '#last' do
      it 'is a valid entry' do
        @section.last.should be_kind_of OperaWatir::Preferences::Section::Key
      end

      it 'has a key' do
        @section.last.key.should_not be_empty
      end

      it 'has a key with a method' do
        @section.last.method.should match /^([a-z_]+)/
      end
    end

    describe '#empty?' do
      it 'returns a valid type' do
        @section.empty?.should be_kind_of FalseClass
      end

      it 'is not empty' do
        @section.should_not be_empty
      end
    end

    describe OperaWatir::Preferences::Section::Key do
      before :all do
        @key = @section.expiry
      end

      describe '#parent' do
        it 'contains the parent class' do
          @key.parent.should be_kind_of OperaWatir::Preferences::Section
        end
      end

      describe '#method' do
        it 'has a valid method name' do
          @key.method.should match /([a-z_]+)/
        end
      end

      describe '#key' do
        it 'has a key name' do
          @section.key.should_not be_empty
        end
      end

      describe '#type' do  # TODO

        # Note that the types aren't proper Ruby objects, but strings.

        it '`expiry` is a type integer' do
          @key.type.should match /integer/i
        end

        it '`color` is a type boolean' do
          @section.color.type.should match /boolean/i
        end

        it '`opera_account.server_address` is a type string' do
          @prefs.opera_account.server_address.type.should match /string/i
        end
      end

      describe '#value' do
        it 'returns a valid type' do
          @key.value.should be_kind_of String
        end

        it 'is not empty' do
          @key.value.should_not be_empty
        end
      end

      describe '#value=' do
        it 'is changed when set on a string preference' do
          @key.value = '20'
          @key.value.should == '20'
        end
        
        it 'is changed when set on an integer preference' do
          @section.color.value = true
          @section.color.value.should be_true
        end

        it 'has effect in the browser when changed' do
          @section.strikethrough.value = '1' #true
          window.url = fixture('simple.html')
          window.execute_script('document.getElementsByTagName("a")[0].currentStyle.textDecoration').should include 'line-through'
        end

        # JRUBY-1127 makes it impossible to unwrap Java exceptions in JRuby.
        
        # it 'does not allow setting an invalid value' do
        #   lambda { @section.color.value = 'foo' }.should raise_error NativeException
        # end
        
        after :each do
          @key.default!
          @section.color.default!
          @section.strikethrough.default!
        end
      end

      describe '#default' do
        it 'returns the default value' do
          @key.default.should == '10'
        end
      end

      describe '#default!' do
        before :each do
          @key.value = '1337'
        end
        
        it 'returns and sets default value' do
          @key.default!.should == @key.default
          @key.value.should == @key.default
        end

        after :all do
          @key.default!
        end
      end

    end

  end

=begin
  describe '#cleanup' do
    it 'returns an array' do
      @prefs.cleanup.should be_kind_of Array
    end

    it 'matches the old stored prefs' do
      @prefs.cleanup.should == @old_prefs
    end
  end

  describe '#cleanup!' do
    before(:all) { @after_cleanup = @prefs.cleanup! }

    it 'cleans up the preferences' do
      @key.value.should_not == '1337'
    end

    it 'matches the old stored prefs' do
      @after_cleanup.should == @old_prefs
    end

    it 'returns an array' do
      @after_cleanup.should be_kind_of Array
    end
  end
=end

#  after :all do
#    @prefs.cleanup!
#  end

end

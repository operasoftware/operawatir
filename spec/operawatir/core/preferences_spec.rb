# -*- coding: utf-8 -*-
require File.expand_path('../../watirspec_helper', __FILE__)

describe 'Preferences' do

  before :all do
    @prefs = browser.preferences
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
        p.should be_kind_of OperaWatir::Preferences::Entry
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
      @prefs.first.should be_kind_of OperaWatir::Preferences::Entry
    end

    it 'is a section' do
      @prefs.first.should be_section
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
      @prefs.last.should be_kind_of OperaWatir::Preferences::Entry
    end

    it 'is a section' do
      @prefs.last.should be_section
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

    it 'returns entries of the type Preference::Entry' do
      @array[0].should be_kind_of OperaWatir::Preferences::Entry
    end

    it 'has several entries' do
      @array.size > 10
    end

    it 'contains keys' do
      @array[0].key.should_not be_empty
      @array[0].method.should match /([a-z_]+)/
    end
  end
=begin
  describe 'Section' do  # Preferences::Entry / Preferences#method_missing

    before :all do
      @section = @prefs.link
    end
      
    describe '#new' do
      it 'constructs a new instance' do
        @section.should exist
        @section.should be_kind_of OperaWatir::Preferences::Entry
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

    describe '#value' do
      it 'raises exception' do
        @section.value.should raise_error OperaWatir::Exceptions::PreferencesException
      end
    end

    describe '#value=' do
      it 'raises exception' do
        @section.value.should raise_error OperaWatir::Exceptions::PreferencesException
      end
    end

    describe '#default' do
      it 'raises exception' do
        @section.value.should raise_error OperaWatir::Exceptions::PreferencesException
      end
    end

    describe '#default!' do
      it 'raises exception' do
        @section.value.should raise_error OperaWatir::Exceptions::PreferencesException
      end
    end

    describe '#section?' do
      it 'returns a valid type' do
        @section.section?.should be_kind_of TrueClass
      end

      it 'is a section' do
        @section.section?.should be_true
      end
    end

    describe '#exists?' do
      it 'returns a valid type' do
        @section.exists?.should be_kind_of TrueClass
      end

      it 'exists' do
        @section.exists?.should be_true
      end

      it 'responds to alias #exist?' do
        @section.exist?.should == @section.exists?
      end
    end

    describe '#each' do
      it 'contains a list of entries' do
        @section.each do |k|
          k.should be_kind_of OperaWatir::Preferences::Entry
        end
      end
    end

    describe '#length' do
      it 'has a valid length' do
        @section.length.should be_kind_of Integer
      end

      it 'has one or more sections' do
        @section.length.should >= 1
      end

      it 'responds alias #size' do
        @section.size.should == @section.length
      end
    end

    describe '#first' do
      it 'is a valid entry' do
        @section.first.should be_kind_of OperaWatir::Preferences::Entry
      end

      it 'is a section' do
        @section.first.should be_section
      end

      it 'has a key' do
        @section.first.key.should_not be_empty
      end

      it 'has a method' do
        @section.first.key.should match /^([a-z_]+)/
      end
    end

    describe '#last' do
      it 'is a valid entry' do
        @section.last.should be_kind_of OperaWatir::Preferences::Entry
      end

      it 'is a section' do
        @section.last.should be_section
      end

      it 'has a key' do
        @section.last.key.should_not be_empty
      end

      it 'has a method' do
        @section.last.key.should match /^([a-z_]+)/
      end
    end

    describe '#empty?' do
      it 'returns a valid type' do
        @section.empty?.should be_kind_of TrueClass
      end

      it 'is not empty' do
        @section.should_not be_empty
      end
    end

    describe 'Keys' do  # Preferences::Entry / Entry#method_missing

      before :all do
        @key = @section.expiry
      end

      describe '#parent' do
        it 'contains the parent class' do
          @key.parent.should be_kind_of OperaWatir::Preferences::Entry
        end
      end

      describe '#method' do
        it 'has a valid method name' do
          @key.method.should match /([a-z_]+/
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
          @key.type.should include 'Integer'
        end

        it '`color` is a type boolean' do
          @section.color.type.should include 'Boolean'
        end

        it '`opera_account.server_address` is a type string' do
          @prefs.opera_account.server_address.should include 'String'
        end
      end

      describe '#value' do
        it 'returns a valid type' do
          @key.value.should be_kind_of String
        end

        it 'is not empty' do
          @key.value.should_not be_empty
        end

        it 'is numeric' do  # Is this needed?
          @key.value.should be_numeric
        end
      end

      describe '#value=' do
        it 'is changed when set' do
          @key.value = '20'
          @key.value.should == '20'
        end

        it 'has effect in the browser when changed' do
          @section.strike_through.value = true
          window.url = fixture('simple.html')
          window.a.eval_js('this.currentStyle.textDecoration').should include /strike\-through/
        end

        it 'does not allow setting an invalid value' do
          old_value = @section.color.value
          @section.color.value = 'foo'
          @section.color.value.should_not == 'foo'
          @section.color.value.should == old_value
        end
      end

      describe '#default' do
        it 'returns the default value' do
          @key.default == '10'
        end
      end

      describe '#default!' do
        before :each do
          @default_value = @key.default
          @key.value = '1337'
        end

        it 'returns and sets default value' do
          @key.default!.should == @default_value
          @key.value.should == @default_value
        end

        after :all do
          @key.value = @default_value
        end
      end

      describe '#section?' do
        it 'returns a valid type' do
          @key.section?.should be_kind_of TrueClass
        end

        it 'is not a section' do
          @key.section?.should be_false
        end
      end

      describe '#each' do
        it 'contains a list of entries' do
          @key.each do |e|
            e.should raise_error RuntimeException
          end
        end
      end

      describe '#length' do
        it 'not be 0' do
          @key.length.should == 0
        end

        it 'responds to alias #size' do
          @key.size.should == @key.length
        end
      end

      describe '#first' do
        it 'is empty' do
          @key.first.should be_empty
        end
      end

      describe '#last' do
        it 'is empty' do
          @key.last.should be_empty
        end
      end

      describe '#empty?' do
        it 'returns a valid type' do
          @key.empty?.should be_kind_of TrueClass
        end

        it 'is empty' do
          @key.empty?.should be_true
        end
      end

    end

  end

  describe '#cleanup' do; end   # TODO
  describe '#cleanup!' do; end  # TODO

  after :all do
    @prefs.cleanup!
  end
=end
end

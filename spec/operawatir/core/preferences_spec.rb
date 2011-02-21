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
        lambda { @section.value }.should raise_error OperaWatir::Exceptions::PreferencesException
      end
    end

    describe '#value=' do
      it 'raises exception' do
        lambda { @section.value = 'hoobaflooba' }.should raise_error OperaWatir::Exceptions::PreferencesException
      end
    end

    describe '#default' do
      it 'raises exception' do
        lambda { @section.default }.should raise_error OperaWatir::Exceptions::PreferencesException
      end
    end

    describe '#default!' do
      it 'raises exception' do
        lambda { @section.default! }.should raise_error OperaWatir::Exceptions::PreferencesException
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

      it 'has one or more keys' do
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

      it 'has a key' do
        @section.first.key.should_not be_empty
      end

      it 'has a key which is not a section' do
        @section.first.should_not be_section
      end

      it 'has a key with a method' do
        @section.first.method.should match /^([a-z_]+)/
      end
    end

    describe '#last' do
      it 'is a valid entry' do
        @section.last.should be_kind_of OperaWatir::Preferences::Entry
      end

      it 'has a key' do
        @section.last.key.should_not be_empty
      end

      it 'is a key which is not section' do
        @section.last.should_not be_section
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
          @key.type.should include 'Integer'
        end

        it '`color` is a type boolean' do
          @section.color.type.should include 'Boolean'
        end

        it '`opera_account.server_address` is a type string' do
          @prefs.opera_account.server_address.type.should include 'String'
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
        it 'is changed when set' do
          @key.value = '20'
          @key.value.should == '20'
        end

        it 'has effect in the browser when changed' do
          @section.strikethrough.value = '1' #true
          window.url = fixture('../simple.html')
          window.a.execute_script('this.currentStyle.textDecoration').should include /strike\-through/
        end

        # JRUBY-1127 makes it impossible to unwrap Java exceptions in JRuby.
        
        # it 'does not allow setting an invalid value' do
        #   lambda { @section.color.value = 'foo' }.should raise_error NativeException
        # end
        
        after :each do
          @key.default!
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

      describe '#section?' do
        it 'returns a valid type' do
          @key.section?.should be_kind_of FalseClass
        end

        it 'is not a section' do
          @key.section?.should be_false
        end
      end

      describe '#each' do
        it 'raises error' do
          lambda { @key.each { |e| } }.should raise_error OperaWatir::Exceptions::PreferencesException
        end
      end

      describe '#length' do
        it 'raises error' do
          lambda { @key.length }.should raise_error OperaWatir::Exceptions::PreferencesException
        end

        it 'responds to alias #size' do
          lambda { @key.size }.should raise_error OperaWatir::Exceptions::PreferencesException
        end
      end

      describe '#first' do
        it 'raises error' do
          lambda { @key.first }.should raise_error OperaWatir::Exceptions::PreferencesException
        end
      end

      describe '#last' do
        it 'raises error' do
          lambda { @key.last }.should raise_error OperaWatir::Exceptions::PreferencesException
        end
      end

      describe '#empty?' do
        it 'raises error' do
          lambda { @key.empty? }.should raise_error OperaWatir::Exceptions::PreferencesException
        end
      end

    end

  end

  describe '#cleanup' do; end   # TODO
  describe '#cleanup!' do; end  # TODO

  after :all do
    @prefs.cleanup!
  end

end

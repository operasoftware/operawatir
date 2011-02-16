require File.expand_path('../../watirspec_helper', __FILE__)

describe 'Preferences' do

  before :all do
    @prefs = browser.preferences
  end

  describe '#new' do
    it 'constructs a new instance' do
      @prefs.exist?.should be_true
    end
  end

  describe '#to_s' do; end

  describe '#each_section' do  # #each is an alias
    it 'contains a list' do
      @prefs.each_section do |p|
        p.kind_of?(OperaWatir::Preferences::Entry).should be_true
      end
    end
  end

  describe '#length' do; end  # #size is an alias
  describe '#last' do; end
  describe '#empty?' do; end

  describe 'Section' do  # Entry / Preferences#method_missing

    before :all do
      @section = @prefs.link
    end
      
    describe '#new' do
      it 'constructs a new instance' do
        @section.exist?.should be_true
      end
    end

    describe '#value' do; end
    describe '#value=' do; end
    describe '#default' do; end
    describe '#default!' do; end
    describe '#each_key' do; end  # #each is an alias

    describe '#is_section?' do
      it 'is a section' do
        @section.is_section?.should be_true
      end
    end

    describe 'Keys' do  # Entry / Entry#method_missing

      before :all do
        @key = @section.expiry
      end

      describe '#type' do
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
        it 'is not empty' do
          @key.value.should_not be_empty
        end

        it 'is numeric' do
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

      describe '#each_key' do; end  # #each is an alias

      describe '#is_section?' do
        it 'is not a section' do
          @key.is_section?.should be_false
        end
      end

    end

  end

  describe '#cleanup' do; end
  describe '#cleanup!' do; end

  after :all do
    @prefs.cleanup!
  end

end

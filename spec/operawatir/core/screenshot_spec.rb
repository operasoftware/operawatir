require File.expand_path('../../watirspec_helper', __FILE__)
require 'tmpdir'

RSpec::Matchers.define :save_file do
  match { |filename| File.exists? filename }
end

RSpec::Matchers.define :be_boolean do
  match { |variable| !!variable == variable }
end

describe 'Screenshot' do

  before :all do
    browser.url = fixture('boxes.html')
    @screenshot = window.screenshot
    @filename   = "#{Dir.tmpdir}/screenshot.png"
  end

  describe '#new' do
    context 'given no argument' do
      it 'creates a new Screenshot object' do
        @screenshot.should be_kind_of OperaWatir::Screenshot
      end
    end

    context 'given an argument' do
      it 'saves a screenshot' do
        window.screenshot(@filename).should save_file
      end
    end
  end

  describe '#save' do
    it 'saves screenshot to disk' do
      @screenshot.save(@filename).should save_file
    end
  end

  describe '#blank?' do
    it 'returns a valid type' do
      @screenshot.blank?.should be_boolean
    end

    it 'is not blank' do
      @screenshot.blank?.should be_false
    end
  end

  describe '#png' do
    before(:all) { @png = @screenshot.png }

    it 'returns a valid type' do
      @png.should be_kind_of String
    end

    it 'is a real type PNG image' do
      @png.should match /PNG/
    end
  end

  describe '#md5' do
    before(:all) { @md5 = @screenshot.md5 }

    it 'returns a valid type' do
      @md5.should be_kind_of String
    end

    it 'returns a hash' do
      @md5.should match /^(0x)[a-f0-9]{32}$/
    end
  end

  after(:all) { File.delete @filename if File.exists? @filename }

end

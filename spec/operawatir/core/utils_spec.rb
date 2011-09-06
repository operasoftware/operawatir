require File.expand_path('../../watirspec_helper', __FILE__)

describe OperaWatir::Utils do

  before(:all) { @utils = browser.utils }

  describe '#core_version' do
    it 'it matches a core version number' do
      @utils.core_version.should match /\d+\.\d+\.\d+/
    end
  end

  describe '#os' do
    it 'is not empty' do
      @utils.os.should_not be_empty
    end
  end

  describe '#product' do
    it 'is not unknown' do
      @utils.product.should_not include 'unknown'
    end

    it 'is known' do
      @utils.product.should match /core-gogi|desktop/
    end
  end

  describe '#binary_path' do
    it 'is not empty' do
      @utils.binary_path.should_not be_empty
    end
  end

  describe '#user_agent' do
    it 'is a User-Agent string' do
      @utils.user_agent.should match /Opera\/\d+\.\d+.+/
    end
  end

  describe '#pid' do
    it 'is greater than zero' do
      @utils.pid.should > 0
    end
  end

end

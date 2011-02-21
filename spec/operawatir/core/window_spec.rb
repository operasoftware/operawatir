require File.expand_path('../../watirspec_helper', __FILE__)
require 'tmpdir'

describe 'Window' do

  describe '#screenshot' do
    after (:each) do
      File.delete(Dir.tmpdir + '/screenshot.png')
    end

    it 'takes a screenshot of the specified element' do
      browser.url = fixture('boxes.html')
      window.screenshot(Dir.tmpdir + '/screenshot.png').should be_true
    end
  end

end

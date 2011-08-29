require File.expand_path('../../watirspec_helper', __FILE__)

describe OperaWatir::Browser do

  # Note: This method is deprecated, but still needs to be tested.
  describe '#opera_action' do
    it 'executes the specified action' do
      browser.url = fixture('input_fields_value.html')
      window.find_by_id('one').click
      browser.opera_action('Select all')
      window.eval_js('one = document.getElementById("one");')
    window.eval_js('one.value.substr(one.selectionStart, one.selectionEnd - one.selectionStart)').to_s.should == 'foobar'
    end
  end

  # Note: This method is deprecated, but still needs to be tested.
  describe '#opera_action_list' do
    it 'returns a list of available Opera actions' do
      browser.url = 'about:blank'
      browser.opera_action_list.should include 'copy'
      browser.opera_action_list.should include 'paste'
    end
  end

  # Note: This method is deprecated, but still needs to be tested.
  describe '#key' do
    it 'presses the specified key' do
      browser.url = fixture('two_input_fields.html')
      window.find_by_name('one').click
      browser.key 'a'
      window.find_by_name('one').value.should == 'a'
    end
  end

  # Note: This method is deprecated, but still needs to be tested.
  describe '#key_down' do
    it 'holds down the specfied key' do
      browser.url = fixture('grid.html')
      browser.key_down 'Shift' # This invokes spatnav on desktop browsers
      browser.key 'Down'
      browser.key 'Down'
      browser.key_up 'Shift'
      window.execute_script("document.activeElement.text;").to_s.should == 'C2'
    end
  end

  # Note: This method is deprecated, but still needs to be tested.
  describe '#key_up' do
    it 'releases the specfied key' do
      browser.url = fixture('grid.html')
      browser.key_down 'Shift' # This invokes spatnav on desktop browsers
      browser.key 'Down'
      browser.key 'Down'
      browser.key_up 'Shift'
      browser.key 'Down'
      window.execute_script("document.activeElement.text;").to_s.should == 'C2'
    end
  end

  # Note: This method is deprecated, but still needs to be tested.
  describe '#type' do
    it 'types a string of characters' do
      browser.url = fixture('two_input_fields.html')
      window.find_by_name('one').click
      browser.type 'foobar'
      window.find_by_name('one').value.should == 'foobar'
    end
  end

  describe '#desktop?' do
    it 'returns true or false' do
       [true,false].should include browser.desktop?
    end
  end

  describe '#version' do
    it 'fetches the version number of the driver' do
      browser.version.should match /\d{1,}\.\d{1,}\.\d{1,}/
    end
  end

end

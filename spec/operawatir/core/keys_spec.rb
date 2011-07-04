require File.expand_path('../../watirspec_helper', __FILE__)

#
# TODO
#

=begin
describe OperaWatir::Keys do

  before(:each) { browser.url = fixture('keys.html') }

  let(:keys)     { browser.keys                  }
  let(:keyboard) { window.pre(:id => 'log').text }

  subject { keyboard }

  describe '#down' do
    it 'presses one key' do
    end

    it 'presses series of keys' do
    end
  end

  describe '#up' do
    it 'releases one key' do
    end

    it 'releases series of keys' do
    end
  end

  describe '#release' do
    it 'releases one key' do
      keys.down 'a'
      keyboard.should hold_down_keys 'a'
      keys.release
      keyboard.should_not hold_down_keys 'a'
    end

    it 'releases one modifier key' do
      keys.down :shift
      keyboard.should hold_down_keys :shift
      keys.release
      keyboard.should_not hold_down_keys :shift
    end

    it 'releases several keys' do
      keys.down 'a', 'b'
      keyboard.should hold_down_keys 'a', 'b'
      keys.release
      keyboard.should_not hold_down_keys 'a', 'b'
    end

    it 'releases several modifier keys' do
      keys.down :shift, :control
      keyboard.should hold_down_keys :shift, :control
      keys.release
      keyboard.should_not hold_down_keys :shift, :control
    end

    it 'releases a combination of keys and modifier keys' do
      keys.down :shift, :control, 'a'
      keyboard.should hold_down_keys :shift, :control, 'a'
      keys.release
      keyboard.should_not hold_down_keys :shift, :control, 'a'
    end
  end

  describe '#send' do
  end

end
=end

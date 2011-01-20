# -*- coding: utf-8 -*-
class OperaWatir::Keys

  attr_accessor :browser

  def initialize(browser)
    self.browser = browser
  end

  # Holds down supplied arbitrary list of keys indefinitely.
  #
  # @param [Symbol, String] *args Arbitrary list of symbols
  #   (modification keys) or strings (regular keys) to be pressed
  #   down.
  #
  # @example
  #   browser.keys.down 'a'
  #   browser.keys.down 'a', :right
  #
  # @seealso up
  # @seealso send
  def down(*args)
    args.each { |key| driver.keyDown(key) }
  end

  # Depresses supplied arbitrary list of keys.
  #
  # @param [Symbol, String] *args Arbitrary list of symbols
  #   (modification keys) or strings (regular keys) to be depressed.
  #
  # @example
  #   browser.keys.up 'a', :right
  #
  # @seealso release
  def up(*args)
    args.each { |key| driver.keyUp(key) }
  end

  # Releases all pressed down keys.
  #
  # @example
  #   browser.keys.down :control, :shift, 'a'
  #   browser.keys.release
  def release
    driver.releaseKeys
  end

  # Presses an arbitrary list of keys or key combinations.  Provided
  # arguments are performed in sequence.
  #
  # Symbols are parsed as modification keys (such as :control, :shift,
  # :backspace, &c.), arraysd are interpreted as key combinations
  # (e.g. [:control, 'a'] will perform the combination C-a), and
  # strings will be typed as regular words.
  #
  # Note that this method is not OS indepdendent in the sense that
  # even though OS X does not have Control keys, it will not replace
  # your sent keys with Command.
  #
  # Available modification keys:  control, shift, access …
  # TODO
  #
  # @param [Symbol, Array, String] *args Arbitrary list of symbols,
  #   arrays or strings which will form a sequence of keys to be
  #   pressed.
  #
  # @example
  #   browser.keys.send 'a'
  #   browser.keys.send 'foo', 'bar'
  #   browser.keys.send :control
  #   browser.keys.send [:control, 'a']
  #   browser.keys.send [:control, 'a'], :backspace
  def send(*args)  # TODO rename?
    args.each do |arg|
      case arg
      when Array
        arg.each { |key| key.kind_of?(Symbol) ? down(key) : send(key) }
        release
      else
        #arg.kind_of?(Symbol) ? driver.key(arg) : driver.type(arg)
        driver.type arg
      end
    end
  end

private

  def driver
    browser.driver    
  end

  def access_key(key)
    driver.operaAction 'Enter access key mode'
    send key
    driver.operaAction 'Leave access key mode'
  end

end

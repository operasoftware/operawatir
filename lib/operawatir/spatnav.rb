# -*- coding: utf-8 -*-
class OperaWatir::Spatnav

  attr_accessor :browser

  def initialize(browser)
    self.browser = browser
  end

  def up
    driver.operaAction('Navigate up')
  end

  def down
    driver.operaAction('Navigate down')
  end

  def left
    driver.operaAction('Navigate left')
  end

  def right
    driver.operaAction('Navigate right')
  end

  def activate
    driver.operaAction('Activate element')
  end

private
  def driver
    browser.driver
  end

end

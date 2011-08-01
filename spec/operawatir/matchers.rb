RSpec::Matchers.define :close_window do
  match { |actual| actual > 0 }
  
  failure_message_for_should do |window_id|
    "expected close_window to close window, but window_id returned is not valid: #{window_id}"
  end
end

RSpec::Matchers.define :close_dialog do |expected|
  match { |window_id| window_id > 0 }

  failure_message_for_should do |window_id|
    "expected close_dialog to close dialog, but window_id returned is not valid: #{window_id}"
  end
end 

RSpec::Matchers.define :close_menu do |expected|
  match { |name| name.length > 0 }
end

RSpec::Matchers.define :open_window do
  match { |actual| actual > 0 }
  
  failure_message_for_should do |window_id|
    "expected open_window to open window, but window_id returned is not valid: #{window_id}"
  end
end

RSpec::Matchers.define :open_dialog do
  match { |actual| actual > 0 }
  
  failure_message_for_should do |window_id|
    "expected open_dialog to close dialog, but window_id returned is not valid: #{window_id}"
  end
end

RSpec::Matchers.define :open_menu do |expected|
#  match { |actual| actual == expected } #menuname not accessible for mac, so leave this
  match { |name| name.length > 0 }
  
  #failure_message_for_should do |expected|
  #  "expected open_menu to open menu, #{expected}"
  #end
end


RSpec::Matchers.define :load_window do
  match { |actual| actual > 0 }
  
  failure_message_for_should do |window_id|
    "expected load... to load in window, but window_id returned is not valid: #{window_id}"
  end
end

RSpec::Matchers.define :load_page do
  match { |actual| actual > 0 }

  failure_message_for_should do |window_id|
    "expected load_page to load page, but window_id returned is not valid: #{window_id}"
  end
end

=begin
RSpec::Matchers.define :load do |expected|
  match do |actual|
    expected == actual
  end
end 
=end
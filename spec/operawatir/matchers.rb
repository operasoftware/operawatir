RSpec::Matchers.define :close_window do
  match do |actual|
    actual > 0
  end
  
  failure_message_for_should do |window_id|
    "expected close_window to close window, but window_id returned is not valid: #{window_id}"
  end
end

RSpec::Matchers.define :close_dialog do |expected|
  match do |window_id|
    window_id > 0
  end

  failure_message_for_should do |window_id|
    "expected close_dialog to close dialog, but window_id returned is not valid: #{window_id}"
  end
end 

RSpec::Matchers.define :open_window do
  match do |actual|
    actual > 0
  end
  
  failure_message_for_should do |window_id|
    "expected open_window to open window, but window_id returned is not valid: #{window_id}"
  end
end

RSpec::Matchers.define :open_dialog do
  match do |actual|
    actual > 0
  end
  
  failure_message_for_should do |window_id|
    "expected open_dialog to close dialog, but window_id returned is not valid: #{window_id}"
  end
end


RSpec::Matchers.define :load_window do
  match do |actual|
    actual > 0
  end
  
  failure_message_for_should do |window_id|
    "expected load... to load in window, but window_id returned is not valid: #{window_id}"
  end
end

RSpec::Matchers.define :load_page do
  match do |actual|
    actual > 0
  end
  
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
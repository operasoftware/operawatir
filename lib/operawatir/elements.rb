%w(web_element non_control_elements element button checkbox form image link
   radio select_list text_field).each {|elm| require "operawatir/elements/#{elm}"}

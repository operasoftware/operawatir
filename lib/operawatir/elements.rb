%w(web_element non_control_elements button checkbox element form image link
   radio select_list text_field file_field).each { |elm| require "operawatir/elements/#{elm}" }


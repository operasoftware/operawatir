require 'rubygems'
require 'java'
include Java

#mimics celerity/jwatir (for now)

lib_directory = File.dirname(__FILE__) + "/operawatir/"
element_directory = File.dirname(__FILE__) + "/operawatir/elements/"

Libraries = Dir[File.dirname(__FILE__) + '/operadriver/*.jar']
Libraries.each do |jar|
  require(jar)
end

include_class org.openqa.selenium.WebDriver;
include_class org.openqa.selenium.RenderedWebElement;
include_class org.openqa.selenium.NoSuchElementException;
include_class com.opera.core.systems.OperaDriver;
include_class com.opera.core.systems.OperaWebElement;

require lib_directory + "container"
require lib_directory + "browser"

web_elements = Array.new

Elements = Dir[element_directory + '*.rb']
Elements.each do |element|
  web_elements.push(element.chomp('.rb'))
end

base_web_element = element_directory + 'web_element'
non_control_elements = element_directory + 'non_control_elements'
checkbox_web_element = element_directory + 'checkbox'

require base_web_element
require non_control_elements
require checkbox_web_element

web_elements.delete(checkbox_web_element)
web_elements.delete(base_web_element)
web_elements.delete(non_control_elements)

web_elements.each { |web_element|
  require web_element
}

module OperaWatir

end

class OperaWatir::Selector
  include Deprecated

  BASE_TYPES << :selector
  alias_method :selector, :css
  deprecated :selector, "element(:css, 'foo')"
end

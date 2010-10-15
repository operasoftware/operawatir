# encoding: utf-8

%w(watirspec browser server runner guards).each do |f|
  require File.expand_path("../lib/#{f}", __FILE__)
end

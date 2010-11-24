module OperaWatir::Compat::Window
  
  {
    :area => :areas,
    :div => :divs,
    :button => :buttons,
    :dd => :dds,
    :del => :dels,
    :div => :divs,
    :dl => :dls,
    :dt => :dts,
    :em => :ems,
    :form => :forms,
    :hn => :hns,
    :ins => :inses,
    :label => :labels,
    :li => :lis,
    # :map => :maps,
    :meta => :metas,
    :ol => :ols
  }.each do |tag, collection|
    define_method(collection) do
      OperaWatir::Collection.new(self).tap do |c|
        c.add_selector :tag, tag
      end
    end
  end
  
end

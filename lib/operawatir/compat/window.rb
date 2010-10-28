module OperaWatir::Compat::Window
  
  # def self.def_legacy_collection(singular, plural, &blk)
  # end
  
  # def_legacy_collection :area, :areas do |collection|
  #   collection.add_selector :tag, :area
  # end
  
  def areas(*args, &blk)
    area(*args, &blk)
  end

end

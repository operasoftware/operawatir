class OperaWatir::Selector
    
  # def extract_value_from_arguments!(args)
  #   if args.first == :index
  #     self.type, self.value = *args
  #   else
  #     self.value = {args[0] => args[1]}
  #   end
  # end

  def find_elements_by_index(elements)
    if value >= 0 && value < elements.length
      [elements[value]]
    else
      []
    end
  end

end

module OperaWatir::Compat::ElementFinders

  def self.def_element(tag, plural, opts={}, &blk)
    blk = block_given? ? blk : lambda {|selector| selector.tag tag}

    default_method = opts[:how] || :id

    define_method tag do |*arguments|
      OperaWatir::Collection.new(self).tap do |c|
        blk.call c.selector
        c.add_selector_from_arguments arguments, default_method
      end
    end

    define_method plural do |*arguments|
      OperaWatir::Collection.new(self).tap do |c|
        blk.call c.selector
      end
    end
  end


  def_element :area, :areas

  def_element :button, :buttons, :how => :value do |selector|
    selector.join do |elm|
      elm.tag(:button)
      elm.tag(:input).join do |input|
        input.attribute :type => 'submit'
        input.attribute :type => 'button'
        input.attribute :type => 'image'
        input.attribute :type => 'reset'
      end
    end
  end

  def_element :checkbox, :checkboxes, :how => :name do |selector|
    selector.tag(:input).attribute :type => 'checkbox'
  end

  def_element :dd, :dds

  def_element :del, :dels

  def_element :div, :divs

  def_element :dl, :dls

  def_element :dt, :dts

  def_element :dt, :dts

  def_element :em, :ems

  def_element :file_field, :file_fields, :how => :name do |selector|
    selector.tag(:input).attribute :type => 'file'
  end

  def_element :form, :forms

  def_element :hidden, :hiddens, :how => :name do |selector|
    selector.tag(:input).attribute :type => 'hidden'
  end

  def_element :h1, :h1s

  def_element :h2, :h2s

  def_element :h3, :h3s

  def_element :h4, :h4s

  def_element :h5, :h5s

  def_element :h6, :h6s

  def_element :image, :images, :how => :src do |selector|
    selector.tag :img
  end

  def_element :ins, :inses

  def_element :label, :labels, :how => :text

  def_element :li, :lis

  # Oh, nevermind the ACTUAL LINK ELEMENT
  def_element :link, :links, :how => :href do |selector|
    selector.tag :a
  end

  def_element :map, :maps

  def_element :meta, :metas

  def_element :ol, :ols

  def_element :option, :options, :how => :text

  def_element :p, :ps

  def_element :pre, :pres

  def_element :radio, :radios, :how => :name do |selector|
    selector.tag(:input).attribute :type => 'radio'
  end

  def_element :select_list, :select_lists do |selector|
    selector.tag :select
  end

  def_element :span, :spans

  def_element :strong, :strongs

  # Oh, nevermind the ACTUAL BODY ELEMENT
  def_element :body, :bodies do |selector|
    selector.tag :tbody
  end

  def_element :cell, :cells do |selector|
    selector.tag :td
  end

  def_element :table_footer, :table_footers do |selector|
    selector.tag :tfoot
  end

  def_element :table_header, :table_headers do |selector|
    selector.tag :thead
  end

  def_element :table_row, :table_rows do |selector|
    selector.tag :tr
  end

  def_element :table, :tables

  def_element :text_field, :text_fields do |selector|
    selector.join do |elm|
      # TODO First test in element_spec.rb fails because we don't
      # treat inputs with unknown type attributes as text fields. We
      # could reverse this selector to include anything EXCEPT
      # checkbox, radio, submit, reset, file, hidden, image and
      # button. This would future proof it somewhat, but HTML5 types
      # such as "range" do not allow values to be typed in (at least
      # not in Opera)

      # empty type is text
      elm.tag(:input).attribute :type => ''
      elm.tag(:input).attribute :type => 'text'
      elm.tag(:input).attribute :type => 'password'
      elm.tag :textarea
    end
  end

  def_element :ul, :uls

end

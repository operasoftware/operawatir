module OperaWatir
  module DesktopContainer

    ######################################################################
    # Method for accessing a button element
    #
    # @example
    #   browser.quick_button(:name, "button_OK")
    #
    # @param [String] how   Method to find the element. :name, :text or :string_id of the button
    # @param [String] what  Search text to find the element with. Currently name, text or string_id
    #                       of the button
    #
    # @return [Object] button object if found, otherwise nil
    #
    def quick_button(how, what)
      what = [0, what] if how == :pos && (what.is_a? Fixnum)
      #if how == :pos
      #  if what.is_a? Fixnum
      #    what = [0, what]
      #  end
      #end
      QuickButton.new(self, how, what, parent_widget, window_id, :button)
    end

    ######################################################################
    # Method for accessing a tab button element
    #
    # @param [String] how   Method to find the element. :text and :pos is supported.
    # @param [String, FixNum] what  Search text or position to find the element with.
    #                         Currently text or position of the tab button, first tab button has position 0.
    #
    # @example
    #   browser.quick_window(:name, "Browser Window").quick_toolbar(:name, "Pagebar").quick_tab(:pos, 1)
    #   browser.quick_window(:name, "Browser Window").quick_toolbar(:name, "Pagebar").quick_tab(:text, "Connect to Debugger")
    #
    # @return [Object] tab button object if found, otherwise nil
    #
    def quick_tab(how, what)
      if how == :pos
        if what.is_a? Fixnum
          what = [0, what]
        end
      end
      QuickTab.new(self, how, what, parent_widget, window_id, :tabbutton)
    end

    ######################################################################
    # Method for accessing a checkbox element
    #
    # @example
    #   browser.quick_checkbox(:name, "Enable_wand_checkbox")
    #
    # @param [String] how   Method to find the element. :name, :text or :string_id
    # @param [String] what  Search text to find element with.
    #
    # @return [Object] checkbox object if found, otherwise nil
    #
    def quick_checkbox(how, what)
      QuickCheckbox.new(self, how, what, parent_widget, window_id, :checkbox)
    end

    ######################################################################
    # Method for accessing a tab on a tabbed dialog
    #
    # @example
    #   browser.quick_dialogtab(:name, "tab_prefs_forms")
    #
    # @param [String] how   Method to find the element. :name, :string_id or :text
    # @param [String] what  Search text to find the element with.
    #
    # @return [Object] dialog tab object if found, otherwise nil
    #
    def quick_dialogtab(how, what)
      QuickDialogTab.new(self, how, what, parent_widget, window_id, :dialogtab)
    end

    ######################################################################
    # Method for accessing a combobox (i.e. dropdown) element
    #
    # @example
    #   browser.quick_dropdown(:name, "Startup_mode_dropdown")
    #
    # @param [String] how   Method to find the element. :name, :string_id or :text
    # @param [String] what  Search text to find the element with.
    #
    # @return [Object] drop down object if found, otherwise nil
    #
    def quick_dropdown(how, what)
      QuickDropdown.new(self, how, what, parent_widget, window_id, :dropdown)
    end

    ######################################################################
    # Method for accessing a combobox (i.e. dropdown) element
    #
    # @example
    #   browser.quick_dropdown(:name, "Startup_mode_dropdown")
    #
    # @param [String] how   Method to find the element. :name, :string_id or :text
    # @param [String] what  Search text to find the element with.
    #
    # @return [Object] drop down object if found, otherwise nil
    #
    def quick_dropdownitem(how, what)
      QuickDropdownItem.new(self, how, what, parent_widget, window_id, :dropdownitem)
    end


   ######################################################################
   # Method for accessing a quickfind element
   #
   # @example
   #   browser.quick_find(:name, "Filetypes_quickfind")
   #
   # @param [String] how   Method to find the element. :name, :string_id or :text
   # @param [String] what  Search text to find the element with.
   #
   # @return [Object] quickfind object if found, otherwise nil
   #
   def quick_find(how, what)
     QuickFind.new(self, how, what, parent_widget, window_id, :quickfind)
   end

    ######################################################################
    # Method for accessing an edit or multiedit element
    #
    # @example
    #   browser.quick_editfield(:name, "Startpage_edit")
    #
    # @param [String] how   Method to find the element. :name, :string_id or :text
    # @param [String] what  Search text to find the element with.
    #
    # @return [Object] edit field object if found, otherwise nil
    #
    def quick_editfield(how, what)
      QuickEditField.new(self, how, what, parent_widget, window_id, :editfield)
    end

    ######################################################################
    # Method for accessing a label element
    #
    # @example
    #   browser.quick_label(:name, "label_for_Popups_dropdown")
    #
    # @param [String] how   Method to find the element. :name, :string_id or :text
    # @param [String] what  Search text to find the element with.
    #
    # @return [Object] label object if found, otherwise nil
    #
    def quick_label(how, what)
      QuickLabel.new(self, how, what, parent_widget, window_id, :label)
    end

    ######################################################################
    # Method for accessing a radio button element
    #
    # @example
    #   browser.quick_radiobutton(:name, "Accept_cookies_radio")
    #
    # @param [String] how   Method to find the element. :name, :string_id or :text
    # @param [String] what  Search text to find the element with.
    #
    # @return [Object] radio button object if found, otherwise nil
    #
    def quick_radiobutton(how, what)
      QuickRadioButton.new(self, how, what, parent_widget, window_id, :radiobutton)
    end

    ######################################################################
    # Method for accessing a tree view element
    #
    # @example
    #   browser.quick_treeview(:name, "Web_search_treeview")
    #
    # @param [String] how   Method to find the element. :name, :string_id or :text
    # @param [String] what  Search text to find the element with.
    #
    # @return [Object] treeview object if found, otherwise nil
    #
    def quick_treeview(how, what)
      QuickTreeView.new(self, how, what, parent_widget, window_id, :treeview)
    end

    ######################################################################
    # Method for accessing an addressfield object
    #
    # @example
    #   browser.quick_toolbar(:name, "Document Toolbar").quick_addressfield(:name, "tba_addressfield")
    #
    # @param [String] how   Method to find the element. :name, :string_id or :text
    # @param [String] what  Search text to find the element with.
    #
    # @return [Object] addressfield object if found, otherwise nil
    #
    def quick_addressfield(how, what)
        QuickAddressField.new(self, how, what, parent_widget, window_id, :addressfield)
    end

    ######################################################################
    # Method for accessing a searchfield element
    #
    # @example
    #   browser.quick_searchfield(:name, "Web_search_searchfield")
    #
    # @param [String] how   Method to find the element. :name, :string_id or :text
    # @param [String] what  Search text to find the element with.
    #
    # @return [Object] searchfield object if found, otherwise nil
    #
    def quick_searchfield(how, what)
      QuickSearchField.new(self, how, what, parent_widget, window_id, :search)
    end

    ######################################################################
    # Method for accessing a toolbar element
    #
    # @example
    #   browser.quick_toolbar(:name, "Document_toolbar")
    #
    # @param [String] how   Method to find the element. :name, :string_id or :text
    # @param [String] what  Search text to find the element with.
    #
    # @return [Object] toolbar object if found, otherwise nil
    #
    def quick_toolbar(how, what)
      QuickToolbar.new(self, how, what, parent_widget, window_id, :toolbar)
    end

    ######################################################################
    # Method for accessing a tree item in a treeview
    #
    # @example
    #   browser.quick_treeview(:name, "Server_treeview").quick_treeitem(:pos, [2,0])
    #
    # @param [String] how   Method to find the element. :name, :string_id or :text
    # @param [String] what  Search text to find the element with. Text or position
    #                        of treeitem. Position is specified as [row, column]
    #
    # @return [Object] treeitem object if found, otherwise nil
    #
    def quick_treeitem(how, what)
      QuickTreeItem.new(self, how, what, parent_widget, window_id, :treeitem)
    end

    ######################################################################
    # Method for accessing a grid item in a gridlayout
    #
    # @example (The label dialog for mail labels)
    #   browser.quick_gridlayout(:name, "RulesGrid").quick_griditem(:name, "GridItem0").quick_editfield(:name, "Match")
    #
    # @param [String] how   Method to find the element. :name, :string_id or :text
    # @param [String] what  Search text to find the element with. Text or position
    #                        of treeitem. Position is specified as [row, column]
    #
    # @return [Object] griditem object if found, otherwise nil
    #
    def quick_griditem(how, what)
      QuickGridItem.new(self, how, what, parent_widget, window_id, :griditem)
    end

    ######################################################################
    # Method for accessing a grid layout
    # (A grid layout would normally be used to specify the path to a child item in one of its cells.
    #
    # @example (The label dialog for mail labels)
    #   browser.quick_gridlayout(:name, "RulesGrid").quick_griditem(:name, "GridItem0").quick_editfield(:name, "Match")
    #
    # @param [String] how   Method to find the element. :name, :string_id or :text
    # @param [String] what  Search text to find the element with. Text or position
    #                        of treeitem. Position is specified as [row, column]
    #
    # @return [Object] gridlayout object if found, otherwise nil
    #
     def quick_gridlayout(how, what)
       QuickGridLayout.new(self, how, what, parent_widget, window_id, :gridlayout)
     end


    ######################################################################
    # Method for accessing a thumbnail (speeddial, thumbnail when  hovering tab groups)
    #
    # @example
    #   browser.quick_thumbnail(:name, "Thumbnail 1")
    #   browser.quick_thumbnail(:name, "Speed Dial 2")
    #
    # @param [String] how   Method to find the element. :name, :string_id or :text
    # @param [String] what  Search text to find the element with. Text or position
    #                        of treeitem. Position is specified as [row, column]
    #
    # @return [Object] thumbnail object if found, otherwise nil
    #
    def quick_thumbnail(how, what)
      if how == :pos
         if what.is_a? Fixnum
           what = [0, what]
         end
       end
      QuickThumbnail.new(self, how, what, parent_widget, window_id, :thumbnail)
    end

    ######################################################################
    # Method for accessing a window
    #
    # @example
    #   browser.quick_window(:name, "Browser Window")
    #   browser.quick_window(:name, "Document Window")
    #   browser.quick_window(:name, "Cycler Window")
    #
    # @param [String] how   Method to find the element. Currently only :name is supported
    # @param [String] what  or [int] window_id Search text to find the element with. Name of window
    #                       or the windows window_id
    #
    #
    # @return [Object] window object if found, otherwise nil
    #
    def quick_window(how, what)
      QuickWindow.new(self, how, what)
    end

    ##########################################################################
    # Method for accessing a menu
    #
    # @example
    #    browser.quick_menu(:name, "Main Menu")
    #
    # @param [String] how Method to find the element. Supported: :name
    # @param [String] what Search text to find the element with.
    #
    def quick_menu(how, what)
      if mac_internal?
        QuickMenu.new(self, how, what, nil)
      else
        QuickMenu.new(self, how, what, window_id)
      end
    end

    #############################################################################
    # Method for accessing a menuitem
    #
    # @example
    #     browser.quick_menu(:name, "Main Menu").quick_menuitem(:submenu, "Browser Tools Menu")
    #     browser.quick_menuitem(:name, "Browser File Menu")
    #     browser.quick_menuitem(:action, "Open page")
    #     browser.quick_menuitem(:name, "Open link, vg.no")
    #     browser.quick_menuitem(:string_id, "SOME_STRING_ID")
    #     browser.quick_menu(:name, "Main Menu").quick_menuitem(:acckey, "b")
    #     browser.quick_menu(:name, "Edit Item Popup Menu").quick_menuitem(:pos, 2)
    #
    #
    # @param [String] how Method to find the element. Supported: name, text, string_id, action
    #                      submenu, pos, acckey, shortcut.
    #                      The item name is:
    #                      - if the item has an action, the action
    #                      - if the item has an action with a parameter; "<action>, <actionparameter>"
    #                      - else if the item opens a submenu, the submenuname
    #
    #                     An acckey and pos are unique only within a given menu, so in this case
    #                     the accesspath to specify the item should include the menu
    #
    #
    #                     Note that only methods that identify a unique item gives a predictable result
    # @param [String] what Search text to find element with
    #
    def quick_menuitem(how, what)
      if mac_internal? || (window_id != nil && window_id <= 0)
          QuickMenuItem.new(self, how, what, name == 'Opera' ? nil : name)
      else
        QuickMenuItem.new(self, how, what, window_id)
      end
    end

  end
end


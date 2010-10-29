%w(quick_widget quick_button quick_checkbox quick_editfield 
    quick_dropdown quick_dialogtab quick_label quick_radiobutton quick_treeview quick_addressfield 
    quick_searchfield quick_toolbar quick_window quick_tab quick_treeitem).each {|widget| require "operawatir/quickwidgets/#{widget}"}

class AudioTableScreen < PM::GroupedTableScreen

  title "Back"

  def will_appear
    self.setTitle "Sounds"
  end

  def on_load
    # set_nav_bar_right_button("Save", action: :save)
    # set_tab_bar_item(title: "Settings", icon: "settings.png")

    set_nav_bar_right_button "Done", action: :close, type: UIBarButtonItemStyleDone
    # self.navigationController.setToolbarHidden(false)
    # self.toolbarItems = [dont_show_button, flexible_space, purchase_button]
  end

  # table_data is automatically called. Use this format in the return value.
  # It's an array of cell groups, each cell group consisting of a title and an array of cells.
  def table_data

    cells = []

    (1..10).each do |num|
      cells << {
        title: "Sound #{num}",
        cell_identifier: "AudioCell",
        action: :open_recorder,
        arguments: { :audio_number => num, :name => "Sound #{num}" }
        # accessory: {
        #   view: :switch, # UIView or :switch
        #   value: true, # whether it's "checked" or not
        #   action: :accessory_switched,
        #   arguments: { some_arg: true } # :value is passed in if a hash
        # }
      }
    end

    return [{cells: cells}]
  end

  def table(table, canEditRowAtIndexPath: path)
    false
  end

  # This method allows you to create a "jumplist", the index on the right side of the table
  # def table_data_index
  #   # Ruby magic to make an alphabetical array of letters.
  #   # Try this in Objective-C and tell me you want to go back.
  #   return ("A".."Z").to_a
  # end

  # Your table cells, when tapped, will execute the corresponding actions
  # and pass in the specified arguments.
  def open_recorder(args={})
    # puts "Tapped Cell with id: #{args[:id]}" # => 3
    open AudioRecordingScreen.new(args)
  end

  # def close_modal
  #   self.navigationController.dismissModalViewControllerAnimated(true)
  # end

end
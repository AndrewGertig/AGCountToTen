class SettingsScreen < PM::GroupedTableScreen

title "Settings"

attr_accessor :use_custom_audio

def will_appear
  # self.setTitle "Sounds"
end

def on_load
  set_nav_bar_right_button "Done", action: :close, type: UIBarButtonItemStyleDone

  # self.use_custom_audio = false
  # App::Persistence['channels']

end

# table_data is automatically called. Use this format in the return value.
# It's an array of cell groups, each cell group consisting of a title and an array of cells.
def table_data

  cells = [{
        title: "Record Custom Sounds",
        cell_identifier: "CustomSoundsCell",
        action: :open_custom
      },{
        title: "Use Custom Sounds?",
        cell_identifier: "UseCustomCell",
        action: nil,
        # arguments: { :audio_number => num }
        accessory: {
          view: :switch, # UIView or :switch
          value: App::Persistence['use_custom_audio'], # whether it's "checked" or not
          action: :accessory_switched,
          arguments: { some_arg: "testing"} # :value is passed in if a hash
        }
      }]

  # (1..10).each do |num|
  #   cells << {
  #     title: "Sound #{num}",
  #     cell_identifier: "AudioCell",
  #     action: :open_recorder,
  #     arguments: { :audio_number => num, :name => "Sound #{num}" }
  #     # accessory: {
  #     #   view: :switch, # UIView or :switch
  #     #   value: true, # whether it's "checked" or not
  #     #   action: :accessory_switched,
  #     #   arguments: { some_arg: true } # :value is passed in if a hash
  #     # }
  #   }
  # end

  return [{cells: cells}]
end

# def table(table, canEditRowAtIndexPath: path)
#   false
# end

# Your table cells, when tapped, will execute the corresponding actions
# and pass in the specified arguments.
def open_custom(args={})
  # puts "Tapped Cell with id: #{args[:id]}" # => 3
  open AudioTableScreen.new(args)
end

def accessory_switched(args={})
  puts "passed in #{args[:some_arg]}"

  App::Persistence['use_custom_audio'] = !App::Persistence['use_custom_audio']

end

end
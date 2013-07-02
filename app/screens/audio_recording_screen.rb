class AudioRecordingScreen < PM::Screen

  attr_accessor :audio_number, :name

  def on_init
    self.setTitle self.name if self.name
  end

  def on_load
    # set_tab_bar_item system_icon: UITabBarSystemItemContacts
    # set_tab_bar_item title: "Tab Name Goes Here", icon: "icons/tab_icon.png" # in resources/icons folder

    @recorder = Recorder.new
    @isRecording = false

    @tempFile = FileUrl.new(self.audio_number)
    @recording_url = @tempFile.url if @tempFile.exists

    ui = UI.new(view.frame.size.width)

    @recordButton = ui.createButton(200, 'recordAndStopButtonTapped', 'Record', self)
    @playButton = ui.createButton(320, 'playButtonTapped', 'Play', self)
    # @textField = ui.createTextField(self)

    view.addSubview(@recordButton)
    view.addSubview(@playButton)
    # view.addSubview(@textField)

  end

  def newRecording(file_name)
    puts "Create new Recording at: #{file_name} .caf"
    @fileUrl = FileUrl.new(file_name)
    @recording = @recorder.newRecorder(@fileUrl.url) 

    # unless @fileUrl.exists
    #   puts "Create new Recording at: #{file_name} .caf"
    # end
  end

  def recordAndStopButtonTapped

    # Stop Button Pressed
    if @isRecording
      @recording.stop
      @recording_url = @fileUrl.url
      # @fileUrl.renameFileTo("renamed")
    # Record Button Pressed
    else
      newRecording(self.audio_number) unless @fileUrl #@tempFile.exists
      @recording.record
    end

    @recordButton.selected = !@recordButton.selected?
    @isRecording = !@isRecording

  end

  def playButtonTapped
    play
  end

  def play
    if @recording_url
      @player = Player.new @recording_url
      @player.play
    end
  end

  def recordButton
    @recordButton
  end

  def playButton
    @playButton
  end

  def doNothing
  end

end
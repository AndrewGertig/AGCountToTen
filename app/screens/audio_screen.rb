class OldAudioScreen < PM::Screen

  title "Just Audio"

  def on_load

    set_tab_bar_item system_icon: UITabBarSystemItemFavorites

    self.view.backgroundColor = UIColor.cyanColor

    @button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    @button.setTitle("record", forState:UIControlStateNormal)
    @button.sizeToFit
    @button.center = CGPointMake(self.view.frame.size.width / 2, 80)
    @button.addTarget(self, action:"startStopButton",
                            forControlEvents:UIControlEventTouchUpInside)
    self.view.addSubview @button

    @play = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    @play.setTitle("Play Sound", forState:UIControlStateNormal)
    @play.sizeToFit
    @play.center = CGPointMake(self.view.frame.size.width / 2, @button.center.y + 70)
    @play.addTarget(self, action:"playSound",
                                  forControlEvents:UIControlEventTouchUpInside)
    self.view.addSubview(@play)

  end

  def playSound
    player = AVAudioPlayer.alloc.initWithContentsOfURL @recorder.url("gertig"), error:nil
    player.delegate = self

    puts "Play from #{@recorder.url("gertig")}"
    player.play
  end

  def startStopButton
    if @recorder && @recorder.recording?
      stopRecording
      @button.setTitle "record", forState:UIControlStateNormal
    else
      startRecording
      @button.setTitle "stop", forState:UIControlStateNormal
    end
  end

  def startRecording
    session = AVAudioSession.sharedInstance

    err_ptr = Pointer.new :object
    session.setCategory AVAudioSessionCategoryRecord, error:err_ptr

    return handleAudioError(err_ptr[0]) if err_ptr[0]

    @recorder = AVAudioRecorder.alloc.initWithURL url, settings:settings, error:err_ptr
    @recorder.setMeteringEnabled(true)
    @recorder.delegate = self;

    # start recording
    if @recorder.prepareToRecord
      puts "RECORDING!!!!"
      @recorder.record
    else
      raise "prepareToRecord false" unless err_ptr[0]
      return handleAudioError(err_ptr[0])
    end

  end

  def stopRecording
    @recorder.stop if @recorder
  end

  def url
    return @recording_url if @recording_url
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true)
    path = dirPaths[0].stringByAppendingPathComponent("gertig_sound.caf")

    # path = NSTemporaryDirectory().stringByAppendingPathComponent("gertig_recording.caf")
    @recording_url = NSURL.fileURLWithPath(path)
  end

  def settings
    @settings ||= {
      :AVFormatIDKey => KAudioFormatLinearPCM,
      :AVNumberOfChannelsKey => 1,
      :AVEncoderBitRateKey => 2,
      :AVSampleRateKey => nil
    }
  end


end
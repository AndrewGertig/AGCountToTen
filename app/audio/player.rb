class Player
  
  def initialize recording_url, loop=false
    err = Pointer.new(:object)
    @avPlayer = AVAudioPlayer.alloc.initWithContentsOfURL(recording_url, error:err)
    @avPlayer.prepareToPlay
  end

  def play
    @avPlayer.play
  end

  def stop
    @avPlayer.stop
  end

end

class AppDelegate < PM::Delegate

  def on_load(app, options)
    open MainScreen.new(nav_bar: false)
    # open HomeScreen.new(nav_bar: true)

    # @boop   = BoopScreen.new(nav_bar: true)
    # @audio  = AudioTableScreen.new(nav_bar: true)
    # open @audio
    # @settings = SettingsScreen.new

    # open_tab_bar  @boop, @audio #@boop, @old_audio
  end

end
class AppDelegate < PM::Delegate

  def on_load(app, options)
    open MainScreen.new(nav_bar: false)

    # set use_custom_audio to false the first time the app is opened
    App::Persistence['use_custom_audio'] = false if App::Persistence['use_custom_audio'].nil?
  end

end
# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'
# require 'bubble-wrap/core'

require 'bundler'
Bundler.require # :default

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  # app.icons = ['icon_iphone.png', 'icon_iphone_retina.png'] #, 'icon_ipad.png', 'icon_ipad_retina.png']
  app.prerendered_icon = true
  app.name = 'Ten'
  app.deployment_target = "6.0"
  app.device_family = [:iphone]
  app.interface_orientations = [:portrait]
  app.identifier = "com.siftedwheat.Ten"
  app.version = "1.0.0"
  app.frameworks += %w(CoreAudio AVFoundation AudioToolbox) # += adds these frameworks to the array of frameworks

  # app.short_version = "0.1.0"
  # app.frameworks += %w(AVFoundation CoreVideo CoreMedia ImageIO QuartzCore)

  app.development do
    app.entitlements['get-task-allow'] = true
    app.codesign_certificate = "iPhone Developer: Andrew Gertig (CY6MJV42S8)"
    app.provisioning_profile = "./provisioning/iOS_Team_Provisioning_Profile.mobileprovision"
  end
  

  app.release do
    app.entitlements['get-task-allow'] = false
    app.codesign_certificate = "iPhone Distribution: SiftedWheat LLC (34L8B5PX3W)"
    app.provisioning_profile = "./provisioning/TenApp.mobileprovision"
  end
end


require './lib/mulberry.rb'

namespace :mulberry do
  desc "Scrapes the websites and updates data.json"
  task :update do
    Mulberry.update
  end
end

namespace :applet do
  namespace :dev do
    desc "Symlinks the applet into the squeezeplay dev build applet dir"
    task :ln do
      ln_s File.expand_path("./lib/applet"), Applet.squeezeplay_applet_dir
    end
  end

  desc "SCP applet to controller"
  task :install do
    puts %x[scp -r -v #{APPLET_DIR}/* squeezebox_controller:/usr/share/jive/applets/#{Applet.name}]
  end
end

module Applet
  class << self
    # squeezeplay convention is to name the meta/applet files
    # $APPLET_NAMEmeta.lua etc.
    def name
      File.basename(Dir["#{APPLET_DIR}/*Meta.lua"].first).split("Meta").first
    end

    def squeezeplay_applet_dir
      if ENV["SQUEEZEPLAY_DIR"].nil? || ENV["SQUEEZEPLAY_DIR"].empty?
        raise "You must set $SQUEEZEPLAY_DIR environment variable"
      end
      File.join(ENV["SQUEEZEPLAY_DIR"], "share", "jive", "applets", Applet.name)
    end
  end
end

require './lib/mulberry.rb'

DEV_SQ_APPLET_DIR = File.expand_path('~/dev/xp/squeezeplay/build/linux/share/jive/applets')

namespace :applet do
  namespace :dev do
    desc "Symlinks the applet into the squeezeplay dev build applet dir"
    task :ln do
      ln_s File.expand_path("./lib/applet"), Applet.dev_dir
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

    def dev_dir
      File.join(DEV_SQ_APPLET_DIR, Applet.name)
    end
  end
end

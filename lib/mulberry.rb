require "rubygems"
require "bundler/setup"

require 'i18n'
require 'active_support/inflector'
require 'nokogiri'
require 'open-uri'
require 'yaml'
require 'json'

ROOT       = File.expand_path(File.dirname(__FILE__) + '/../')
DATA_DIR   = File.join(ROOT, 'data')
PUBLIC_DIR = File.join(ROOT, 'public')
TMP_DIR    = File.join(ROOT, 'tmp')
APPLET_DIR = File.expand_path(File.join(ROOT, "lib", "applet"))

Dir[File.join(ROOT, "lib", "*rb")].each { |f| require f }
Dir[File.join(ROOT, "lib", "sources", "*rb")].each { |f| require f }

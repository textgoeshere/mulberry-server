require "rubygems"
require "bundler/setup"

require 'i18n'
require 'active_support/inflector'
require 'nokogiri'
require 'open-uri'
require 'yaml'


ROOT     = File.expand_path(File.dirname(__FILE__) + '/../')
DATA_DIR = File.join ROOT, '/data'

require File.join ROOT, '/lib/strategies'
require File.join ROOT, '/lib/source'

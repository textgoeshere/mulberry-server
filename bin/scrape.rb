#!/usr/bin/env ruby

require 'rubygems'
require 'active_support/inflector'
require 'nokogiri'
require 'open-uri'
require 'yaml'

ROOT     = File.expand_path(File.dirname(__FILE__) + '/../')
DATA_DIR = File.join ROOT, '/data'

class ContentStrategy
  def initialize(url)
    @doc = Nokogiri::HTML(open url)
  end

  def content; end
end

class Google < ContentStrategy
  def content
    @doc.search("tr.line")
  end
end

class Stib < ContentStrategy; end

class Sncb < ContentStrategy
  def initialize(url)
    date = Date.today.strftime("%d/%m/%y") # 13/11/10
    time = Time.now.strftime("%H:%M") # 14:33

    parsed_url = url.gsub(/^(.*)\$TIME(.*)\$DATE(.*)$/, "\\1#{time}\\2#{date}\\3")
    super(parsed_url)
  end
end

class Source
  attr_accessor :location, :direction, :vehicle, :source, :url

  def initialize(opts)
    @location  = opts.delete "location"
    @direction = opts.delete "direction"
    @vehicle   = opts.delete "vehicle"
    @source    = opts.delete "source"
    @url       = opts.delete "url"
  end

  def scrape
    puts "Scraping #{location} #{direction} from #{source}"
    @content = content_strategy.new(url).content
  end
  
  def content_strategy
    source.capitalize.constantize
  end
end

SOURCES = YAML.load(open File.join(DATA_DIR, '/sources.yml')).map { |s| Source.new s }

SOURCES.each do |s|
  s.scrape
end

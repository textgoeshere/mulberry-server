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

class Stib < ContentStrategy
  def content
    @doc.search("ul.realtime_list li")
  end
end

class Sncb < ContentStrategy
  def initialize(url)
    date = Date.today.strftime("%d/%m/%y") # 13/11/10
    time = Time.now.strftime("%H:%M") # 14:33

    parsed_url = url.gsub(/^(.*)\$TIME(.*)\$DATE(.*)$/, "\\1#{time}\\2#{date}\\3")
    super(parsed_url)
  end

  def content
    @doc.search("p.journey")
  end
end

class Source
  attr_accessor :location, :direction, :vehicle, :source, :url
  attr_reader :content
    
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

html = ""
SOURCES.each do |s|
  s.scrape
  html << "<h1>#{s.location} to #{s.direction} via #{s.vehicle}</h1>"
  html << s.content.map(&:inner_html).join("<hr>")
end

File.open(File.join(ROOT, 'public', "timetable_#{Time.now}.html"), "w") { |f| f << html }

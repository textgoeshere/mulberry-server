#!/usr/bin/env ruby
require File.dirname(__FILE__) + '/../lib/mulberry.rb'

SOURCES = YAML.load(open File.join(DATA_DIR, '/sources.yml'))

html = ""
SOURCES.each do |s|
  puts "Scraping #{s.name} [#{s.class.name}]"
  html << "<h1><a href=\"#{s.url}\">#{s.location} to #{s.direction} via #{s.vehicle} #{s.service}</a></h1>"
  html << s.content.inner_html
  html << "<hr>"
end

File.open(File.join(ROOT, 'public', "timetable_#{Time.now}.html"), "w") { |f| f << html }

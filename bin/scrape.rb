#!/usr/bin/env ruby

require File.dirname(__FILE__) + '/../lib/mulberry.rb'

# TODO: extract:
# * distance of time in minutes of next service
# * any special notifications (train)
# * name of vehicle
# Create partials and layout

SOURCES = YAML.load(open File.join(DATA_DIR, '/sources.yml')).map { |s| Source.new s }

html = ""
SOURCES.each do |s|
  s.scrape
  html << "<h1>#{s.location} to #{s.direction} via #{s.vehicle}</h1>"
  html << s.content.map(&:inner_html).join("<hr>")
end

File.open(File.join(ROOT, 'public', "timetable_#{Time.now}.html"), "w") { |f| f << html }

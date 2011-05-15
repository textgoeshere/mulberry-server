#!/usr/bin/env ruby

require File.dirname(__FILE__) + '/../lib/mulberry.rb'

SOURCES = YAML.load(open File.join(DATA_DIR, '/sources.yml'))

File.open(File.join(PUBLIC_DIR, "data.json"), "w") do |f|
  f << SOURCES.inject({}) { |h, s| h[s.name] = s; h }.to_json
end

File.open(File.join(TMP_DIR, "timetable_#{Time.now}.html"), "w") do |f| 
  SOURCES.sort.each do |s|
    f << "<h1><a href=\"#{s.url}\">#{s.description}</a></h1>"
    f << s.departures.map { |d| "<p>#{d}</p>" }.join
    f << "<hr>"
  end
end

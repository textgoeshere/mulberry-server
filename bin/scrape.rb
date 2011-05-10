#!/usr/bin/env ruby
require File.dirname(__FILE__) + '/../lib/mulberry.rb'

t = Time.now

SOURCES = YAML.load(open File.join(DATA_DIR, '/sources.yml'))

html = ""
lua  = ""
SOURCES.sort.each do |s|
  puts "Scraping #{s.name} [#{s.class.name}]"
  html << "<h1><a href=\"#{s.url}\">#{s.description}</a></h1>"
  html << s.departures.map { |d| "<p>#{d}</p>" }.join
  html << "<hr>"

  lua << %Q{
Entry{
  source = "#{s.name}",
  title  = "#{s.title}",
  description = "#{s.description}",
  name = "#{s.name}",
  location = "#{s.location}",
  updated_at = "#{t}",
  weight = #{s.weight},
  departures = [[
#{s.departures.join("\n")}
  ]],
  vehicle = "#{s.vehicle}"
}
}
end

File.open(File.join(ROOT, 'public', "timetable_#{Time.now}.html"), "w") { |f| f << html }
File.open(File.join(APPLET_DIR, "entries.lua"), "w") { |f| f << lua }

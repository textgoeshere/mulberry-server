#!/usr/bin/env ruby
require File.join(File.dirname(__FILE__),  '/../spec_helper')

SOURCES = YAML.load(open File.join(DATA_DIR, '/sources.yml')).map { |s| Source.new s }

SOURCES.each do |s|
  File.open("#{s.name}.html", "w") { |f| f << s.html }
end


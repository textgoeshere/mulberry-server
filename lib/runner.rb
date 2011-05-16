module Mulberry
  def self.update
    File.open(File.join(TMP_DIR, "timetable_#{Time.now}.html"), "w") do |f| 
      sources.sort.each do |s|
        puts "Scraping #{s.name}"
        f << "<h1><a href=\"#{s.url}\">#{s.description}</a></h1>"
        f << s.departures.map { |d| "<p>#{d}</p>" }.join
        f << "<hr>"
      end
    end

    File.open(File.join(PUBLIC_DIR, "data.json"), "w") do |f|
      f << sources.inject({}) { |h, s| h.tap {  h[s.name] = s } }.to_json
    end
  end

  def self.sources
    @sources ||= YAML.load(open File.join(DATA_DIR, '/sources.yml'))
  end
end

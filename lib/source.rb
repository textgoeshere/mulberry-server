class Source
  attr_accessor :location, :direction, :vehicle, :source, :url
  attr_reader :content, :html
    
  def initialize(opts)
    @location  = opts.delete "location"
    @direction = opts.delete "direction"
    @vehicle   = opts.delete "vehicle"
    @source    = opts.delete "source"
    @url       = opts.delete "url"
    
    @cs        = content_strategy.new(url)
    @html      = @cs.doc.to_s
  end

  def name
    [location, direction, vehicle, source].map { |str| str.gsub(/\W/, '-') }.join("-")
  end

  def scrape
    puts "Scraping #{location} -> #{direction} [#{source}]"
    @content = @cs.content
  end
  
  def content_strategy
    source.capitalize.constantize
  end
end

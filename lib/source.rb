# TODO: error handling
# TODO: notes + warnings (span.class="info")

module Source
  attr_accessor :location, :direction, :vehicle, :source, :url, :service
  attr_reader :html, :doc, :content
  
  def initialize(opts)
    @location  = opts.delete "location"
    @direction = opts.delete "direction"
    @vehicle   = opts.delete "vehicle"
    @url       = opts.delete "url"
    @service   = opts.delete "service"
  end

  def doc
    @doc ||= Nokogiri::HTML(open url)
  end

  def html
    @html ||= doc.to_s
  end
  
  def name
    @name ||= [location, direction, vehicle, source].map { |str| str.gsub(/\W/, '-') }.join("-")
  end

  def departures
    []
  end
  
  def source
    self.class.name.downcase
  end
end

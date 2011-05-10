# TODO: error handling
# TODO: notes + warnings (span.class="info")

module Source
  include Comparable
  
  attr_accessor :location, :direction, :vehicle, :source, :url, :service, :weight
  attr_reader :html, :doc, :content
  
  def initialize(opts)
    @location  = opts.delete "location"
    @direction = opts.delete "direction"
    @vehicle   = opts.delete "vehicle"
    @url       = opts.delete "url"
    @service   = opts.delete "service"
    @weight    = opts.delete "weight"
  end

  def <=>(other)
    self.weight <=> other.weight
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

  def description
    "#{location} to #{direction} on #{vehicle} #{service}"
  end

  def title
    "#{service} to #{direction}"
  end
  
  def departures
    []
  end

  def weight
    @weight || 100000 # an arbitrarily big number so unweighted sources
                      # sink to the bottom
  end
  
  def source
    self.class.name.downcase
  end
end

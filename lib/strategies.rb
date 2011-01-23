class ContentStrategy
  attr_reader :doc
  
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

class Sncb
  include Source
    
  def initialize(*args)
    super
    
    date = Date.today.strftime("%d/%m/%y") # 13/11/10
    time = Time.now.strftime("%H:%M") # 14:33

    @url = @url.gsub(/^(.*)\$TIME(.*)\$DATE(.*)$/, "\\1#{time}\\2#{date}\\3")
  end

  def content
    doc.search("p.journey")
  end
end

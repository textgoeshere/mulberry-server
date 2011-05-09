class Sncb
  include Source

  def content
    doc.search("p.journey")
  end

  def departures
    content.inject([]) do |arr, node|
      arr.tap do
        next unless node.text =~ /Bruxelles-Midi/
        time = node.search("strong").last.text
        arr << "#{time}, Bruxelles-Midi"
      end
    end[0..1]
  end

  def url
    date = Date.today.strftime("%d/%m/%y") # 13/11/10
    time = Time.now.strftime("%H:%M") # 14:33
    
    @url.gsub(/^(.*)\$TIME(.*)$/, "\\1#{time}\\2").gsub(/^(.*)\$DATE(.*)$/, "\\1#{date}\\2") if @url
  end
end

class Stib
  include Source
  
  def content
    doc.search("ul.realtime_list li")
  end

  def departures
    content[0..1].map do |li|
      time = li.search("h5").first.text.split.first.to_i
      destination = li.search("p").first.text.strip.titleize
      "#{time} mins, #{destination}"
    end
  end
end

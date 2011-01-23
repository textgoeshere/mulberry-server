class Stib
  include Source

  def content
    doc.search("ul.realtime_list li")
  end

  def arrives
    content.search("h5").map { |el| el.text.split.first.to_i }[0..1]
  end
end

class Google
  include Source
  
  def content
    doc.search("tr.line")
  end
end

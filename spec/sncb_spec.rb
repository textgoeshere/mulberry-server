require "spec_helper"

describe Sncb do
  it "substitutes current date and time into query string in the url" do
    Date.stub_chain(:today, :strftime).and_return("__DATE__")
    Time.stub_chain(:now, :strftime).and_return("__TIME__")
    s = Sncb.new("url" => "http://anurl.com?something$DATEsomething$TIMEsomething")
    s.url.should =~ /__DATE__/
    s.url.should =~ /__TIME__/
  end
end

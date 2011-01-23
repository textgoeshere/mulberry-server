require 'spec_helper'

describe Stib do
  before :all do
    @s = Stib.new(SOURCES.first)
  end

  it "finds the distance of time in minutes of the arrival of the next two buses" do
    @s.arrivals_in.should == ["08 min.", "19 min."]
  end

  it "checks the correct web page" do
    @s.doc.search("h2").text.should =~ /#{@s.location}/i
  end
end

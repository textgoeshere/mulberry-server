require 'spec_helper'

describe "Sources" do
  let(:arrivals) { YAML.load(open File.join(ROOT, '/spec/fixtures/arrivals.yml')) }

  SOURCES.each do |s|
    context s do

      let(:source) { s.tap do
          s.url = File.join(File.dirname(__FILE__), "fixtures/#{s.name}.html")
        end      
      }

      it "finds the correct arrival times for #{s.name}" do
        source.arrives.should == arrivals[source.name]
      end
    end
  end
end

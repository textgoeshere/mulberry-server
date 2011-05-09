require 'spec_helper'

describe "Sources" do
  let(:departures) { YAML.load(open File.join(ROOT, '/spec/fixtures/departures.yml')) }

  SOURCES.each do |s|
    context s do

      let(:source) { s.tap do
          s.url = File.join(File.dirname(__FILE__), "fixtures/#{s.name}.html")
        end      
      }

      let(:expected_source_departures) { departures[source.name] }

      it "finds the correct departure times and destination for #{s.name}" do
        source.departures.should == expected_source_departures
      end
    end
  end
end

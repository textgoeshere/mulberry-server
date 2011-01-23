require File.join(File.dirname(__FILE__), "/../lib/mulberry")
Bundler.setup(:test)

module Source
  def url
    File.join(File.dirname(__FILE__), "fixtures/#{name}.html")
  end
end
SOURCES = YAML.load(open File.join(DATA_DIR, '/sources.yml'))


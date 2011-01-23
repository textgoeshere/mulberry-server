require File.join(File.dirname(__FILE__), "/../lib/mulberry")
Bundler.setup(:test)

SOURCES = YAML.load(open File.join(DATA_DIR, '/sources.yml'))



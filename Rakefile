require './lib/mulberry.rb'

namespace :mulberry do
  desc "Scrapes the websites and updates data.json"
  task :update do
    Mulberry.update
  end

  desc "Deletes data and tmp files"
  task :clean do
    Mulberry.clean
  end
end

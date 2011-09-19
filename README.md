Simple scripts to scrape websites and serve data for our home dashboard.

Designed to be the JSON endpoint for
https://github.com/textgoeshere/mulberry-squeezeplay-client and https://github.com/textgoeshere/mulberry-touchpad-client.

# Requirements #

* Ruby, Rubygems, and the Bundler gem for the server

# Install #

    # Setup server
    bundle install

    # Start server daemon
    cd public
    thin -A file -d start

    # Fetch some data and write the JSON
    rake mulberry:update

    # Example crontab entry to update data every 2 minutes
    # */2 * * * * bash -l -c 'cd $PATH_TO_MULBERRY && bundle exec rake mulberry:update'

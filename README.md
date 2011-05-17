This is an applet for Squeezeplay devices (e.g. controllers and
radios), part of the [Squeezebox/SqueezeOS family of devices](http://www.logitech.com/en-us/speakers-audio/wireless-music-systems). 

It shows how you can write a a bit of Lua to consume and display
realtime-ish data from a JSON endpoint. With nice icons.

On the server side, local transport websites are scraped for departure
info, which is served as JSON. The device requests this JSON when the
menu item is selected and shows the departure info. Simples.

# Requirements #

* Ruby, Rubygems, and the Bundler gem for the server
* You must [enable remote login on the Squeezeplay device](http://wiki.slimdevices.com/index.php/SqueezePlay_Applets#Manual_installation). Make a note of the IP address and the password

# Install #

    git clone https://github.com/textgoeshere/mulberry.git

    # scp the applet to the device (you can use IP or hostname here)
    rake applet:install device=HOSTNAME_OF_SQUEEZEPLAY_DEVICE server=HOSTNAME_OF_SERVER

    # Setup server
    bundle install

    # Start server daemon
    cd public
    thin -A file -d start

    # Fetch some data and write the JSON
    rake mulberry:update

    # Example crontab entry to update data every 2 minutes
    # */2 * * * * bash -l -c 'cd $PATH_TO_MULBERRY && bundle exec rake mulberry:update'

Now restart (power cycle) the Squeezeplay device.

You should see a menu item "Live Travel Item". Click through to see a
list of travel services and departure times.    

# Development #

First [build SqueezeOS](http://wiki.slimdevices.com/index.php/SqueezePlay_Build_Instructions).

Then, in the `mulberry` directory:

    rake applet:dev:ln squeezeplay_path=$YOUR_PATH_TO_SQUEEZEPLAY

This symlinks the applet from `mulberry` into the Squeezeplay applet
directory. The applet will then be loaded when Squeezeplay is restarted. 

`$YOUR_PATH_SQUEEZEPLAY` must be the path to the _build_ directory
(where `Make` output), not the source.

You have to restart Squeezeplay every time you make a change to the
Lua source.

Look in `data.yml` and the content of `lib/sources` to see how to
customize the scrapers.

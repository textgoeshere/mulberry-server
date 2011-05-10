--[[
=head1 NAME

applets.TravelInfo.TravelApplet - Live Travel Info Applet

=head1 DESCRIPTION

Displays live departure board

=head1 FUNCTIONS

Applet related methods are described in L<jive.Applet>. 

=cut
--]]


-- stuff we use
local oo                     = require("loop.simple")
local string                 = require("string")
local io                     = require("io")

local Applet                 = require("jive.Applet")
local Window                 = require("jive.ui.Window")
local Textarea               = require('jive.ui.Textarea')
local Label                  = require('jive.ui.Label')
local SimpleMenu             = require("jive.ui.SimpleMenu")
local Icon                   = require("jive.ui.Icon")
local System                 = require("jive.System")
local Surface                = require("jive.ui.Surface")

local tostring               = tostring
local require                = require
local package                = package
local pairs                  = pairs
local table                  = table

local entries = {}
local entries_filename = "applets/TravelInfo/entries"

function Entry(e) entries[e.source] = e end

module(...)
oo.class(_M, Applet)

function menu(self, menuItem)
   local menu  = SimpleMenu("menu")

   require(entries_filename)
   package.loaded[entries_filename] = nil

   for _, entry in pairs(entries) do
      local image = Surface:loadImage("applets/TravelInfo/" .. entry.vehicle .. ".png")
      local icon  = Icon("icon", image)
      menu:addItem({
                      text = entry.title,
                      weight = entry.weight,
                      icon = icon,
                      sound = "WINDOWSHOW",
                      callback = function()
                                    self:showEntry(entry)
                                 end
                   })
   end
   
   local window = Window("window", "Travel")

   menu:setComparator(menu.itemComparatorWeightAlpha)
   window:addWidget(menu)
   window:show()
end

function showEntry(self, entry)
   -- TODO: timer and reload

   -- If this menu is added, the textarea widget does not show in the controller
   -- local menu = SimpleMenu("menu", {
   --                            { text = "Back",
   --                              sound = "WINDOWHIDE",
   --                              callback = function()
   --                                            window:hide()
   --                                         end
   --                           }
   --                         })


   require(entries_filename)
   package.loaded[entries_filename] = nil

   local e        = entries[entry.source]
   local window   = Window("text_list", e.title) 
   local textarea = Textarea("text", (e.description .. "\n\n----\n" .. e.departures .. "\n\n----\nUpdated at: " .. e.updated_at))

   window:addWidget(textarea)
   -- window:addWidget(menu)
   window:show()
end

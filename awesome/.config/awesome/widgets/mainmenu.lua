local awful = require("awful")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local gears = require("gears")
local wibox = require("wibox")

awesomemenu = {
    { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
    { "manual", uservars.terminal .. " -e man awesome" },
    { "restart", awesome.restart },
    { "quit", function() awesome.quit() end },
}

powermenu = {
    { "Shut Down", "shutdown now"},
    { "Reboot", "reboot"}
}

menucategories  = awful.menu{ 
    items = { 
        { "Awesome", awesomemenu, beautiful.awesome_icon },
        { "Power", powermenu},
        { "open terminal", uservars.terminal }
    }
}

mainmenu = wibox.widget{
    widget = wibox.container.background,
    {
        widget = wibox.container.margin,
        margins = dpi(5),
        {
            layout = wibox.layout.align.horizontal,
            awful.widget.launcher{ 
                image = beautiful.awesome_icon,
                menu = menucategories,
            }
        }
    }
}

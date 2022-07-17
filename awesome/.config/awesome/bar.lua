local awful = require("awful")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local gears = require("gears")
local wibox = require("wibox")

awful.screen.connect_for_each_screen(function(s)
    s.bar = awful.popup{
        screen = s,
        type = "dock",
        widget = wibox.container.background,
        placement = function(c) awful.placement.top(c, {margins = 3}) end,
        maximum_width = s.geometry.width - 10,
        minimum_width = s.geometry.width - 10,
        maximum_height = uservars.bar_height, 
        shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, 10)
        end        
    }

    s.bar:struts {
        top = dpi(42),
    }

    s.bar:setup {
        layout = wibox.layout.align.horizontal,
        expand="none",
        {
            layout = wibox.layout.align.horizontal,
            mainmenu,
            s.taglist,
        },
        {
            layout = wibox.layout.align.horizontal,
            s.tasklist,
        },
        {
            layout = wibox.layout.align.horizontal,
            wibox.widget.systray(),
            textclock,
            s.layoutbox
        }
    }
end)

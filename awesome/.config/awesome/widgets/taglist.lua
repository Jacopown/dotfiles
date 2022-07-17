local awful = require("awful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local gears = require("gears")
local wibox = require("wibox")

-- Create a taglist widget
awful.screen.connect_for_each_screen(function(s)
    s.taglist = wibox.widget{
        widget = wibox.container.background,
        --bg = "#ff0000",
        {
            widget = wibox.container.margin,
            margins = dpi(5),
            {
                layout = wibox.layout.fixed.horizontal,
                awful.widget.taglist {
                    screen  = s,
                    filter  = awful.widget.taglist.filter.all,
                    style   = {
                        shape = gears.shape.circle
                    },
                    layout   = {
                        spacing = 2,
                        layout  = wibox.layout.fixed.horizontal
                    },
                    widget_template = {
                        id     = "background_role",
                        widget = wibox.container.background,
                        shape = function(cr, width, height)
                            gears.shape.circle(cr, width, height, dpi(10))
                        end,
                        {
                            left  = 10,
                            right = 10,
                            widget = wibox.container.margin,
                            {
                                layout = wibox.layout.fixed.horizontal,
                                {
                                    id     = "text_role",
                                    widget = wibox.widget.textbox,
                                },
                                
                            },  
                        },
                    },
                    buttons = gears.table.join(
                        awful.button({ }, 1, function(t) t:view_only() end),
                        awful.button({ modkey }, 1, function(t)
                            if client.focus then
                                client.focus:move_to_tag(t)
                            end
                        end),
                        awful.button({ }, 3, awful.tag.viewtoggle),
                        awful.button({ modkey }, 3, function(t)
                            if client.focus then
                                client.focus:toggle_tag(t)
                            end
                        end),
                        awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                        awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                    )
                },
            },   
        screen = s,
        }  
    }  
end)
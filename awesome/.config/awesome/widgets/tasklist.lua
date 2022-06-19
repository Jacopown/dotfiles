local awful = require("awful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local gears = require("gears")
local wibox = require("wibox")

-- Create a tasklist widget
awful.screen.connect_for_each_screen(function(s)
    s.tasklist = wibox.widget{
        widget = wibox.container.background,
        --bg = "#ff0000",
        forced_height = dpi(40),
        {
            widget = wibox.container.margin,
            margins = dpi(5),
            {
                layout = wibox.layout.align.horizontal,
                awful.widget.tasklist {
                    screen  = s,
                    filter  = awful.widget.tasklist.filter.currenttags,
                    style    = {
                        shape  = gears.shape.rounded_rect,
                    },
                    layout   = {
                        spacing = 5,
                        layout  = wibox.layout.flex.horizontal
                    },
                    -- Notice that there is *NO* wibox.wibox prefix, it is a template,
                    -- not a widget instance.
                    widget_template = {
                        widget = wibox.container.background,
                        id     = 'background_role',
                        {
                            widget = wibox.container.margin,
                            left  = 5,
                            right = 5,
                            top = 5,
                            bottom = 5,
                            {
                                layout = wibox.layout.align.horizontal,
                                widget  = wibox.container.margin,
                                margins = 0,
                                {
                                    id     = 'icon_role',
                                    widget = wibox.widget.imagebox,
                                },  
                            }, 
                        },
                    },
                    buttons = gears.table.join(
                        awful.button({ }, 1, function (c)
                            if c == client.focus then
                                c.minimized = true
                            else
                                c:emit_signal(
                                    "request::activate",
                                    "tasklist",
                                    {raise = true}
                                )
                            end
                        end),
                        awful.button({ }, 3, function()
                            awful.menu.client_list({ theme = { width = 250 } })
                        end),
                        awful.button({ }, 4, function ()
                            awful.client.focus.byidx(1)
                        end),
                        awful.button({ }, 5, function ()
                            awful.client.focus.byidx(-1)
                        end)
                    ),
                }
            }
        }
    }
        
end)
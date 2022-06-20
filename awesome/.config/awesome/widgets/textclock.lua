local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local gears = require("gears")
local wibox = require("wibox")

-- Create a textclock widget
textclock = wibox.widget{
    widget = wibox.container.background,
    --bg = "#ff0000",
    shape  = gears.shape.rounded_rect,
    {
        widget = wibox.container.margin,
        margins = dpi(5),
        {
            widget = wibox.container.background,
            bg = "#504945",
            shape  = gears.shape.rounded_rect,
            {
                widget = wibox.container.margin,
                margins = dpi(5),
                {
                    layout = wibox.layout.align.horizontal,
                    wibox.widget.textclock("%a %d %B, %H:%M")
                }
            }     
        }    
    }
}


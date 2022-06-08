local awful = require("awful")

--{{{Autostart
awful.spawn.with_shell("nitrogen --set-scaled ~/dotfiles/wallpapers/ --random &")
awful.spawn.with_shell("lxsession &")
---}}}

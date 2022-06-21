local awful = require("awful")

--{{{Autostart
awful.spawn.with_shell("nitrogen --set-scaled ~/dotfiles/wallpapers/devillevitate.jpg &")
awful.spawn.with_shell("lxsession &")
---}}}

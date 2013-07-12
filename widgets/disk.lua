local wibox     = require("wibox")
local beautiful = require("beautiful")
local vicious   = require("vicious")

local M = {}

M.icon = wibox.widget.imagebox()
M.icon:set_image(beautiful.widget_disk)

M.widget = wibox.widget.textbox()
vicious.register(M.widget, vicious.widgets.fs, "<span>/: ${/ avail_gb}GB /home: ${/home avail_gb}GB</span>", 120)
vicious.cache(M.widget)

return M

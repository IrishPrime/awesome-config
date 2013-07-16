-- Standard Awesome plugins and libraries
local awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")
local gears = require("gears")
local beautiful = require("beautiful") -- Theme handling library
local menubar = require("menubar")
local naughty = require("naughty") -- Notification library
local wibox = require("wibox")
-- Custom Awesome plugins and libraries
local keydoc = require("keydoc") -- From the wiki

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
	naughty.notify({ preset = naughty.config.presets.critical,
	                 title = "Oops, there were errors during startup!",
	                 text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
	local in_error = false
	awesome.connect_signal("debug::error", function (err)
		-- Make sure we don't go into an endless error loop
		if in_error then return end
		in_error = true

		naughty.notify({ preset = naughty.config.presets.critical,
		                 title = "Oops, an error occurred!",
		                 text = err })
		in_error = false
		end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
beautiful.init(awful.util.getdir("config").."/themes/archsome/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "gnome-terminal"
editor = os.getenv("VISUAL") or os.getenv("EDITOR") or "gvim"
explorer = "nautilus"
editor_cmd = editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
local layouts = {
	awful.layout.suit.floating,
	awful.layout.suit.tile,
	awful.layout.suit.tile.left,
	awful.layout.suit.tile.bottom,
	awful.layout.suit.tile.top,
	awful.layout.suit.fair,
	awful.layout.suit.fair.horizontal,
	awful.layout.suit.spiral,
	awful.layout.suit.spiral.dwindle,
	awful.layout.suit.max,
	awful.layout.suit.max.fullscreen,
	awful.layout.suit.magnifier
}
-- }}}

-- {{{ Wallpaper
if beautiful.wallpaper then
	for s = 1, screen.count() do
		gears.wallpaper.maximized(beautiful.wallpaper, s, true)
	end
end
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {}
for s = 1, screen.count() do
	-- Each screen has its own tag table.
	tags[s] = awful.tag({ "web", "tty", "vim", "comm", "fm", "office", "vm", "gtk", "misc" }, s,
		{ layouts[12], layouts[4], layouts[2], layouts[2], layouts[2], layouts[12], layouts[4], layouts[12], layouts[1] })
end
awful.tag.setmwfact(0.12, tags[2][4]) -- Set a reasonable amount of space for the Buddy List on tags[2][4]
-- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
	{ "Manual", terminal .. " -e man awesome", beautiful.icon_path .. "actions/info.svg" },
	{ "Edit Config", editor_cmd .. " " .. awesome.conffile, beautiful.icon_path .. "categories/package_settings.svg" },
	{ "Lock Screen", "screenlock.sh", beautiful.icon_path .. "status/locked.svg" },
	{ "Restart", awesome.restart, beautiful.icon_path .. "apps/gnome-session-reboot.svg" },
	{ "Quit", awesome.quit, beautiful.icon_path .. "apps/gnome-session-halt.svg" }
}

libreofficemenu = {
	{ "Calc",    "libreoffice --calc",    beautiful.icon_path .. "apps/libreoffice-calc.svg" },
	{ "Draw",    "libreoffice --draw",    beautiful.icon_path .. "apps/libreoffice-draw.svg" },
	{ "Impress", "libreoffice --impress", beautiful.icon_path .. "apps/libreoffice-impress.svg" },
	{ "Writer",  "libreoffice --writer",  beautiful.icon_path .. "apps/libreoffice-writer.svg" },
}

mymainmenu = awful.menu({
	items = {
		{ "Awesome",        myawesomemenu,   beautiful.awesome_icon },
		{ "LibreOffice",    libreofficemenu, beautiful.icon_path .. "apps/libreoffice-main.svg" },
		{ "Terminal",       terminal,        beautiful.icon_path .. "apps/terminal.svg" },
		{ "File Explorer",  explorer,        beautiful.icon_path .. "apps/nautilus.svg" },
		{ "GVim",          "gvim",           beautiful.icon_path .. "apps/gvim.svg" },
		{ "Google Chrome", "google-chrome",  beautiful.icon_path .. "apps/chromium-browser.svg" },
		{ "Pidgin",        "pidgin",         beautiful.icon_path .. "apps/pidgin.svg" },
		{ "Thunderbird",   "thunderbird",    beautiful.icon_path .. "apps/thunderbird.svg" },
		{ "X-Chat",        "xchat",          beautiful.icon_path .. "apps/xchat.svg" },
		{ "VirtualBox",    "virtualbox",     beautiful.icon_path .. "apps/vbox.svg" },
	}
})

mylauncher = awful.widget.launcher({
	image = beautiful.awesome_icon,
	menu = mymainmenu
})

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
menubar.cache_entries = true
menubar.app_folders = { "/usr/share/applications/" }
menubar.show_categories = true
-- }}}

-- {{{ Naughty
naughty.config.presets.low.opacity = 1.0
naughty.config.presets.normal.opacity = 1.0
naughty.config.presets.critical.opacity = 1.0
-- }}}

-- {{{ Widgets
local cpu = require("widgets.cpu")
local mem = require("widgets.mem")
local disk = require("widgets.disk")
local vol = require("widgets.volume")
local net = require("widgets.network")
local bat = require("widgets.battery")
-- }}}

-- {{{ Wibox
-- Create a textclock widget
mytextclock = awful.widget.textclock()

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
	awful.button({ }, 1, awful.tag.viewonly),
	awful.button({ modkey }, 1, awful.client.movetotag),
	awful.button({ }, 3, awful.tag.viewtoggle),
	awful.button({ modkey }, 3, awful.client.toggletag),
	awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
	awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
)
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
	awful.button({ }, 1, function (c)
		if c == client.focus then
			c.minimized = true
		else
			-- Without this, the following
			-- :isvisible() makes no sense
			c.minimized = false
			if not c:isvisible() then
				awful.tag.viewonly(c:tags()[1])
			end
			-- This will also un-minimize
			-- the client, if needed
			client.focus = c
			c:raise()
		end
	end),
	awful.button({ }, 3, function ()
		if instance then
			instance:hide()
			instance = nil
		else
			instance = awful.menu.clients({ width=250 })
		end
	end),
	awful.button({ }, 4, function ()
		awful.client.focus.byidx(1)
		if client.focus then client.focus:raise() end
	end),
	awful.button({ }, 5, function ()
		awful.client.focus.byidx(-1)
		if client.focus then client.focus:raise() end
	end))

for s = 1, screen.count() do
	-- Create a promptbox for each screen
	mypromptbox[s] = awful.widget.prompt()
	-- Create an imagebox widget which will contains an icon indicating which layout we're using.
	-- We need one layoutbox per screen.
	mylayoutbox[s] = awful.widget.layoutbox(s)
	mylayoutbox[s]:buttons(awful.util.table.join(
		awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
		awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
		awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
		awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
	-- Create a taglist widget
	mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

	-- Create a tasklist widget
	mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

	-- Create the wibox
	mywibox[s] = awful.wibox({ position = "top", screen = s })

	-- Widgets that are aligned to the left
	local left_layout = wibox.layout.fixed.horizontal()
	left_layout:add(mylauncher)
	left_layout:add(mytaglist[s])
	left_layout:add(mypromptbox[s])

	-- Widgets that are aligned to the right
	local right_layout = wibox.layout.fixed.horizontal()
	right_layout:add(cpu.icon)
	right_layout:add(cpu.widget)
	right_layout:add(mem.icon)
	right_layout:add(mem.widget)
	right_layout:add(disk.icon)
	right_layout:add(disk.widget)
	right_layout:add(net.upicon)
	right_layout:add(net.upwidget)
	right_layout:add(net.downicon)
	right_layout:add(net.downwidget)
	right_layout:add(vol.icon)
	right_layout:add(vol.widget)
	if s == 1 then right_layout:add(wibox.widget.systray()) end
	right_layout:add(mytextclock)
	right_layout:add(mylayoutbox[s])

	-- Now bring it all together (with the tasklist in the middle)
	local layout = wibox.layout.align.horizontal()
	layout:set_left(left_layout)
	layout:set_middle(mytasklist[s])
	layout:set_right(right_layout)

	mywibox[s]:set_widget(layout)
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
	awful.button({ }, 3, function () mymainmenu:toggle() end),
	awful.button({ }, 4, awful.tag.viewnext),
	awful.button({ }, 5, awful.tag.viewprev)))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
	-- Layout manipulation
	keydoc.group("Layout manipulation"),
	awful.key({ modkey,           }, "Left",   awful.tag.viewprev, "Previous tag"),
	awful.key({ modkey,           }, "Right",  awful.tag.viewnext, "Next tag"),
	awful.key({ modkey,           }, "Escape", awful.tag.history.restore, "Previously selected tag"),

	awful.key({ modkey,           }, "j",
		function ()
			awful.client.focus.byidx(1)
			if client.focus then client.focus:raise() end
		end,
		"Next client"),
	awful.key({ modkey,           }, "k",
		function ()
			awful.client.focus.byidx(-1)
			if client.focus then client.focus:raise() end
		end,
		"Previous client"),

	awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end, "Swap with next window"),
	awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end, "Swap with previous window"),
	awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end, "Next screen"),
	awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end, "Previous screen"),
	awful.key({ modkey,           }, "u", awful.client.urgent.jumpto, "Focus urgent client"),
	awful.key({ modkey,           }, "Tab",
		function ()
			awful.client.focus.history.previous()
			if client.focus then
				client.focus:raise()
			end
		end,
		"Previously focused client"),

	-- Volume control
	awful.key({ }, "XF86AudioRaiseVolume", function () awful.util.spawn("amixer set Master 5%+", false) end),
	awful.key({ }, "XF86AudioLowerVolume", function () awful.util.spawn("amixer set Master 5%-", false) end),
	awful.key({ }, "XF86AudioMute", function () awful.util.spawn("amixer sset Master toggle", false) end),
	awful.key({ modkey,           }, "Prior", function () awful.util.spawn("amixer set Master 5%+", false) end),
	awful.key({ modkey,           }, "Next",  function () awful.util.spawn("amixer set Master 5%-", false) end),

	-- Standard program
	keydoc.group("Standard Programs"),
	awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal)        end, "Terminal"),
	awful.key({ modkey,           }, "w",      function () awful.util.spawn("google-chrome") end, "Google Chrome"),
	awful.key({ modkey,           }, "v",      function () awful.util.spawn("gvim")          end, "GVim"),
	awful.key({ modkey,           }, "e",      function () awful.util.spawn(explorer)        end, "File explorer"),

	-- Awesome
	keydoc.group("Awesome"),
	awful.key({ modkey,           }, "z", function () mymainmenu:show() end, "Awesome menu"),
	awful.key({ modkey, "Control" }, "r", awesome.restart, "Restart Awesome"),
	awful.key({ modkey, "Shift"   }, "q", awesome.quit, "Quit Awesome"),
	awful.key({ modkey,           }, "/", function () awful.util.spawn("screenlock.sh") end, "Lock screen"),
	awful.key({ modkey,           }, "Print", function () awful.util.spawn("scrot") end, "Take a screenshot"),
	awful.key({ modkey,           }, "F1", keydoc.display, "Display this help"),

	-- Tag Manipulation
	keydoc.group("Tag manipulation"),
	awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end, "Increase master width"),
	awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end, "Decrease master width"),
	awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end, "Increase number of master clients"),
	awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end, "Decrease number of master clients"),
	awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end, "Increase stack columns"),
	awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end, "Decrease stack columns"),
	awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end, "Next layout"),
	awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end, "Previous layout"),

	awful.key({ modkey, "Control" }, "n", awful.client.restore),

	-- Prompts
	keydoc.group("Prompts"),
	awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end, "Run prompt"),

	awful.key({ modkey }, "x",
		function ()
			awful.prompt.run({ prompt = "Run Lua code: " },
			mypromptbox[mouse.screen].widget,
			awful.util.eval, nil,
			awful.util.getdir("cache") .. "/history_eval")
		end,
		"Lua prompt"),

	awful.key({ modkey }, "p", function() menubar.show() end, "Menubar"))

-- Clients
clientkeys = awful.util.table.join(
	keydoc.group("Client manipulation"),
	awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end, "Toggle fullscreen"),
	awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end, "Kill client"),
	awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     , "Toggle floating"),
	awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end, "Swap with master"),
	awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        , "Move to next screen"),
	awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end, "Always on top"),
	awful.key({ modkey,           }, "n",
		function (c)
			-- The client currently has the input focus, so it cannot be
			-- minimized, since minimized clients can't have the focus.
			c.minimized = true
		end),
	awful.key({ modkey,           }, "m",
		function (c)
			c.maximized_horizontal = not c.maximized_horizontal
			c.maximized_vertical   = not c.maximized_vertical
		end,
		"Toggle maximize"))

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
	globalkeys = awful.util.table.join(globalkeys,
		awful.key({ modkey }, "#" .. i + 9,
			function ()
				local screen = mouse.screen
				local tag = awful.tag.gettags(screen)[i]
				if tag then
					awful.tag.viewonly(tag)
				end
			end),
		awful.key({ modkey, "Control" }, "#" .. i + 9,
			function ()
				local screen = mouse.screen
				local tag = awful.tag.gettags(screen)[i]
				if tag then
					awful.tag.viewtoggle(tag)
				end
			end),
		awful.key({ modkey, "Shift" }, "#" .. i + 9,
			function ()
				local tag = awful.tag.gettags(client.focus.screen)[i]
				if client.focus and tag then
					awful.client.movetotag(tag)
				end
			end),
		awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
			function ()
				local tag = awful.tag.gettags(client.focus.screen)[i]
				if client.focus and tag then
					awful.client.toggletag(tag)
				end
			end))
end

clientbuttons = awful.util.table.join(
	awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
	awful.button({ modkey }, 1, awful.mouse.client.move),
	awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
	-- All clients will match this rule.
	{ rule = { },
	  properties = { border_width = beautiful.border_width,
	                 border_color = beautiful.border_normal,
	                 focus = awful.client.focus.filter,
	                 keys = clientkeys,
	                 size_hints_honor = false,
	                 buttons = clientbuttons } },
	{ rule = { class = "MPlayer" },
	  properties = { floating = true } },
	{ rule = { class = "pinentry" },
	  properties = { floating = true } },
	{ rule = { class = "gimp" },
      properties = { floating = true } },
	{ rule = { class = "Google-chrome" },
	  properties = { tag = tags[1][1] } },
	{ rule = { class = "Gvim" },
	  properties = { tag = tags[1][3] } },
	{ rule = { class = "Xchat" },
	  properties = { tag = tags[1][4] } },
	-- File Managers
	{ rule = { class = "Nautilus" },
	  properties = { tag = tags[1][5] } },
	{ rule = { class = "Thunar" },
	  properties = { tag = tags[1][5] } },
	-- LibreOffice
	{ rule = { class = "libreoffice-calc" },
	  properties = { tag = tags[1][6] } },
	{ rule = { class = "libreoffice-writer" },
	  properties = { tag = tags[1][6] } },
	-- Pidgin: Screen 2, Tag 4. Buddy List as master, Conversations as slaves.
	{ rule = { class = "Pidgin" },
	  properties = { tag = tags[2][4] } },
	{ rule = { class = "Pidgin", role = "conversation" },
	  callback = awful.client.setslave },
	{ rule = { class = "Pidgin", role = "buddy_list" },
	  callback = awful.client.setmaster },
	-- VirtualBox
	{ rule = { class = "VirtualBox" },
	  properties = { tag = tags[2][7] } },
	{ rule = { class = "Thunderbird" },
	  properties = { tag = tags[2][8] } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
	-- Enable sloppy focus
	c:connect_signal("mouse::enter", function(c)
		if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
			and awful.client.focus.filter(c) then
			client.focus = c
		end
	end)

	if not startup then
		-- Set the windows at the slave,
		-- i.e. put it at the end of others instead of setting it master.
		-- awful.client.setslave(c)

		-- Put windows in a smart way, only if they does not set an initial position.
		if not c.size_hints.user_position and not c.size_hints.program_position then
			awful.placement.no_overlap(c)
			awful.placement.no_offscreen(c)
		end
	end

	local titlebars_enabled = false
	if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
		-- buttons for the titlebar
		local buttons = awful.util.table.join(
		awful.button({ }, 1, function()
			client.focus = c
			c:raise()
			awful.mouse.client.move(c)
		end),
		awful.button({ }, 3, function()
			client.focus = c
			c:raise()
			awful.mouse.client.resize(c)
		end))

		-- Widgets that are aligned to the left
		local left_layout = wibox.layout.fixed.horizontal()
		left_layout:add(awful.titlebar.widget.iconwidget(c))
		left_layout:buttons(buttons)

		-- Widgets that are aligned to the right
		local right_layout = wibox.layout.fixed.horizontal()
		right_layout:add(awful.titlebar.widget.floatingbutton(c))
		right_layout:add(awful.titlebar.widget.maximizedbutton(c))
		right_layout:add(awful.titlebar.widget.stickybutton(c))
		right_layout:add(awful.titlebar.widget.ontopbutton(c))
		right_layout:add(awful.titlebar.widget.closebutton(c))

		-- The title goes in the middle
		local middle_layout = wibox.layout.flex.horizontal()
		local title = awful.titlebar.widget.titlewidget(c)
		title:set_align("center")
		middle_layout:add(title)
		middle_layout:buttons(buttons)

		-- Now bring it all together
		local layout = wibox.layout.align.horizontal()
		layout:set_left(left_layout)
		layout:set_right(right_layout)
		layout:set_middle(middle_layout)

		awful.titlebar(c):set_widget(layout)
	end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

-- {{{ Custom functions
-- Disable startup-notifications globally
local oldspawn = awful.util.spawn
awful.util.spawn = function (s)
	oldspawn(s, false)
end
-- }}}

-- vim: foldmethod=marker

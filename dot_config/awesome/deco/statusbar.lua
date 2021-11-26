-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")

-- Custom Local Library: Common Functional Decoration
local deco = {
	wallpaper = require("deco.wallpaper"),
	taglist = require("deco.taglist"),
	tasklist = require("deco.tasklist"),
}

local taglist_buttons = deco.taglist()
local tasklist_buttons = deco.tasklist()

-- Widget imports
local logout_menu_widget = require("awesome-wm-widgets.logout-menu-widget.logout-menu")
local volume_widget = require("awesome-wm-widgets.volume-widget.volume")
local battery_widget = require("awesome-wm-widgets.battery-widget.battery")
local weather_widget = require("awesome-wm-widgets.weather-widget.weather")
local calendar_widget = require("awesome-wm-widgets.calendar-widget.calendar")
local spotify_widget = require("awesome-wm-widgets.spotify-widget.spotify")

-- Create a textclock widget
mytextclock = wibox.widget.textclock("%l:%M %P", 30)
local cw = calendar_widget({ placement = "top_right" })
mytextclock:connect_signal("button::press", function(_, _, _, button)
	if button == 1 then
		cw.toggle()
	end
end)

local _M = {}

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- Wibar

awful.screen.connect_for_each_screen(function(s)
	-- Wallpaper
	set_wallpaper(s)
	-- Create a promptbox for each screen
	s.mypromptbox = awful.widget.prompt()

	-- Create an imagebox widget
	-- We need one layoutbox per screen.
	s.mylayoutbox = awful.widget.layoutbox(s)
	s.mylayoutbox:buttons(gears.table.join(
		awful.button({}, 1, function()
			awful.layout.inc(1)
		end),
		awful.button({}, 3, function()
			awful.layout.inc(-1)
		end),
		awful.button({}, 4, function()
			awful.layout.inc(1)
		end),
		awful.button({}, 5, function()
			awful.layout.inc(-1)
		end)
	))

	-- Create a taglist widget
	s.mytaglist = awful.widget.taglist({
		screen = s,
		filter = awful.widget.taglist.filter.all,
		buttons = taglist_buttons,
		style = {
			shape = gears.shape.powerline,
		},
		layout = {
			spacing = 0,
			-- spacing_widget = {
			-- 	color = "#dddddd",
			-- 	shape = gears.shape.powerline,
			-- 	widget = wibox.widget.separator,
			-- },
			layout = wibox.layout.fixed.horizontal,
		},
		widget_template = {
			{
				{
					-- {
					-- 	{
					-- 		{
					-- 			id = "index_role",
					-- 			widget = wibox.widget.textbox,
					-- 		},
					-- 		margins = 4,
					-- 		widget = wibox.container.margin,
					-- 	},
					-- 	bg = "#dddddd",
					-- 	shape = gears.shape.circle,
					-- 	widget = wibox.container.background,
					-- },
					{
						{
							id = "icon_role",
							widget = wibox.widget.imagebox,
						},
						margins = 2,
						widget = wibox.container.margin,
					},

					{
						id = "text_role",
						widget = wibox.widget.textbox,
					},
					layout = wibox.layout.fixed.horizontal,
				},
				left = 15,
				right = 15,
				widget = wibox.container.margin,
			},
			id = "background_role",
			widget = wibox.container.background,
		},
	})

	-- Create a tasklist widget
	s.mytasklist = awful.widget.tasklist({
		screen = s,
		filter = awful.widget.tasklist.filter.currenttags,
		buttons = tasklist_buttons,
		style = {
			shape = gears.shape.rounded_bar,
			align = "center",
		},
		layout = {
			spacing = 10,
			layout = wibox.layout.flex.horizontal,
		},
		widget_template = {
			{
				{
					{
						{
							id = "icon_role",
							widget = wibox.widget.imagebox,
						},
						margins = 4,
						widget = wibox.container.margin,
					},
					{
						id = "text_role",
						widget = wibox.widget.textbox,
					},
					layout = wibox.layout.fixed.horizontal,
					align = "center",
				},
				left = 10,
				right = 10,
				widget = wibox.container.margin,
			},
			id = "background_role",
			widget = wibox.container.background,
		},
	})

	-- Create the wibox
	s.mywibox = awful.wibar({
		position = "top",
		screen = s,
		height = 30,
		width = 1400,
		shape = gears.shape.rounded_rect,
	})
	s.mywibox.y = 8

	s.leftwibox =
		-- Add widgets to the wibox
		s.mywibox:setup({
			layout = wibox.layout.align.horizontal,
			{ -- Left widgets
				layout = wibox.layout.fixed.horizontal,
				spacing = 5,
				-- RC.launcher,
				s.mytaglist,
				s.mypromptbox,
			},
			-- Middle widget
			s.mytasklist,
			{ -- Right widgets
				layout = wibox.layout.fixed.horizontal,
				spacing = 20,
				spotify_widget(),
				-- mykeyboardlayout,
				wibox.widget.systray(),
				weather_widget({
					api_key = "a027a4e6cbe80c6b037ae078c530fb90",
					coordinates = { 32.8548, -97.0819 },
					units = "imperial",
					time_format_12h = true,
					show_hourly_forecast = true,
					show_daily_forecast = true,
				}),
				volume_widget({
					type = "arc",
				}),
				battery_widget({
					show_current_level = true,
				}),
				mytextclock,
				logout_menu_widget(),
				s.mylayoutbox,
			},
		})
end)

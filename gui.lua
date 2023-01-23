local newSlider = require("classes.slider")
local newTextBox = require("classes.textbox")
local newContainer = require("classes.container")
local newBlock = require("classes.block")
local settings = require("settings")
local newButton = require("classes.button")
require("lib.positionElements")

local Gui = {container = {}, sliders = {}}

function Gui:load()
	self.sliders.slider1 = newSlider.new({
		offset_bottom = 5,
		w = 150,
		h = 20,
		sliderRangeMax = 4,
		sliderRangeMin = 0,
		startValue = 0.5
	})

	self.sliders.slider2 = newSlider.new({
		offset_bottom = 5,
		h = 20,
		w = 150,
		sliderRangeMax = 4,
		sliderRangeMin = 0,
		startValue = 0.5
	})

	self.sliders.slider3 = newSlider.new({
		w = 150,
		h = 20,
		sliderRangeMax = 4,
		sliderRangeMin = 0,
		startValue = 0.5
	})

	self.sliders.slider4 = newSlider.new({
		offset_bottom = 5,
		h = 20,
		w = 150,
		sliderRangeMax = 1,
		sliderRangeMin = 0,
		startValue = 0.5
	})

	self.sliders.slider5 = newSlider.new({
		offset_bottom = 5,
		h = 20,
		w = 150,
		sliderRangeMax = 1,
		sliderRangeMin = 0,
		startValue = 0.5
	})

	self.sliders.slider6 = newSlider.new({
		h = 20,
		w = 150,
		sliderRangeMax = 1,
		sliderRangeMin = 0,
		startValue = 0.5
	})

	self.container = newContainer.new({
		x = 0,
		y = 100,
		w = WINDOW_WIDTH,
		h = 200,
		alignment = {horizontal = true},
		children = {
			newContainer.new({
				alignment = {vertical = true},
				children = {
					self.sliders.slider1,
					self.sliders.slider2,
					self.sliders.slider3,
				}
			}),
			newContainer.new({
				alignment = {vertical = true},
				id = "container3",
				children = {
					self.sliders.slider4,
					self.sliders.slider5,
					self.sliders.slider6,
				}
			})
		}
	})
end

function Gui:keypressed(key,scancode,isrepeat)
end

function Gui:mousepressed(x,y,button,istouch,presses)
	self.container:mousepressed(x,y,button,istouch,presses)
end

function Gui:mousereleased(x,y,button,istouch,presses)
	self.container:mousereleased(x,y,button,istouch,presses)
end

function Gui:mousemoved(x, y, dx, dy, istouch)
	self.container:mousemoved(x, y, dx, dy, istouch)
end

function Gui:draw()
	self.container:draw()
end

function Gui:update(dt)
	self.container:update(dt)
end

function Gui:resize()
	self.container:resize()
end

return Gui
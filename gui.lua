local newSlider = require("classes.slider")
local newTextBox = require("classes.textbox")
local newContainer = require("classes.container")
local newBlock = require("classes.block")
local settings = require("settings")
local newButton = require("classes.button")
require("lib.positionElements")

local Gui = {container = {}, sliders = {}, textBox = {}}

function Gui:load()
	self.sliders.slider1 = newSlider.new({
		-- offset = {bottom = 5},
		w = 100,
		h = 20,
		sliderRangeMax = 4,
		sliderRangeMin = 0,
		startValue = 0.5
	})

	self.sliders.slider2 = newSlider.new({
		-- offset = {bottom = 5},
		w = 100,
		h = 20,
		sliderRangeMax = 4,
		sliderRangeMin = 0,
		startValue = 0.5
	})

	self.sliders.slider3 = newSlider.new({
		w = 100,
		h = 20,
		sliderRangeMax = 4,
		sliderRangeMin = 0,
		startValue = 0.5
	})

	self.sliders.slider4 = newSlider.new({
		-- offset = {bottom = 5},
		w = 100,
		h = 20,
		sliderRangeMax = 1,
		sliderRangeMin = 0,
		startValue = 0.5
	})

	self.sliders.slider5 = newSlider.new({
		-- offset = {bottom = 5},
		w = 100,
		h = 20,
		sliderRangeMax = 1,
		sliderRangeMin = 0,
		startValue = 0.5
	})

	self.sliders.slider6 = newSlider.new({
		w = 100,
		h = 20,
		sliderRangeMax = 1,
		sliderRangeMin = 0,
		startValue = 0.5
	})

	self.textBox.textBox1 = newTextBox.new({
		-- offset = {bottom = 5},
		-- offset = {left = 5},
		-- offset = {right = 5},
		w = 100,
		h = 20,
		text = function () return self.sliders.slider1:getValue() end,
		font = Percentage,
		decimal_points = 2
	})

	self.textBox.textBox2 = newTextBox.new({
		-- offset = {bottom = 5},
		-- offset = {left = 5},
		-- offset = {right = 5},
		w = 100,
		h = 20,
		text = function () return self.sliders.slider2:getValue() end,
		font = Percentage,
		decimal_points = 2
	})

	self.textBox.textBox3 = newTextBox.new({
		-- offset = {left = 5},
		-- offset = {right = 5},
		w = 100,
		h = 20,
		text = function () return self.sliders.slider3:getValue() end,
		font = Percentage,
		decimal_points = 2
	})

	self.textBox.textBox4 = newTextBox.new({
		-- offset = {left = 5},
		-- offset = {bottom = 5},
		-- offset = {right = 5},
		w = 100,
		h = 20,
		text = function () return self.sliders.slider4:getValue() * 100 end,
		font = Percentage,
		decimal_points = 0
	})

	self.textBox.textBox5 = newTextBox.new({
		-- offset = {left = 5},
		-- offset = {bottom = 5},
		-- offset = {right = 5},
		w = 100,
		h = 20,
		text = function () return self.sliders.slider5:getValue() * 100 end,
		font = Percentage,
		decimal_points = 0
	})

	self.textBox.textBox6 = newTextBox.new({
		-- offset = {left = 5},
		-- offset = {right = 5},
		w = 100,
		h = 20,
		text = function () return self.sliders.slider6:getValue() * 100 end,
		font = Percentage,
		decimal_points = 0
	})

	self.container = newContainer.new({
		x = 0,
		y = 100,
		w = WINDOW_WIDTH,
		h = 300,
		-- offset = {left = 50, right = 50},
		alignment = {horizontal = true},
		spacing = {between = true},
		children = {
			newContainer.new({
				alignment = {vertical = true},
				spacing = {between = true},
				offset = {top = 5, bottom = 5},
				children = {
					self.sliders.slider1,
					self.sliders.slider2,
					self.sliders.slider3,
				}
			}),
			newContainer.new({
				alignment = {vertical = true},
				children = {
					self.textBox.textBox1,
					self.textBox.textBox2,
					self.textBox.textBox3,
				}
			}),
			newContainer.new({
				alignment = {vertical = true},
				children = {
					self.sliders.slider4,
					self.sliders.slider5,
					self.sliders.slider6,
				}
			}),
			newContainer.new({
				alignment = {vertical = true},
				children = {
					self.textBox.textBox4,
					self.textBox.textBox5,
					self.textBox.textBox6,
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
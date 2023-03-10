local newSlider = require("classes.slider")
local newTextBox = require("classes.textbox")
local newContainer = require("classes.container")
local newBlock = require("classes.block")
local settings = require("settings")
local newButton = require("classes.button")
require("lib.positionElements")

local Gui = {container = {}, sliders = {}, textBox = {}, buttons = {}}


function Gui:load()
	self.sliders.slider1 = newSlider.new({
		w = 100,
		h = 20,
		sliderRangeMax = 4,
		sliderRangeMin = 0,
		startValue = 0.5
	})

	self.sliders.slider2 = newSlider.new({
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
		w = 100,
		h = 20,
		sliderRangeMax = 1,
		sliderRangeMin = 0,
		startValue = 0.5
	})

	self.sliders.slider5 = newSlider.new({
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
		w = 100,
		h = 20,
		text = function () return self.sliders.slider1:getValue() end,
		font = Percentage,
		decimal_points = 2
	})

	self.textBox.textBox2 = newTextBox.new({
		w = 100,
		h = 20,
		text = function () return self.sliders.slider2:getValue() end,
		font = Percentage,
		decimal_points = 2
	})

	self.textBox.textBox3 = newTextBox.new({
		w = 100,
		h = 20,
		text = function () return self.sliders.slider3:getValue() end,
		font = Percentage,
		decimal_points = 2
	})

	self.textBox.textBox4 = newTextBox.new({
		w = 100,
		h = 20,
		text = function () return self.sliders.slider4:getValue() * 100 end,
		font = Percentage,
		decimal_points = 0
	})

	self.textBox.textBox5 = newTextBox.new({
		w = 100,
		h = 20,
		text = function () return self.sliders.slider5:getValue() * 100 end,
		font = Percentage,
		decimal_points = 0
	})

	self.textBox.textBox6 = newTextBox.new({
		w = 100,
		h = 20,
		text = function () return self.sliders.slider6:getValue() * 100 end,
		font = Percentage,
		decimal_points = 0
	})

	local test = function ()
		if self.container.y == WINDOW_HEIGHT - 20 then
			Flux.to(self.container, 2, { x = 10, y = WINDOW_HEIGHT - self.container:getValue("h")})
		else
			Flux.to(self.container, 2, { x = 10, y = WINDOW_HEIGHT - 20})
		end
	end

	self.buttons.b = newButton.new({
		text = "GUI",
		func = test,
		w = 50,
		h = 20
	})

	self.container = newContainer.new({
		x = 10,
		y = WINDOW_HEIGHT - 20,
		alignment = {vertical = true},
		spacing = {between = 5},
		children = {
			newContainer.new({
				alignment = {horizontal = true},
				children = {
					self.buttons.b
				}
			}),
			newContainer.new({
				alignment = {horizontal = true},
				spacing = {between = 5},
				children = {
					newContainer.new({
						alignment = {vertical = true},
						spacing = {between = 10},
						children = {
							self.sliders.slider1,
							self.sliders.slider2,
							self.sliders.slider3,
						}
					}),
					newContainer.new({
						alignment = {vertical = true},
						spacing = {between = 10},
						children = {
							self.textBox.textBox1,
							self.textBox.textBox2,
							self.textBox.textBox3,
						}
					}),
					newContainer.new({
						alignment = {vertical = true},
						spacing = {between = 10},
						children = {
							self.sliders.slider4,
							self.sliders.slider5,
							self.sliders.slider6,
						}
					}),
					newContainer.new({
						alignment = {vertical = true},
						spacing = {between = 10},
						children = {
							self.textBox.textBox4,
							self.textBox.textBox5,
							self.textBox.textBox6,
						}
					})
				}
			})
		}
	})
end

function Gui:keypressed(key,scancode,isrepeat)
end

function Gui:mousepressed(x,y,button,istouch,presses)
	self.container:mousepressed(x,y,button,istouch,presses)
	self.buttons.b:mousepressed(x,y,button,istouch,presses)
end

function Gui:mousereleased(x,y,button,istouch,presses)
	self.container:mousereleased(x,y,button,istouch,presses)
	self.buttons.b:mousereleased(x,y,button,istouch,presses)
end

function Gui:mousemoved(x, y, dx, dy, istouch)
	self.container:mousemoved(x, y, dx, dy, istouch)
end

function Gui:draw()
	self.container:draw()
	self.buttons.b:draw()
end

function Gui:update(dt)
	self.container:update(dt)
	self.buttons.b:update(dt)
end

function Gui:resize()
	self.container:resize()
end

return Gui
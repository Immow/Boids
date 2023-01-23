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
		offset_top = 5,
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
		offset_top = 5,
		offset_bottom = 5,
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
		offset_bottom = 5,
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
		children = {
			newContainer.new({
				w = 150,
				h = 100,
				children = {
					self.sliders.slider1,
					self.sliders.slider2,
					self.sliders.slider3,
				}
			}),
			newContainer.new({
				w = 150,
				h = 100,
				children = {
					self.sliders.slider4,
					self.sliders.slider5,
					self.sliders.slider6,
				}
			})
		}
	})

	-- local slider3 = newSlider.new({
	-- 	offset_bottom = 5,
	-- 	h = 20,
	-- 	w = 150,
	-- 	valueReference = "separationFactor",
	-- 	tableReference = settings.sliderSettings.separation,
	-- 	sliderRangeMax = 4,
	-- 	sliderRangeMin = 0,
	-- 	startValue = 50
	-- })

	-- local textBox1 = newTextBox.new({
	-- 	position = "R-C",
	-- 	id = "textBox1",
	-- 	target_id = "slider1",
	-- 	offsetX = 5,
	-- 	w = 70,
	-- 	h = 20,
	-- 	valueReference = "alignmentFactor",
	-- 	tableReference = settings.sliderSettings.alignment,
	-- 	font = Percentage
	-- })

	-- local textBox2 = newTextBox.new({
	-- 	position = "R-C",
	-- 	id = "textBox2",
	-- 	target_id = "slider2",
	-- 	offsetX = 5,
	-- 	w = 70,
	-- 	h = 20,
	-- 	valueReference = "cohesionFactor",
	-- 	tableReference = settings.sliderSettings.cohesion,
	-- 	font = Percentage
	-- })

	-- local textBox3 = newTextBox.new({
	-- 	position = "R-C",
	-- 	id = "textBox3",
	-- 	target_id = "slider3",
	-- 	offsetX = 5,
	-- 	w = 70,
	-- 	h = 20,
	-- 	valueReference = "separationFactor",
	-- 	tableReference = settings.sliderSettings.separation,
	-- 	font = Percentage
	-- })

	-- local slider4 = newSlider.new({
	-- 	position = "R-C",
	-- 	id = "slider4",
	-- 	offsetX = 5,
	-- 	target_id = "textBox1",
	-- 	h = 20,
	-- 	w = 150,
	-- 	valueReference = "perceptionRadius",
	-- 	tableReference = settings.sliderSettings.alignment,
	-- 	sliderRangeMax = 100,
	-- 	sliderRangeMin = 1,
	-- 	startValue = 25
	-- })

	-- local slider5 = newSlider.new({
	-- 	position = "R-C",
	-- 	id = "slider5",
	-- 	target_id = "textBox2",
	-- 	offsetX = 5,
	-- 	h = 20,
	-- 	w = 150,
	-- 	valueReference = "perceptionRadius",
	-- 	tableReference = settings.sliderSettings.cohesion,
	-- 	sliderRangeMax = 100,
	-- 	sliderRangeMin = 1,
	-- 	startValue = 50
	-- })

	-- local slider6 = newSlider.new({
	-- 	position = "R-C",
	-- 	id = "slider6",
	-- 	target_id = "textBox3",
	-- 	offsetX = 5,
	-- 	h = 20,
	-- 	w = 150,
	-- 	valueReference = "perceptionRadius",
	-- 	tableReference = settings.sliderSettings.separation,
	-- 	sliderRangeMax = 100,
	-- 	sliderRangeMin = 1,
	-- 	startValue = 24
	-- })

	-- local textBox4 = newTextBox.new({
	-- 	position = "R-C",
	-- 	id = "textBox4",
	-- 	target_id = "slider4",
	-- 	offsetX = 5,
	-- 	w = 70,
	-- 	h = 20,
	-- 	valueReference = "perceptionRadius",
	-- 	tableReference = settings.sliderSettings.alignment,
	-- 	font = Percentage
	-- })

	-- local textBox5 = newTextBox.new({
	-- 	position = "R-C",
	-- 	id = "textBox5",
	-- 	target_id = "slider5",
	-- 	offsetX = 5,
	-- 	w = 70,
	-- 	h = 20,
	-- 	valueReference = "perceptionRadius",
	-- 	tableReference = settings.sliderSettings.cohesion,
	-- 	font = Percentage
	-- })

	-- local textBox6 = newTextBox.new({
	-- 	position = "R-C",
	-- 	id = "textBox6",
	-- 	target_id = "slider6",
	-- 	offsetX = 5,
	-- 	w = 70,
	-- 	h = 20,
	-- 	valueReference = "perceptionRadius",
	-- 	tableReference = settings.sliderSettings.separation,
	-- 	font = Percentage
	-- })

	-- local test = function () return Flux.to(container, 4, { x = 0, y = 100 }) end
	-- local test = function ()
	-- 	if container.y == WINDOW_HEIGHT then
	-- 		Flux.to(container, 2, { x = 0, y = WINDOW_HEIGHT - 80}):ease("quadout")
	-- 	else
	-- 		Flux.to(container, 2, { x = 0, y = WINDOW_HEIGHT}):ease("quadout")
	-- 	end
	-- end

	-- local b = newButton.new({
	-- 	position = "TL-P",
	-- 	id = "b",
	-- 	target_id = "parent",
	-- 	offsetY = -20,
	-- 	text = "GUI",
	-- 	func = test,
	-- 	width = 50,
	-- 	height = 20
	-- })

	-- container:addChilds(slider1, slider2)
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

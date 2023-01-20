local newSlider = require("classes.slider")
local newTextBox = require("classes.textbox")
local newContainer = require("classes.container")
local newBlock = require("classes.block")
local settings = require("settings")
local newButton = require("classes.button")
require("lib.positionElements")

local Gui = {}
local container

function Gui:load()
	container = newContainer.new({
		x = 0,
		y = WINDOW_HEIGHT,
		width = WINDOW_WIDTH,
		height = 80,
	})

	local slider1 = newSlider.new({
		position = "TL-P",
		id = "slider1",
		target_id = "parent",
		height = 20,
		width = 150,
		valueReference = "alignmentFactor",
		tableReference = settings.sliderSettings.alignment,
		sliderRangeMax = 4,
		sliderRangeMin = 0,
		startValue = 50
	})

	local slider2 = newSlider.new({
		position = "B-C",
		id = "slider2",
		target_id = "slider1",
		offsetY = 5,
		height = 20,
		width = 150,
		valueReference = "cohesionFactor",
		tableReference = settings.sliderSettings.cohesion,
		sliderRangeMax = 4,
		sliderRangeMin = 0,
		startValue = 50
	})

	local slider3 = newSlider.new({
		position = "B-C",
		id = "slider3",
		target_id = "slider2",
		offsetY = 5,
		height = 20,
		width = 150,
		valueReference = "separationFactor",
		tableReference = settings.sliderSettings.separation,
		sliderRangeMax = 4,
		sliderRangeMin = 0,
		startValue = 50
	})

	local textBox1 = newTextBox.new({
		position = "R-C",
		id = "textBox1",
		target_id = "slider1",
		offsetX = 5,
		width = 70,
		height = 20,
		valueReference = "alignmentFactor",
		tableReference = settings.sliderSettings.alignment,
		font = Percentage
	})

	local textBox2 = newTextBox.new({
		position = "R-C",
		id = "textBox2",
		target_id = "slider2",
		offsetX = 5,
		width = 70,
		height = 20,
		valueReference = "cohesionFactor",
		tableReference = settings.sliderSettings.cohesion,
		font = Percentage
	})

	local textBox3 = newTextBox.new({
		position = "R-C",
		id = "textBox3",
		target_id = "slider3",
		offsetX = 5,
		width = 70,
		height = 20,
		valueReference = "separationFactor",
		tableReference = settings.sliderSettings.separation,
		font = Percentage
	})

	local slider4 = newSlider.new({
		position = "R-C",
		id = "slider4",
		offsetX = 5,
		target_id = "textBox1",
		height = 20,
		width = 150,
		valueReference = "perceptionRadius",
		tableReference = settings.sliderSettings.alignment,
		sliderRangeMax = 100,
		sliderRangeMin = 1,
		startValue = 25
	})

	local slider5 = newSlider.new({
		position = "R-C",
		id = "slider5",
		target_id = "textBox2",
		offsetX = 5,
		height = 20,
		width = 150,
		valueReference = "perceptionRadius",
		tableReference = settings.sliderSettings.cohesion,
		sliderRangeMax = 100,
		sliderRangeMin = 1,
		startValue = 50
	})

	local slider6 = newSlider.new({
		position = "R-C",
		id = "slider6",
		target_id = "textBox3",
		offsetX = 5,
		height = 20,
		width = 150,
		valueReference = "perceptionRadius",
		tableReference = settings.sliderSettings.separation,
		sliderRangeMax = 100,
		sliderRangeMin = 1,
		startValue = 24
	})

	local textBox4 = newTextBox.new({
		position = "R-C",
		id = "textBox4",
		target_id = "slider4",
		offsetX = 5,
		width = 70,
		height = 20,
		valueReference = "perceptionRadius",
		tableReference = settings.sliderSettings.alignment,
		font = Percentage
	})

	local textBox5 = newTextBox.new({
		position = "R-C",
		id = "textBox5",
		target_id = "slider5",
		offsetX = 5,
		width = 70,
		height = 20,
		valueReference = "perceptionRadius",
		tableReference = settings.sliderSettings.cohesion,
		font = Percentage
	})

	local textBox6 = newTextBox.new({
		position = "R-C",
		id = "textBox6",
		target_id = "slider6",
		offsetX = 5,
		width = 70,
		height = 20,
		valueReference = "perceptionRadius",
		tableReference = settings.sliderSettings.separation,
		font = Percentage
	})

	-- local test = function () return Flux.to(container, 4, { x = 0, y = 100 }) end
	local test = function ()
		if container.y == WINDOW_HEIGHT then
			Flux.to(container, 2, { x = 0, y = WINDOW_HEIGHT - 80})
		else
			Flux.to(container, 2, { x = 0, y = WINDOW_HEIGHT})
		end
	end

	local b = newButton.new({
		position = "TL-P",
		id = "b",
		target_id = "parent",
		offsetY = -20,
		text = "GUI",
		func = test,
		width = 50,
		height = 20
	})

	container:addChilds(slider1, slider2, slider3, textBox1, textBox2, textBox3, slider4, slider5, slider6, textBox4,
	                    textBox5, textBox6, b)
end

function Gui:keypressed(key,scancode,isrepeat)
end

function Gui:mousepressed(x,y,button,istouch,presses)
	container:mousepressed(x,y,button,istouch,presses)
end

function Gui:mousereleased(x,y,button,istouch,presses)
	container:mousereleased(x,y,button,istouch,presses)
end

function Gui:draw()
	container:draw()
end

function Gui:update(dt)
	container:update(dt)
end

function Gui:resize()
	container:resize()
end

return Gui

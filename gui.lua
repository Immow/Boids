local newSlider = require("classes.slider")
local newTextBox = require("classes.textbox")
local newContainer = require("classes.container")
local settings = require("settings")
require("lib.positionElements")

local Gui = {}
local container

function Gui:load()
	container = newContainer.new({
		x = 0,
		y = WINDOW_HEIGHT - 80,
		width = WINDOW_WIDTH,
		height = 80,
		position = "bottom"
	})

	local slider1 = newSlider.new({
		position = "parent",
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
		position = "bottom",
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
		position = "bottom",
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
		position = "right",
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
		position = "right",
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
		position = "right",
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
		position = "right",
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
		position = "right",
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
		position = "right",
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
		position = "right",
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
		position = "right",
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
		position = "right",
		id = "textBox6",
		target_id = "slider6",
		offsetX = 5,
		width = 70,
		height = 20,
		valueReference = "perceptionRadius",
		tableReference = settings.sliderSettings.separation,
		font = Percentage
	})

	container:addChilds(slider1, slider2, slider3, textBox1, textBox2, textBox3, slider4, slider5, slider6, textBox4, textBox5, textBox6)
end

function Gui:draw() container:draw() end

function Gui:update(dt) container:update(dt) end

function Gui:resize() container:resize() end

return Gui

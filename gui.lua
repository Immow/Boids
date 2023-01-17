local newSlider = require("classes.slider")
local newTextBox = require("classes.textbox")
local newContainer = require("classes.container")
local settings = require("settings")
require("lib.positionElements")

local Gui = {}
local container

function Gui:load()
	container = newContainer.new({x = 0, y = WINDOW_HEIGHT - 100, width = WINDOW_WIDTH, height = 100})

	local slider1 = newSlider.new({
					position = "parent",
					id = "slider1",
					target_id = "parent",
					height = 20,
					width = 150,
					valueReference = "alignmentFactor",
					tableReference = settings.sliderSettings,
					sliderRangeMax = settings.sliderSettings.sliderRangeMax,
					sliderRangeMin = settings.sliderSettings.sliderRangeMin
				})
				
	local slider2 = newSlider.new({
					position = "bottom",
					id = "slider2",
					target_id = "slider1",
					offset = 5,
					height = 20,
					width = 150,
					valueReference = "cohesionFactor",
					tableReference = settings.sliderSettings,
					sliderRangeMax = settings.sliderSettings.sliderRangeMax,
					sliderRangeMin = settings.sliderSettings.sliderRangeMin
				})
				
	local slider3 = newSlider.new({
					position = "bottom",
					id = "slider3",
					target_id = "slider2",
					offset = 5,
					height = 20,
					width = 150,
					valueReference = "separationFactor",
					tableReference = settings.sliderSettings,
					sliderRangeMax = settings.sliderSettings.sliderRangeMax,
					sliderRangeMin = settings.sliderSettings.sliderRangeMin
				})

	local textBox1 = newTextBox.new({
						position = "right",
						id = "textBox1",
						target_id = "slider1",
						offset = 5,
						width = 70,
						height = 20,
						valueReference = "alignmentFactor",
						tableReference = settings.sliderSettings,
						font = Percentage
					})

	local textBox2 = newTextBox.new({
						position = "right",
						id = "textBox2",
						target_id = "slider2",
						offset = 5,
						width = 70,
						height = 20,
						valueReference = "cohesionFactor",
						tableReference = settings.sliderSettings,
						font = Percentage
					})

	local textBox3 = newTextBox.new({
						position = "right",
						id = "textBox3",
						target_id = "slider3",
						offset = 5,
						width = 70,
						height = 20,
						valueReference = "separationFactor",
						tableReference = settings.sliderSettings,
						font = Percentage
					})
	
	container:addChilds(
		slider1, slider2, slider3, textBox1, textBox2, textBox3
	)
end

function Gui:draw()
	container:draw()
end

function Gui:update(dt)
	container:update(dt)
end

return Gui
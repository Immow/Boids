local newSlider = require("classes.slider")
local newTextBox = require("classes.textbox")
local newContainer = require("classes.container")
local settings = require("settings")
require("lib.positionElements")

local Gui = {}
local sliders = {}
local textBoxes = {}
local container

function Gui:load()
	container = newContainer.new({x = 0, y = WINDOW_HEIGHT - 100, width = WINDOW_WIDTH, height = 100})

	local slider1 = newSlider.new({
					x = container:getValue("x"),
					y = container:getValue("y"),
					height = 20,
					width = 150,
					valueReference = "alignmentFactor",
					tableReference = settings.sliderSettings,
					sliderRangeMax = settings.sliderSettings.sliderRangeMax,
					sliderRangeMin = settings.sliderSettings.sliderRangeMin
				})
				
	local slider2 = newSlider.new({
					x = slider1:getValue("x"),
					y = slider1:below(10),
					height = 20,
					width = 150,
					valueReference = "cohesionFactor",
					tableReference = settings.sliderSettings,
					sliderRangeMax = settings.sliderSettings.sliderRangeMax,
					sliderRangeMin = settings.sliderSettings.sliderRangeMin
				})
				
	local slider3 = newSlider.new({
					x = slider2:getValue("x"),
					y = slider2:below(10),
					height = 20,
					width = 150,
					valueReference = "separationFactor",
					tableReference = settings.sliderSettings,
					sliderRangeMax = settings.sliderSettings.sliderRangeMax,
					sliderRangeMin = settings.sliderSettings.sliderRangeMin
				})

	local textBox1 = newTextBox.new({
						x = slider1:right(5),
						y = slider1:getValue("y"),
						width = 70,
						height = 20,
						valueReference = "alignmentFactor",
						tableReference = settings.sliderSettings,
						font = Percentage
					})

	local textBox2 = newTextBox.new({
						x = slider2:right(5),
						y = slider2:getValue("y"),
						width = 70,
						height = 20,
						valueReference = "cohesionFactor",
						tableReference = settings.sliderSettings,
						font = Percentage
					})

	local textBox3 = newTextBox.new({
						x = slider3:right(5),
						y = slider3:getValue("y"),
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
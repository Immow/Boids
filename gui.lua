local newSlider = require("classes.slider")
local newTextBox = require("classes.textbox")
local settings = require("settings")
require("lib.positionElements")

local Gui = {}
local sliders = {}
local textBoxes = {}

function Gui:load()
	local slider1 = newSlider.new({
					x = 10,
					y = 250,
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

	sliders = {slider1, slider2, slider3}
	textBoxes = {textBox1, textBox2, textBox3}
end


function Gui:draw()
	for i = 1, #sliders do
		sliders[i]:draw()
	end
	for i = 1, #textBoxes do
		textBoxes[i]:draw()
	end
end

function Gui:update(dt)
	for i = 1, #sliders do
		sliders[i]:update(dt)
	end
end

return Gui
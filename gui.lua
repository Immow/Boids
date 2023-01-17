local newSlider = require("classes.slider")
local newTextBox = require("classes.textbox")
local newContainer = require("classes.container")
local settings = require("settings")
require("lib.positionElements")

local Gui = {}
local sliders = {}
local textBoxes = {}
local container

-- FUNCTION TO PRINT TABLES
function tprint (tbl, indent)
	if not indent then indent = 0 end
	local toprint = string.rep(" ", indent) .. "{\r\n"
	indent = indent + 2 
	for k, v in pairs(tbl) do
		toprint = toprint .. string.rep(" ", indent)
		if (type(k) == "number") then
			toprint = toprint .. "[" .. k .. "] = "
		elseif (type(k) == "string") then
			toprint = toprint  .. k ..  "= "   
		end
		if (type(v) == "number") then
			toprint = toprint .. v .. ",\r\n"
		elseif (type(v) == "string") then
			toprint = toprint .. "\"" .. v .. "\",\r\n"
		elseif (type(v) == "table") then
			toprint = toprint .. tprint(v, indent + 2) .. ",\r\n"
		else
			toprint = toprint .. "\"" .. tostring(v) .. "\",\r\n"
		end
	end
	toprint = toprint .. string.rep(" ", indent-2) .. "}"
	return toprint
end

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

	sliders = {slider1, slider2, slider3}
	textBoxes = {textBox1, textBox2, textBox3}
	
	container:addChild(
		slider1, slider2, slider3, textBox1, textBox2, textBox3
	)
end


function Gui:draw()
	container:draw()
	-- for i = 1, #sliders do
	-- 	sliders[i]:draw()
	-- end
	-- for i = 1, #textBoxes do
	-- 	textBoxes[i]:draw()
	-- end
end

function Gui:update(dt)
	-- if love.keyboard.isDown("up") then
	-- 	container.y = container.y - 1
	-- elseif love.keyboard.isDown("down") then
	-- 	container.y = container.y + 1
	-- end

	-- for i = 1, #sliders do
	-- 	sliders[i]:update(dt)
	-- end
	container:update(dt)
end

return Gui
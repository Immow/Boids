local newTextBox = require("classes.textbox")

local TextBox = {}
local textBoxes = {}

function TextBox:load()
	textBoxes = {
		newTextBox.new({x = 0, y = 0, width = 100, height = 20, valueID = "AlignmentFactor", tableID = "SliderSettings", font = Percentage})
	}
end


function TextBox:draw()
	for i = 1, #textBoxes do
		textBoxes[i]:draw()
	end
end

function TextBox:update(dt)
	-- for i = 1, #textBoxes do
	-- 	textBoxes[i]:update(dt)
	-- end
end

return TextBox
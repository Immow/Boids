local newSlider = require("classes.slider")

local Slider = {}
local sliders = {}

function Slider:load()
	sliders = {
		newSlider.new({x = 10, y = 10, parrent_height = 80, parrent_width = 300, id = "AlignmentFactor", sliderRangeMax = 4, sliderRangeMin = 0}),
		newSlider.new({x = 10, y = 50, parrent_height = 80, parrent_width = 300, id = "CohesionFactor", sliderRangeMax = 4, sliderRangeMin = 0}),
		newSlider.new({x = 10, y = 90, parrent_height = 80, parrent_width = 300, id = "SeparationFactor", sliderRangeMax = 4, sliderRangeMin = 0}),
	}
end


function Slider:draw()
	for i = 1, #sliders do
		sliders[i]:draw()
	end
end

function Slider:update(dt)
	for i = 1, #sliders do
		sliders[i]:update(dt)
	end
end

return Slider
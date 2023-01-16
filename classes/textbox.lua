local PositionElements = require("lib.positionElements")
local settings = require("settings")

local TextBox = {}
local TextBox_meta = {}
TextBox.__index = TextBox
TextBox_meta.__index = TextBox_meta
setmetatable(TextBox, TextBox_meta)
setmetatable(TextBox_meta, PositionElements)

function TextBox.new(settings)
	local instance = setmetatable({}, TextBox)
	for key, value in pairs(settings) do
		if not instance.key then
			instance[key] = value
		end
	end

	instance.x              = settings.x or 0
	instance.y              = settings.y or 0
	instance.width          = settings.width or 200
	instance.height         = settings.height or 80
	instance.font           = settings.font
	instance.valueReference = settings.valueReference
	instance.tableReference = settings.tableReference
	instance.text           = settings.text
	instance.displayAsPercentage = settings.displayAsPercentage or false
	return instance
end

function TextBox:drawBackground()
	love.graphics.setColor(Colors.gray[600])
	love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
	love.graphics.reset()
end

function TextBox:drawText()
	love.graphics.setFont(self.font)
	local text = self.tableReference[self.valueReference]
	-- local percentage = math.floor(100 / ( (self.width - self.knob_width) / (self.knob_x - self.groove_x)))
	local percentage = math.floor(text / settings.sliderSettings.sliderRangeMax * 100)
	local width = self.font:getWidth(tostring(percentage))
	local height = self.font:getHeight()
	local x = self.x + self.width / 2 - width / 2
	local y = self.y + self.height / 2 - height / 2
	love.graphics.setColor(Colors.white)
	love.graphics.print(percentage, x, y)
	love.graphics.reset()
	love.graphics.setFont(Default)
end

function TextBox:draw()
	self:drawBackground()
	self:drawText()
	self:debug()
end

return TextBox
local PositionElements = require("lib.positionElements")
local s = require("settings")

-- LuaFormatter off

local TextBox = {}
local TextBox_meta = {}
TextBox.__index = TextBox
TextBox_meta.__index = TextBox_meta
setmetatable(TextBox, TextBox_meta)
setmetatable(TextBox_meta, PositionElements)

---@class TextBox
---@param settings {x: integer, y: integer, width: integer, height: integer, position: string, id: string, target_id: string, offsetX: integer, offsetY: integer, font: any, valueReference: any, tableReference: any, text: string, displayAsPercentage: boolean}
function TextBox.new(settings)
	local instance = setmetatable({}, TextBox)
	instance.x                   = settings.x or 0
	instance.y                   = settings.y or 0
	instance.width               = settings.width or 200
	instance.height              = settings.height or 80
	instance.position            = settings.position
	instance.id                  = settings.id
	instance.target_id           = settings.target_id
	instance.offsetX             = settings.offsetX or 0
	instance.offsetY             = settings.offsetY or 0
	instance.font                = settings.font
	instance.valueReference      = settings.valueReference
	instance.tableReference      = settings.tableReference
	instance.text                = settings.text
	instance.displayAsPercentage = settings.displayAsPercentage or false
	return instance
end

-- LuaFormatter on

function TextBox:drawBackground()
	love.graphics.setColor(Colors.gray[600])
	love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
	love.graphics.reset()
end

function TextBox:drawText()
	love.graphics.setFont(self.font)
	local text = self.tableReference[self.valueReference]
	-- local percentage = math.floor(100 / ( (self.width - self.knob_width) / (self.knob_x - self.groove_x)))
	local percentage = math.floor(text / s.sliderSettings.sliderRangeMax * 100)
	local width = self.font:getWidth(percentage)
	local height = self.font:getHeight()
	local x = self.x + self.width / 2 - width / 2
	local y = self.y + self.height / 2 - height / 2
	love.graphics.setColor(Colors.white)
	love.graphics.print(tostring(percentage), x, y)
	love.graphics.reset()
	love.graphics.setFont(Default)
end

function TextBox:draw()
	self:drawBackground()
	self:drawText()
	self:debug()
end

function TextBox:update() end

return TextBox

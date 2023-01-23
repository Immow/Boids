local PositionElements = require("lib.positionElements")

-- LuaFormatter off

local TextBox = {}
local TextBox_meta = {}
TextBox.__index = TextBox
TextBox_meta.__index = TextBox_meta
setmetatable(TextBox, TextBox_meta)
setmetatable(TextBox_meta, PositionElements)

---@class TextBox
---@param settings {x: integer, y: integer, w: integer, h: integer, font: any, valueReference: any, text: string, displayAsPercentage: boolean, offset_top: integer, offset_bottom: integer, offset_left: integer, offset_right: integer}
function TextBox.new(settings)
	local instance = setmetatable({}, TextBox)
	instance.x                   = settings.x or 0
	instance.y                   = settings.y or 0
	instance.w                   = settings.w or 100
	instance.h                   = settings.h or 50
	instance.font                = settings.font or love.graphics.getFont()
	instance.text                = settings.text or settings.valueReference or ""
	instance.displayAsPercentage = settings.displayAsPercentage or false
	instance.offset_top          = settings.offset_top or 0
	instance.offset_bottom       = settings.offset_bottom or 0
	instance.offset_left         = settings.offset_left or 0
	instance.offset_right        = settings.offset_right or 0
	instance.start_x             = settings.x or 0
	instance.start_y             = settings.y or 0

	return instance
end

-- LuaFormatter on

function TextBox:drawBackground()
	love.graphics.setColor(Colors.gray[600])
	love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
	love.graphics.reset()
end

function TextBox:drawText()
	love.graphics.setFont(self.font)
	local width = self.font:getWidth(self.text)
	local height = self.font:getHeight()
	local x = self.x + self.w / 2 - width / 2
	local y = self.y + self.h / 2 - height / 2
	love.graphics.setColor(Colors.white)
	love.graphics.print(self.text, x, y)
	love.graphics.reset()
	love.graphics.setFont(Default)
end

function TextBox:draw()
	self:drawBackground()
	self:drawText()
	self:debug()
end

function TextBox:updatePosition()
	if self.x ~= self.start_x then
		self.start_x = self.x
	end
end

function TextBox:update()
	self:updatePosition()
end

return TextBox

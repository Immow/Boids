local PositionElements = require("lib.positionElements")
local mathx = require("lib.mathx")

-- LuaFormatter off

local TextBox = {}
local TextBox_meta = {}
TextBox.__index = TextBox
TextBox_meta.__index = TextBox_meta
setmetatable(TextBox, TextBox_meta)
setmetatable(TextBox_meta, PositionElements)

---@class TextBox
---@param settings {x: integer, y: integer, w: integer, h: integer, font: any, valueReference: any, text: any, displayAsPercentage: boolean, offset: {top: integer, bottom: integer, left: integer, right: integer}, decimal_points: integer}
function TextBox.new(settings)
	local instance = setmetatable({}, TextBox)
	instance.x                   = settings.x or 0
	instance.y                   = settings.y or 0
	instance.w                   = settings.w or 100
	instance.h                   = settings.h or 50
	instance.font                = settings.font or love.graphics.getFont()
	instance.text                = settings.text or ""
	instance.displayAsPercentage = settings.displayAsPercentage or false
	instance.offset              = TextBox.getOffset(settings)
	instance.start_x             = settings.x or 0
	instance.start_y             = settings.y or 0
	instance.decimal_points      = settings.decimal_points or 1

	return instance
end

-- LuaFormatter on

function TextBox:drawBackground()
	love.graphics.setColor(Colors.gray[600])
	love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
	love.graphics.reset()
end

function TextBox:drawText()
	local text = self.text
	if type(self.text) == "function" then
		text = self.text()
	end

	if type(text) == "number" then
		text = mathx.to_precision(text, self.decimal_points)
	end

	love.graphics.setFont(self.font)
	local w = self.font:getWidth(text)
	local h = self.font:getHeight()
	local x = self.x + self.w / 2 - w / 2
	local y = self.y + self.h / 2 - h / 2
	love.graphics.setColor(Colors.white)
	love.graphics.print(text, x, y)
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

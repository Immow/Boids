-- LuaFormatter off

local PositionElements = require("lib.positionElements")

-- LuaFormatter off

local Slider = {}
local Slider_meta = {}
Slider.__index = Slider
Slider_meta.__index = Slider_meta
setmetatable(Slider, Slider_meta)
setmetatable(Slider_meta, PositionElements)

---@class Slider
---@param settings {x: integer, y: integer, w: integer, h: integer, groove_h: integer, knob_w: integer, knob_h: integer, sliderRangeMax: integer, sliderRangeMin: integer, startValue: integer, offset: {top: integer, bottom: integer, left: integer, right: integer}}
function Slider.new(settings)
	local instance = setmetatable({}, Slider)
	instance.startValue     = settings.startValue or 0
	instance.x              = settings.x or 0
	instance.y              = settings.y or 0
	instance.w              = settings.w or 100
	instance.h              = settings.h or 50
	instance.groove_h       = settings.groove_h or 8
	instance.knob_w         = settings.knob_w or 20
	instance.knob_h         = settings.knob_h or 20
	instance.knob_x         = instance.x + (settings.w - instance.knob_w) * instance.startValue
	instance.start_x        = settings.x or 0
	instance.start_y        = settings.y or 0
	instance.sliderRangeMax = settings.sliderRangeMax or 1
	instance.sliderRangeMin = settings.sliderRangeMin or 0
	instance.offset         = Slider.getOffset(settings)
	instance.active         = false

	return instance
end

-- LuaFormatter on

function Slider:containsPointKnob(x, y)
	local knob_y = self.y + self.h / 2 - self.knob_h / 2
	local rangeX = x >= self.knob_x and x <= self.knob_x + self.knob_w
	local rangeY = y >= knob_y and y <= knob_y + self.knob_h
	return rangeX and rangeY
end

function Slider:containsPointGroove(x, y)
	local groove_y = self.y + self.h / 2 - self.groove_h / 2
	local rangeX = x >= self.x and x <= self.x + self.w
	local rangeY = y >= groove_y and y <= groove_y + self.groove_h
	return rangeX and rangeY
end

function Slider:getValue()
	local value = self.sliderRangeMin + ((self.knob_x - self.x) / (self.w - self.knob_w))
		              * (self.sliderRangeMax - self.sliderRangeMin)
	if value < 0 + self.sliderRangeMin then
		return 0 + self.sliderRangeMin
	elseif value > 1 + self.sliderRangeMax then
		return 1 + self.sliderRangeMax
	end
	return value
end

function Slider:mousemoved(x, y, dx, dy, istouch)
	if love.mouse.isDown(1) and self:containsPointKnob(x, y) then
		self.active = true
	end
	if self.active and x > self.x and x < self.x + self.w then
		self.knob_x = self.knob_x + dx
		self:getValue()
	end
end

function Slider:mousepressed(x, y, button, istouch, presses)
	if button == 1 and self:containsPointGroove(x, y) and not self:containsPointKnob(x, y) then
		self.knob_x = x - self.knob_w / 2
	end
end

function Slider:mousereleased(x, y, button, istouch, presses)
	self.active = false
end

function Slider:maintainBounds()
	if self.knob_x < self.x then
		self.knob_x = self.x
	elseif self.knob_x + self.knob_w > self.x + self.w then
		self.knob_x = self.x + self.w - self.knob_w
	end
end

function Slider:updatePosition()
	if self.x ~= self.start_x then
		self.knob_x = self.x - self.start_x + self.knob_x
		self.start_x = self.x
	end
end

function Slider:update(dt)
	self:updatePosition()
	self:maintainBounds()
end

function Slider:drawGroove()
	love.graphics.setColor(Colors.gray[700])
	local y = self.y + self.h / 2 - self.groove_h / 2
	love.graphics.rectangle("fill", self.x, y, self.w, self.groove_h)
end

function Slider:drawKnob()
	local y = self.y + self.h / 2 - self.knob_h / 2
	love.graphics.setColor(Colors.white)
	love.graphics.rectangle("fill", self.knob_x, y, self.knob_w, self.knob_h)
	love.graphics.setColor(Colors.black)
	love.graphics.rectangle("line", self.knob_x, y, self.knob_w, self.knob_h)
	love.graphics.setColor(1, 1, 1)
end

function Slider:draw()
	self:drawGroove()
	self:drawKnob()
end

return Slider

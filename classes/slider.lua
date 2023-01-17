local PositionElements = require("lib.positionElements")

local Slider = {}
local Slider_meta = {}
Slider.__index = Slider
Slider_meta.__index = Slider_meta
setmetatable(Slider, Slider_meta)
setmetatable(Slider_meta, PositionElements)

function Slider.new(settings)
	local instance = setmetatable({}, Slider)
	instance.x              = settings.x or 0
	instance.y              = settings.y or 0
	instance.position       = settings.position
	instance.id             = settings.id
	instance.target_id      = settings.target_id
	instance.offset         = settings.offset or 0
	instance.width          = settings.width or 200
	instance.height         = settings.height or 80
	instance.knob_width     = settings.know_width or 20
	instance.knob_height    = settings.knob_height or 20
	instance.knob_x         = instance.x + instance.width / 2 - instance.knob_width / 2
	instance.knob_y         = instance.y + instance.height / 2 - instance.knob_height / 2
	instance.groove_width   = settings.width
	instance.groove_height  = 4
	instance.groove_x       = instance.x
	instance.groove_y       = instance.y + instance.height / 2 - instance.groove_height / 2
	instance.valueReference = settings.valueReference
	instance.tableReference = settings.tableReference
	instance.sliderRangeMax = settings.sliderRangeMax or 1
	instance.sliderRangeMin = settings.sliderRangeMin or 0
	instance.startX         = instance.x
	instance.startY         = instance.y
	return instance
end

function Slider:containsPoint(x, y)
	return x >= self.knob_x and x <= self.knob_x + self.knob_width and y >= self.knob_y and y <= self.knob_y + self.knob_height
end

function Slider:update(dt)
	if self.x ~= self.startX then
		self.groove_x = self.x
		self.knob_x = self.x + self.knob_x
		self.startX = self.x
	end

	if self.y ~= self.startY then
		self.groove_y = self.y + self.height / 2 - self.groove_height / 2
		self.knob_y = self.y + self.height / 2 - self.knob_height / 2
		self.startY = self.y
	end

	local mx, my = love.mouse.getPosition()
	if love.mouse.isDown(1) and self:containsPoint(mx, my) then
		self.knob_x = mx - self.knob_width / 2
	end
	
	if self.knob_x < self.groove_x then
		self.knob_x = self.groove_x
	end

	if self.knob_x + self.knob_width > self.groove_x + self.width then
		self.knob_x = self.groove_x + self.width - self.knob_width
	end

	self.tableReference[self.valueReference] = self.sliderRangeMin + ((self.knob_x - self.groove_x) / (self.width - self.knob_width)) * (self.sliderRangeMax - self.sliderRangeMin)
end

function Slider:drawGroove()
	love.graphics.setColor(Colors.gray[700])
	love.graphics.rectangle("fill", self.groove_x, self.groove_y, self.width, self.groove_height)
end

function Slider:drawKnob()
	love.graphics.setColor(Colors.white)
	love.graphics.rectangle("fill", self.knob_x, self.knob_y, self.knob_width, self.knob_height, 1, 1)
	love.graphics.setColor(Colors.black)
	love.graphics.rectangle("line", self.knob_x, self.knob_y, self.knob_width, self.knob_height, 1, 1)
	love.graphics.reset()
end

function Slider:draw()
	self:drawGroove()
	self:drawKnob()
	self:debug()
end

return Slider
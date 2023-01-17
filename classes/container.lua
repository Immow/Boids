local PositionElements = require("lib.positionElements")

local Container = {}
local Container_meta = {}
Container.__index = Container
Container_meta.__index = Container_meta
setmetatable(Container, Container_meta)
setmetatable(Container_meta, PositionElements)

function Container.new(settings)
	local instance = setmetatable({}, Container)
	instance.x      = settings.x or 0
	instance.y      = settings.y or 0
	instance.width  = settings.width or 100
	instance.height = settings.height or 50
	instance.childeren = {}
	return instance
end

function Container:addChild(...)
	for i = 1, select("#", ...) do
		local child = select(i, ...)
		table.insert(self.childeren, child)
	end
end

function Container:update(dt)
	for _, child in ipairs(self.childeren) do
		child:update(dt)
	end
end

function Container:draw()
	for _, child in ipairs(self.childeren) do
		child:draw()
	end
	self:debug()
end

return Container
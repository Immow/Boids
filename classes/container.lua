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
	return instance
end

function Container:update(dt)
	
end

function Container:draw()
	self:debug()
end

return Container
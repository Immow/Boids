local PositionElements = {}
PositionElements.__index = PositionElements

function PositionElements:getValue(arg)
	return self[arg]
end

function PositionElements:setPosition(x, y)
	self.x = x
	self.y = y
end

function PositionElements:right(offset)
	offset = offset or 0
	return self.x + self.width + offset
end

function PositionElements:below(offset)
	offset = offset or 0
	return self.y + self.height + offset
end

return PositionElements
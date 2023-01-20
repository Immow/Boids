local PositionElements = {}
PositionElements.__index = PositionElements

function PositionElements:getValue(arg)
	return self[arg]
end

function PositionElements:setPosition(x, y)
	self.x = x
	self.y = y
end

function PositionElements:getPosition()
	return self.x, self.y
end

function PositionElements:right(x, y)
	return self.x + self.width + x, self.y + y
end

function PositionElements:bottom(x, y)
	return self.x + x, self.y + self.height + y
end

function PositionElements:left(x, y, width)
	return self.x - (x + width), self.y + y
end

function PositionElements:top(x, y, height)
	return self.x + x, self.y - (height + y)
end

function PositionElements:debug()
	if DEBUG then
		love.graphics.setColor(1,0,0)
		love.graphics.print(self.id, self.x, self.y)
		love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
		love.graphics.setColor(1,1,1)
	end
end

return PositionElements
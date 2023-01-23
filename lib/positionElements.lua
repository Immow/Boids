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

function PositionElements:debug()
	if DEBUG then
		love.graphics.setColor(1,0,0)
		love.graphics.rectangle("line", self.x, self.y, self.w, self.h)
		love.graphics.print("x: "..self.x..", y:"..self.y, self.x, self.y)
		love.graphics.setColor(1,1,1)
	end
end

return PositionElements
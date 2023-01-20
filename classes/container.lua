local PositionElements = require("lib.positionElements")

local Container = {}
local Container_meta = {}

-- LuaFormatter off

Container.__index = Container
Container_meta.__index = Container_meta
setmetatable(Container, Container_meta)
setmetatable(Container_meta, PositionElements)

---@class Container
---@param settings {x: integer, y: integer, width: integer, height: integer}
function Container.new(settings)
	local instance = setmetatable({}, Container)
	instance.x        = settings.x or 0
	instance.y        = settings.y or 0
	instance.width    = settings.width or 100
	instance.height   = settings.height or 50
	instance.children = {}
	instance.childIndex = {}
	instance.id = "container"
	return instance
end

-- LuaFormatter on

function Container:addChilds(...)
	for i = 1, select("#", ...) do
		local child = select(i, ...)
		self.children[i] = child
		self.childIndex[child.id] = i
	end
end

function Container:positionChildren(dt)
	for i, child in ipairs(self.children) do
		if child.position == "TL-P" then
			child:setPosition(self.x + child.offsetX, self.y + child.offsetY)
		elseif child.position == "TR-P" then
			child:setPosition(self.x + self.width - child.width + child.offsetX, self.y + child.offsetY)
		elseif child.position == "BR-P" then
			child:setPosition(self.x + self.width - child.width + child.offsetX, self.y + self.height - child.height + child.offsetY)
		elseif child.position == "BL-P" then
			child:setPosition(self.x + child.offsetX, self.y + self.height - child.height + child.offsetY)
		elseif child.position == "TM-P" then
			child:setPosition(self.x + self.width / 2 + child.offsetX - child.width / 2, self.y + child.offsetY)
		elseif child.position == "B-C" then
			local x, y = self.children[self.childIndex[child.target_id]]:bottom(child.offsetX, child.offsetY)
			child:setPosition(x, y)
		elseif child.position == "R-C" then
			local x, y = self.children[self.childIndex[child.target_id]]:right(child.offsetX, child.offsetY)
			child:setPosition(x, y)
		elseif child.position == "L-C" then
			local x, y = self.children[self.childIndex[child.target_id]]:left(child.offsetX, child.offsetY, child.width)
			child:setPosition(x, y)
		elseif child.position == "T-C" then
			local x, y = self.children[self.childIndex[child.target_id]]:top(child.offsetX, child.offsetY, child.height)
			child:setPosition(x, y)
		end
		child:update(dt)
	end
end

function Container:mousepressed(x, y, button, istouch, presses)
	for _, child in ipairs(self.children) do
		if child.mousepressed then
			child:mousepressed(x, y, button, istouch, presses)
		end
	end
end

function Container:mousereleased(x, y, button, istouch, presses)
	for _, child in ipairs(self.children) do
		if child.mousereleased then
			child:mousereleased(x, y, button, istouch, presses)
		end
	end
end

function Container:update(dt)
	self:positionChildren(dt)

	if love.keyboard.isDown("up") then
		self.y = self.y - 1
	elseif love.keyboard.isDown("down") then
		self.y = self.y + 1
	end
end

function Container:draw()
	for _, child in ipairs(self.children) do
		child:draw()
	end
	self:debug()
end

return Container

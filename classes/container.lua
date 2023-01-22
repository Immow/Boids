local PositionElements = require("lib.positionElements")

local Container = {}
local Container_meta = {}

-- LuaFormatter off

Container.__index = Container
Container_meta.__index = Container_meta
setmetatable(Container, Container_meta)
setmetatable(Container_meta, PositionElements)

---@class Container
---@param settings {x: integer, y: integer, w: integer, h: integer, children: table, offset_top: integer, offset_bottom: integer, offset_left: integer, offset_right: integer}
function Container.new(settings)
	local instance = setmetatable({}, Container)
	instance.x             = settings.x or 0
	instance.y             = settings.y or 0
	instance.w         = settings.w or 100
	instance.h        = settings.h or 50
	instance.offset_top    = settings.offset_top or 0
	instance.offset_bottom = settings.offset_bottom or 0
	instance.offset_left   = settings.offset_left or 0
	instance.offset_right  = settings.offset_right or 0
	instance.children      = settings.children or {}
	instance.childIndex    = {}
	instance.id            = "container"

	return instance
end

-- LuaFormatter on


-- function Container:addChilds(...)
-- 	-- for i = 1, select("#", ...) do
-- 		-- 	local child = select(i, ...)
-- 		-- 	self.children[i] = child
-- 		-- 	self.childIndex[child.id] = i
-- 		-- end
-- 		for i = 1, select("#", ...) do
-- 			local child = select(i, ...)
-- 			self.children[i] = child
-- 		end
-- 		self:setChildPosition()
-- end

function Container:setChildPosition()
	local y = self.y
	for _, child in ipairs(self.children) do
		y = y + child.offset_top
		child:setPosition(0, y)
		y = y + child.offset_bottom + child.h
	end
end

function Container:positionChildren(dt)
	for _, child in ipairs(self.children) do
		self:setChildPosition()
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

function Container:mousemoved(x, y, dx, dy, istouch)
	for _, child in ipairs(self.children) do
		if child.mousemoved then
			child:mousemoved(x, y, dx, dy, istouch)
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

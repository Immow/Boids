local PositionElements = require("lib.positionElements")

local Container = {}
local Container_meta = {}

-- LuaFormatter off

Container.__index = Container
Container_meta.__index = Container_meta
setmetatable(Container, Container_meta)
setmetatable(Container_meta, PositionElements)

---@class Container
---@param settings {x: integer, y: integer, w: integer, h: integer, children: table, offset: {top: integer, bottom: integer, left: integer, right: integer}, alignment: {horizontal: boolean, vertical: boolean}, id: string, spacing: {evenly: boolean, between: boolean|integer}}
function Container.new(settings)
	local instance = setmetatable({}, Container)
	if not settings.alignment or (not settings.alignment.vertical and not settings.alignment.horizontal) then
		error("Did not specify an alignment")
	end

	instance.x             = settings.x or 0
	instance.y             = settings.y or 0
	instance.w             = settings.w or Container:getChildrenTotalWidth(settings)
	instance.h             = settings.h or Container:getChildrenTotalHeight(settings)
	instance.offset        = Container.getOffset(settings)
	instance.children      = settings.children or {}
	instance.childIndex    = {}
	instance.id            = settings.id or "container"
	instance.alignment     = settings.alignment
	instance.spacing       = settings.spacing or {}
print(instance.h)
	return instance
end

-- LuaFormatter on

function Container:getChildrenTotalHeight(settings)
	local offset = Container.getOffset(settings)
	if #settings.children == 0 then
		print("Warning: Did not specify a container height and no children")
		return 100
	end
	local h = 0
	for i, child in ipairs(settings.children) do
		if settings.alignment.horizontal then
			if child.h > h then
				h = child.h
			end
		else
			h = h + child.h
			if i ~= 1 and settings.spacing  and settings.spacing.between then
				h = h + settings.spacing.between
			end
		end
	end
	return h + offset.top + offset.bottom
end

function Container:getChildrenTotalWidth(settings)
	local offset = Container.getOffset(settings)
	if #settings.children == 0 then
		print("Warning: Did not specify a container width and no children")
		return 100
	end
	local w = 0
	for _, child in ipairs(settings.children) do
		if settings.alignment.vertical then
			if child.offset.left + child.offset.right + child.w > w then
				w = child.offset.left + child.offset.right + child.w
			end
		else
			w = w + child.offset.left + child.offset.right + child.w
		end
	end

	return w + offset.left + offset.right
end

function Container:setChildPosition()
	if self.alignment.vertical then
		local y = self.y
		for i, child in ipairs(self.children) do
			if i == 1 then y = y + self.offset.top end
			if self.spacing.evenly then
				local spacing = (self.h - self:getChildrenTotalHeight(self)) / (#self.children + 1)
				y = y + spacing
				child:setPosition(self.x + self.offset.left, y)
				y = y + child.h
			elseif self.spacing.between then
				local spacing = (self.h - self:getChildrenTotalHeight(self)) / (#self.children - 1) + self.spacing.between
				child:setPosition(self.x  + self.offset.left, y)
				y = y + child.h + spacing
			else
				y = y + child.offset.top
				child:setPosition(self.x + child.offset.left, y)
				y = y + child.offset.bottom + child.h
			end
		end
	elseif self.alignment.horizontal then
		local x = self.x
		for i, child in ipairs(self.children) do
			if i == 1 then x = x + self.offset.left end
			if self.spacing.evenly then
				local spacing  = (self.w - self:getChildrenTotalWidth(self)) / (#self.children + 1)
				x = x + spacing
				child:setPosition(x, self.y + self.offset.top)
				x = x + child.w
			elseif self.spacing.between then
				local spacing  = (self.w - self:getChildrenTotalWidth(self)) / (#self.children - 1) + self.spacing.between
				child:setPosition(x, self.y + self.offset.top)
				x = x + spacing + child.w
			else
				x = x + child.offset.left
				child:setPosition(x, self.y + self.offset.top)
				x = x + child.offset.right + child.w
			end
		end
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

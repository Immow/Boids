local PositionElements = require("lib.positionElements")

local Container = {}
local Container_meta = {}

-- LuaFormatter off

Container.__index = Container
Container_meta.__index = Container_meta
setmetatable(Container, Container_meta)
setmetatable(Container_meta, PositionElements)

---@class Container
---@param settings {x: integer, y: integer, w: integer, h: integer, children: table, offset_top: integer, offset_bottom: integer, offset_left: integer, offset_right: integer, alignment: {horizontal: boolean, vertical: boolean}, id: string, spacing: {evenly: boolean, spaceBetween: boolean}}
function Container.new(settings)
	local instance = setmetatable({}, Container)
	if not settings.alignment or (not settings.alignment.vertical and not settings.alignment.horizontal) then
		error("Did not specify an alignment")
	end

	instance.x             = settings.x or 0
	instance.y             = settings.y or 0
	instance.w             = settings.w or Container:getChildrenTotalWidth(settings)
	instance.h             = settings.h or Container:getChildrenTotalHeight(settings)
	instance.offset_top    = settings.offset_top or 0
	instance.offset_bottom = settings.offset_bottom or 0
	instance.offset_left   = settings.offset_left or 0
	instance.offset_right  = settings.offset_right or 0
	instance.children      = settings.children or {}
	instance.childIndex    = {}
	instance.id            = settings.id or "container"
	instance.alignment     = settings.alignment
	instance.spacing       = settings.spacing or {}

	return instance
end

-- LuaFormatter on

function Container:getChildrenTotalHeight(settings)
	if #settings.children == 0 then
		print("Warning: Did not specify a container height and no children")
		return 100
	end
	local h = 0
	for _, child in ipairs(settings.children) do
		if settings.alignment.horizontal then
			if child.offset_top + child.offset_bottom + child.h > h then
				h = child.offset_top + child.offset_bottom + child.h
			end
		else
			h = h + child.offset_top + child.offset_bottom + child.h
		end
	end

	return h
end

function Container:getChildrenTotalWidth(settings)
	if #settings.children == 0 then
		print("Warning: Did not specify a container width and no children")
		return 100
	end
	local w = 0
	for _, child in ipairs(settings.children) do
		if settings.alignment.vertical then
			if child.offset_left + child.offset_right + child.w > w then
				w = child.offset_left + child.offset_right + child.w
			end
		else
			w  = w + child.offset_left + child.offset_right + child.w
		end
	end

	return w
end

function Container:setChildPosition()
	if self.alignment.vertical then
		local y = self.y
		for _, child in ipairs(self.children) do
			local spacing = (self.h - self:getChildrenTotalHeight(self)) / (#self.children + 1)
			if self.spacing.evenly then
				y = y + spacing
				child:setPosition(self.x + y)
				y = y + child.h
			else
				y = y + child.offset_top
				child:setPosition(self.x + child.offset_left, y)
				y = y + child.offset_bottom + child.h
			end
		end
	elseif self.alignment.horizontal then
		local x = self.x
		for _, child in ipairs(self.children) do
			local spacing  = (self.w - self:getChildrenTotalWidth(self)) / (#self.children + 1)
			if self.spacing.evenly then
				x = x + spacing
				child:setPosition(x, self.y)
				x = x + child.w
			else
				x = x + child.offset_left
				child:setPosition(x, self.y)
				x = x + child.offset_right + child.w
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

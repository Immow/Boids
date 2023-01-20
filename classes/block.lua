local PositionElements = require("lib.positionElements")

-- LuaFormatter off

local TextBox = {}
local TextBox_meta = {}
TextBox.__index = TextBox
TextBox_meta.__index = TextBox_meta
setmetatable(TextBox, TextBox_meta)
setmetatable(TextBox_meta, PositionElements)

---@class TextBox
---@param settings {x: integer, y: integer, width: integer, height: integer, position: string, id: string, target_id: string, offset: integer}
function TextBox.new(settings)
	local instance = setmetatable({}, TextBox)
	instance.x                   = settings.x or 0
	instance.y                   = settings.y or 0
	instance.width               = settings.width or 200
	instance.height              = settings.height or 80
	instance.position            = settings.position
	instance.id                  = settings.id
	instance.target_id           = settings.target_id
	instance.offset              = settings.offset or 0
	return instance
end

-- LuaFormatter on

function TextBox:drawBackground()
	love.graphics.setColor(Colors.gray[600])
	love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
	love.graphics.reset()
end

function TextBox:draw()
	self:drawBackground()
	self:debug()
end

function TextBox:update() end

return TextBox

State = require("state")
Colors = require("lib.colors")
Flux = require("lib.flux")
require("constants")
require("globals")

Default       = love.graphics.newFont("assets/font/Roboto-Regular.ttf", 12)
Percentage    = love.graphics.newFont("assets/font/Roboto-Regular.ttf", 16)

function love.load()
	State.addScene("game")
	State.setScene("game")
	State:load()
end

function love.mousepressed(mx, my, mouseButton)
	State:mousepressed(mx, my, mouseButton)
end

function love.mousereleased(mx, my, mouseButton)
	State:mousereleased(mx, my, mouseButton)
end

function love.keypressed(key,scancode,isrepeat)
	State:keypressed(key,scancode,isrepeat)
	if scancode == "space" then
		love.event.quit("restart")
	end
end

function love.draw()
	State:draw()
end

function love.update(dt)
	State:update(dt)
	Flux.update(dt)
end
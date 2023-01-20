local Game = {boids = {}}
local Boid = require("classes.boid")
local Gui = require("gui")
local Settings = require("settings")
local mathx = require("lib.math")

function Game:spawnBoid(n)
	for i = 1, n do
		table.insert(self.boids, Boid.new({}))
	end
end

function Game:load()
	self:spawnBoid(Settings.boidAmount)
	Gui:load()
end

function Game:mousepressed(mx, my, mouseButton)
	Gui:mousepressed(mx, my, mouseButton)
end

function Game:mousereleased(x,y,button,istouch,presses)
	Gui:mousereleased(x,y,button,istouch,presses)
end

function Game:keypressed(key,scancode,isrepeat)
	if scancode == "space" then
		love.event.quit("restart")
	elseif scancode == "d" then
		love.filesystem.write("log.txt", "")
		for _, boid in ipairs(self.boids) do
			local line = boid.position.x
			if string.match(line, "nan") then
				love.filesystem.append("log.txt", line)
			end
		end
	end
	Gui:keypressed(key,scancode,isrepeat)
end

function Game:drawAlignmentPerceptionRadius(boid)
	love.graphics.setColor(0,1,0)
	love.graphics.circle("line", boid.position.x, boid.position.y, Settings.sliderSettings.alignment.perceptionRadius)
end

function Game:drawCohesionPerceptionRadius(boid)
	love.graphics.setColor(0,0,1)
	love.graphics.circle("line", boid.position.x, boid.position.y, Settings.sliderSettings.cohesion.perceptionRadius)
end

function Game:drawSeparationPerceptionRadius(boid)
	love.graphics.setColor(1,1,0)
	love.graphics.circle("line", boid.position.x, boid.position.y, Settings.sliderSettings.separation.perceptionRadius)
end

function Game:draw()
	local totalXVelocity = 0
	local totalYVelocity = 0
	for i, boid in ipairs(self.boids) do
		if i == 1 then
			self:drawAlignmentPerceptionRadius(boid)
			self:drawCohesionPerceptionRadius(boid)
			self:drawSeparationPerceptionRadius(boid)
			love.graphics.setColor(1,0,0)
			boid:draw()
		else
			love.graphics.setColor(1,1,1)
			boid:draw()
		end
		totalXVelocity = totalXVelocity + boid.velocity.x
		totalYVelocity = totalYVelocity + boid.velocity.y
	end
	love.graphics.print("Average Xvel.: "..mathx.to_precision(totalXVelocity / Settings.boidAmount, 2), 5, 0)
	love.graphics.print("Average Yvel.: "..mathx.to_precision(totalYVelocity / Settings.boidAmount, 2), 5, 20)
	love.graphics.print("FPS: "..love.timer.getFPS(), 5, 40)
	Gui:draw()
end

function Game:update(dt)
	for _, boid in ipairs(self.boids) do
		boid:flock(self.boids)
		boid:update(dt)
	end
	Gui:update(dt)
	-- love.timer.sleep(1/150)
end

return Game
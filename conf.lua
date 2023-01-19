function love.conf(t)
	t.title = "Boids"
	t.identity = "Boids"
	t.version = "11.4"
	t.console = true
	t.window.width = 640
	t.window.height = 360
	t.window.msaa = 8
	t.modules.joystick = false
	t.modules.physics = false
	t.externalstorage = true
	t.window.vsync = 0
	t.window.resizable = true
end
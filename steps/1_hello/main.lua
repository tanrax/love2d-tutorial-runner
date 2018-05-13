function love.load()
	love.window.setMode(800, 480)
end

function love.draw()
	love.graphics.print('Hola a todos!!', 400 , 200)
end

function love.keypressed(key, scancode, isrepeat)
	if key == 'escape' then
		love.event.push('quit')
	end
end

function love.load()
	game = {}
	game.width = 800
	game.height = 480
	love.window.setMode(game.width, game.height)
end

function love.update(dt)
end

function love.draw()
end

-- Controls
function love.keypressed(key, scancode, isrepeat)
	if key == 'escape' then
		love.event.push('quit')
	end
end

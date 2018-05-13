function love.load()
	game = {}
	game.width = 800
	game.height = 480
	love.window.setMode(game.width, game.height)
	-- Background
	background = {}
	background.img = love.graphics.newImage('assets/sprites/background.jpg')
	background.x = 0
	background.y = 0
end

function love.update(dt)
end

function love.draw()
	-- Background
	love.graphics.draw(background.img, background.x, background.y)
end

-- Controls
function love.keypressed(key, scancode, isrepeat)
	if key == 'escape' then
		love.event.push('quit')
	end
end

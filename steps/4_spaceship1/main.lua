function love.load()
	game = {}
	game.width = 800
	game.height = 480
	love.window.setMode(game.width, game.height)
	score = { x = 500, y = 40 }
	-- Background
	background = {}
	background.img = love.graphics.newImage('assets/sprites/background.jpg')
	background.x = 0
	background.y = 0
        -- Spaceship
	spaceship = {}
	spaceship.img = love.graphics.newImage('assets/sprites/spaceship.png')
	spaceship.x = 200
	spaceship.y = 200
end

function love.draw()
	-- Background
	love.graphics.draw(background.img, background.x, background.y)
	-- Spaceship
	love.graphics.draw(spaceship.img, spaceship.x, spaceship.y)
end

-- Controls
function love.keypressed(key, scancode, isrepeat)
	if key == 'escape' then
		love.event.push('quit')
	end
end

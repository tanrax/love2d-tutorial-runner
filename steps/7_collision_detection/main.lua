function love.load()
	math.randomseed(os.time())
	game = {}
	game.width = 800
	game.height = 480
	game.play = true
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
	spaceship.x = game.height / 8
	spaceship.num_frames = 4
	spaceship.pos_frame = 1
  	spaceship.frame_height = spaceship.img:getHeight() / spaceship.num_frames
	spaceship.y = {
		(game.height / 4) - (spaceship.img:getHeight() / 8),	
		2 * (game.height / 4) - (spaceship.img:getHeight() / 8),	
		3 * (game.height / 4) - (spaceship.img:getHeight() / 8),	
	}
	spaceship.pos = 1
	spaceship.frames = {
                 love.graphics.newQuad(0, spaceship.frame_height * 0, spaceship.img:getWidth(), spaceship.frame_height, spaceship.img:getWidth(), spaceship.img:getHeight()),
                 love.graphics.newQuad(0, spaceship.frame_height * 1, spaceship.img:getWidth(), spaceship.frame_height, spaceship.img:getWidth(), spaceship.img:getHeight()),
                 love.graphics.newQuad(0, spaceship.frame_height * 2, spaceship.img:getWidth(), spaceship.frame_height, spaceship.img:getWidth(), spaceship.img:getHeight()),
                 love.graphics.newQuad(0, spaceship.frame_height * 3, spaceship.img:getWidth(), spaceship.frame_height, spaceship.img:getWidth(), spaceship.img:getHeight())
             }

        -- Asteroids
	num_asteroids = 3
	asteroids = {}
	for i = 1, num_asteroids do
		asteroid = {}
		asteroid.img = love.graphics.newImage('assets/sprites/asteroid_' .. tostring(math.random(1, 9)) .. '.png')
		asteroid.x = game.width
		asteroid.y = {
			(game.height / 4) - (asteroid.img:getHeight() / 2),	
			2 * (game.height / 4) - (asteroid.img:getHeight() / 2),	
			3 * (game.height / 4) - (asteroid.img:getHeight() / 2),	
		}
		asteroid.pos = 2
		asteroid.speed = 600
		asteroids[i] = asteroid
		if checkCollision(spaceship.x, spaceship.y[spaceship.pos], spaceship.img:getWidth(), spaceship.img:getHeight() / spaceship.num_frames / 2, asteroid.x, asteroid.y[asteroid.pos], asteroid.img:getWidth(), asteroid.img:getHeight()) then
                        game.play = false
                        explosion.animate = true
                        explosion.x = spaceship.x
                        explosion.y = spaceship.y[spaceship.pos]
                end

	end
end

function love.draw()
	-- Background
	love.graphics.draw(background.img, background.x, background.y)
	-- Spaceship
	if game.play then
		love.graphics.draw(spaceship.img, spaceship.frames[spaceship.pos_frame], spaceship.x, spaceship.y[spaceship.pos])
	end
	-- Asteroids
	for key, asteroid in pairs(asteroids) do
		love.graphics.draw(asteroid.img, asteroid.x, asteroid.y[asteroid.pos])
	end
end

function love.update(dt)
        -- Spaceship
        if spaceship.pos_frame ~= spaceship.num_frames then
		spaceship.pos_frame = spaceship.pos_frame + 1
	else
		spaceship.pos_frame = 1
	end
        -- Asteroids
        for key, asteroid in pairs(asteroids) do
		asteroid.x = asteroid.x - (dt * asteroid.speed)
		if asteroid.x < -asteroid.img:getWidth() then
			asteroid.x = game.width + math.random(0, game.width)
			asteroid.pos = math.random(1, 3)
		end
		if checkCollision(spaceship.x, spaceship.y[spaceship.pos], spaceship.img:getWidth(), spaceship.img:getHeight() / spaceship.num_frames / 2, asteroid.x, asteroid.y[asteroid.pos], asteroid.img:getWidth(), asteroid.img:getHeight()) then
			game.play = false
		end
        end
end

-- Controls
function love.keypressed(key, scancode, isrepeat)
	if key == 'escape' then
		love.event.push('quit')
	end
        if key == 'up' and spaceship.pos > 1 then
		spaceship.pos = spaceship.pos - 1
	elseif key == 'down' and spaceship.pos < 3 then
		spaceship.pos = spaceship.pos + 1
	end
end

function checkCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2 + w2 and
         x2 < x1 + w1 and
         y1 < y2 + h2 and
         y2 < y1 + h1
end


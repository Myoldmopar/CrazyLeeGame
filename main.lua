daxton = { x = 100, y = 80, img = nil, win = false, orig_y = 80 }
gibson = { x = 400, y = 80, img = nil, win = false, orig_y = 80 }
min_y = 80

function love.load()
	daxton.img = love.graphics.newImage('images/daxton.png')
	gibson.img = love.graphics.newImage('images/gibson.png')
end

function love.draw()
	love.graphics.print("Move Daxton with a and z", 0, 0, 0, 1.5)
	love.graphics.print("Move Gibson with m and k", 0, 20, 0, 1.5)
	love.graphics.print("Exit with ESC", 0, 40, 0, 1.5)
	love.graphics.print(" **** START: **************************************************************************************", 0, 60)
	love.graphics.print(" **** FINISH: **************************************************************************************", 0, 500)
	love.graphics.draw(gibson.img, gibson.x, gibson.y)
	if gibson.win then
		love.graphics.print("GIBSON WINS - PRESS R", 250, 0, 0, 3)
	end
	love.graphics.draw(daxton.img, daxton.x, daxton.y)
	if daxton.win then
		love.graphics.print("DAXTON WINS - PRESS R", 250, 0, 0, 3)
	end
end

function love.update(dt)
	increment = 5
	if love.keyboard.isDown('escape') then
		love.event.push('quit')
	end
	if gibson.win or daxton.win then
		if love.keyboard.isDown('r') then
			gibson.win = false
			gibson.y = gibson.orig_y
			daxton.win = false
			daxton.y = daxton.orig_y
		else
			return
		end

	end
	if love.keyboard.isDown('z') then
		daxton.y = daxton.y + increment 
	elseif love.keyboard.isDown('a') then
		daxton.y = daxton.y - increment
	elseif love.keyboard.isDown('m') then
		gibson.y = gibson.y + increment
	elseif love.keyboard.isDown('k') then
		gibson.y = gibson.y - increment
	end
	winning_y = 280
	gibson.y = math.max( gibson.y, 80 )
	daxton.y = math.max( daxton.y, 80 )
	if gibson.y > winning_y then
		gibson.win = true
	elseif daxton.y > winning_y then
		daxton.win = true
	end
end

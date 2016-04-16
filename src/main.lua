canShootTimerMax = 0.25
daxton = { x = 100, y = 80, img = nil, win = false, orig_y = 80, can_shoot = true, canShootTimer = canShootTimerMax }
gibson = { x = 400, y = 80, img = nil, win = false, orig_y = 80, can_shoot = true, canShootTimer = canShootTimerMax }
bulletImg = nil
bullets = {}
min_y = 80
enemies = {}
finish_y = 800
local enemyclass = require 'enemy'

function love.load()
	daxton.img = love.graphics.newImage('images/daxton.png')
	gibson.img = love.graphics.newImage('images/gibson.png')
	bulletImg = love.graphics.newImage('images/reddot.png')
end

function love.draw()
	love.graphics.print("Move Daxton with a and z", 0, 0, 0, 1.5)
	love.graphics.print("Move Gibson with m and k", 0, 20, 0, 1.5)
	love.graphics.print("Exit with ESC", 0, 40, 0, 1.5)
	love.graphics.print(" **** START: **************************************************************************************", 0, 60)
	love.graphics.print(" **** FINISH: **************************************************************************************", 0, finish_y)
	love.graphics.draw(gibson.img, gibson.x, gibson.y)
	if gibson.win then
		love.graphics.print("GIBSON WINS - PRESS R", 250, 0, 0, 3)
	end
	love.graphics.draw(daxton.img, daxton.x, daxton.y)
	if daxton.win then
		love.graphics.print("DAXTON WINS - PRESS R", 250, 0, 0, 3)
	end
	for i, bullet in ipairs(bullets) do
		love.graphics.draw(bullet.img, bullet.x, bullet.y)
	end
	for i, enemy in ipairs(enemies) do
		love.graphics.draw(enemy.img, enemy.x, enemy.y)
	end
end

function love.update(dt)
	if math.random() > 0.95 then
		thisenemy = enemyclass:new()
		table.insert(enemies, thisenemy)
	end
	for i, enemy in ipairs(enemies) do
		--print(enemy)
		--love.event.push('quit')
		enemy.y = enemy.y + 10
		if enemy.y > finish_y then
			table.remove(enemies, i)
		end
	end
	gibson.canShootTimer = gibson.canShootTimer - dt
	if gibson.canShootTimer < 0 then
 		gibson.canShoot = true
 	end
	daxton.canShootTimer = daxton.canShootTimer - dt
	if daxton.canShootTimer < 0 then
		daxton.canShoot = true
	end
	for i, bullet in ipairs(bullets) do
		bullet.y = bullet.y + (250 * dt)
		if bullet.y > finish_y then -- remove bullets when they pass off the screen
			table.remove(bullets, i)
		end
	end	
	if love.keyboard.isDown('o') and gibson.canShoot then
 		newBullet = { x = gibson.x + (gibson.img:getWidth()/2) - (bulletImg:getWidth()/2), y = gibson.y+gibson.img:getHeight(), img = bulletImg }
		table.insert(bullets, newBullet)
		gibson.canShoot = false
		gibson.canShootTimer = canShootTimerMax
	end
	if love.keyboard.isDown('q') and daxton.canShoot then
		newBullet = { x = daxton.x + (daxton.img:getWidth()/2) - (bulletImg:getWidth()/2), y = daxton.y+daxton.img:getHeight(), img = bulletImg }
		table.insert(bullets, newBullet)
		daxton.canShoot = false
		daxton.canShootTimer = canShootTimerMax
	end
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
	winning_y = finish_y - 220
	gibson.y = math.max( gibson.y, 80 )
	daxton.y = math.max( daxton.y, 80 )
	if gibson.y > winning_y then
		gibson.win = true
	elseif daxton.y > winning_y then
		daxton.win = true
	end
end

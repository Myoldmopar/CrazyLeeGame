local enemy = {}

enemyImg = love.graphics.newImage("images/enemy.png")

function enemy:new()
	return {x = math.random(1, 300), y = math.random(1, 600), angle = math.random(5, 85), img = enemyImg}
end

function enemy:update(dt)
	self.y = self.y + 10
end

function enemy:draw()
	love.graphics.draw(self.x, self.y, self.img)
end

return enemy
	

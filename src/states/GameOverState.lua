GameOverState = Class{__includes = BaseState}

function GameOverState:init()

end

function GameOverState:enter(params)
	self.victory = params.victory
end

function GameOverState:exit()
end


function GameOverState:update(dt)

  if love.keyboard.wasPressed('escape') then
        love.event.quit()
  end

  if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
    gStateMachine:change('play')
  end

end

function GameOverState:render()

	if self.victory == true then

		love.graphics.setFont(largeFont)
		love.graphics.setColor(255, 223, 0, 255)
		love.graphics.printf('CONGRATULATIONS!', 0, 64, VIRTUAL_WIDTH, 'center')
		love.graphics.setFont(mediumFont)
		love.graphics.setColor(255, 223, 0, 235)
		love.graphics.printf('Press Enter To Play Again', 0, 104, VIRTUAL_WIDTH, 'center')
		love.graphics.setFont(mediumFont)
		love.graphics.setColor(255, 223, 0, 215)
		love.graphics.printf('OR', 0, 119, VIRTUAL_WIDTH, 'center')
		love.graphics.setFont(mediumFont)
		love.graphics.setColor(255, 223, 0, 195)
		love.graphics.printf('Press Escape To Quit', 0, 134, VIRTUAL_WIDTH, 'center')

	else

	    love.graphics.setFont(largeFont)
	    love.graphics.setColor(211, 211, 211, 255)
	    love.graphics.printf('BETTER LUCK NEXT TIME!', 0, 64, VIRTUAL_WIDTH, 'center')
	    love.graphics.setFont(mediumFont)
	    love.graphics.setColor(211, 211, 211, 235)
	    love.graphics.printf('Press Enter To Try Again', 0, 104, VIRTUAL_WIDTH, 'center')
	    love.graphics.setFont(mediumFont)
	    love.graphics.setColor(211, 211, 211, 215)
	    love.graphics.printf('OR', 0, 119, VIRTUAL_WIDTH, 'center')
	    love.graphics.setFont(mediumFont)
	    love.graphics.setColor(211, 211, 211, 195)
	    love.graphics.printf('Press Escape To Quit', 0, 134, VIRTUAL_WIDTH, 'center')

	end

end
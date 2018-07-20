TitleScreenState = Class{__includes = BaseState}

function TitleScreenState:init()

end

function TitleScreenState:enter()
end

function TitleScreenState:exit()
end


function TitleScreenState:update(dt)

  if love.keyboard.wasPressed('escape') then
        love.event.quit()
  end

  if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
    gStateMachine:change('play')
  end
end

function TitleScreenState:render()

  --[[  Each bit of text is rendered alone
        The opacity and color changes for aesthetic purposes
        I was experimenting with this
        
    ]]


  

  love.graphics.setFont(largeFont)
  love.graphics.setColor(255, 102, 102, 255)
  love.graphics.printf('Hang Man', 0, 64, VIRTUAL_WIDTH, 'center')
  
  love.graphics.setFont(mediumFont)
  love.graphics.setColor(255, 140, 102, 255)
  love.graphics.printf('Press Enter To Start', 0, 104, VIRTUAL_WIDTH, 'center')
  
  love.graphics.setFont(mediumFont)
  love.graphics.setColor(255, 217, 102, 255)
  love.graphics.printf('OR', 0, 119, VIRTUAL_WIDTH, 'center')
  
  love.graphics.setFont(mediumFont)
  love.graphics.setColor(255, 255, 102, 255)
  love.graphics.printf('Press Escape To Quit', 0, 134, VIRTUAL_WIDTH, 'center')

end
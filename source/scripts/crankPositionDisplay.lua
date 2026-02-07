-- Script for displaying the current position of the crank
-- A small black circle rotates around a larger hollow circle to indicate the position of the crank

import "CoreLibs/crank"

local pd <const> = playdate
local gfx <const> = pd.graphics
local geom <const> = playdate.geometry

class('crankPositionDisplay').extends(gfx.sprite)

function crankPositionDisplay:init(r)

    -- create outside hollow circle

    -- create smaller filled circle on edge of the larger circle
    

    -- draw both circles in one image
    local playerImage = gfx.image.new(self.side, self.side)
    gfx.lockFocus(playerImage)
        gfx.drawPolygon(self.polygon)
        gfx.fillPolygon(self.smallPolygon)
    gfx.unlockFocus()
    self:setImage(playerImage)

    --collision settings
    self:setCollideRect(self.width*0.2, self.height*0.2, self.width*0.8, self.height*0.8)
    self:setGroups(PLAYER_GROUP)
    --only collides with meteors, not bullets
    self:setCollidesWithGroups(METEOR_GROUP)

    self:moveTo(xOffset, yOffset)
    self:add()    

end


-- function Player:update()

--     if CRANK_CONTROLS then
--         -- use crank to rotate player
--         self:setRotation(self:getRotation() + pd.getCrankChange())
--     else
--         -- press down to rotate in Playdate "positive" direction
--         if pd.buttonIsPressed(pd.kButtonDown) then
--             self:setRotation(self:getRotation() + self.rotateSpeed)    
            
--         -- press up to rotate in the Playdate "negative" direction
--         elseif pd.buttonIsPressed(pd.kButtonUp) then
--             self:setRotation(self:getRotation() - self.rotateSpeed)
--         end
--     end
    
--     -- shoot bullets
--     if pd.buttonJustPressed(pd.kButtonA) then

--         local x, y = calcAngleOffset(self:getRotation(), (self.h / 2) - 1, 0, -self.h/2)
--         local bulletX = self.x + x
--         local bulletY = self.y + y

--         --turn off collisions before spawning bullet so bullet doesn't collide with player
--         Bullet(bulletX, bulletY, 5, self:getRotation())
        
--     end

-- end
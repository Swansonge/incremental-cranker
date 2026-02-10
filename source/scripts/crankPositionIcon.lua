-- Script for displaying the current position of the crank
-- A small black circle rotates around a larger hollow circle to indicate the position of the crank

local pd <const> = playdate
local gfx <const> = pd.graphics
local geom <const> = playdate.geometry

import "CoreLibs/crank"

class('CrankPositionIcon').extends(gfx.sprite)


-- crank position display initialization functions
-- Inputs:
--  r (int) - radius of the large circle of the icon
--  xOffset (int) - x offset from the top right edge of the screen. Should default to using 0.
--  yOffset (int) - y offset from the top right edge of the screen. Should default to using 0.
function CrankPositionIcon:init(r, xOffset, yOffset)

    self.r = r - 1
    -- radius of smaller outer circle
    self.smallR = self.r / 6

    -- offset image from the edge of the screen. Use the circle's radius, plus offset (default 0), plus some margin
    self.xPos = 400 - self.r - self.smallR - xOffset - 5
    self.yPos = self.r + self.smallR + yOffset + 5
    
    -- draw both circles in one image
    local crankPositionImage = gfx.image.new((self.r * 2) + (self.smallR * 2), (self.r * 2) + (self.smallR * 2))
    gfx.lockFocus(crankPositionImage)
        gfx.drawCircleAtPoint(self.r + self.smallR, self.r + self.smallR, self.r)
        gfx.fillCircleAtPoint(self.r + self.smallR, self.smallR, self.smallR)
    gfx.unlockFocus()
    self:setImage(crankPositionImage)

    self:moveTo(self.xPos, self.yPos)
    self:add()    

end


function CrankPositionIcon:update()

    if pd.isCrankDocked() then
       -- do nothing
    else
        -- get the angle of the crank
        local crankPosition = playdate.getCrankPosition()

        -- calculate position of small outer circle. Updates self.smallX and self.smallY
        self:calcSmallCirclePos(crankPosition)
        -- redraw sprite with new position
        local crankPositionImage = gfx.image.new((self.r * 2) + (self.smallR * 2), (self.r * 2) + (self.smallR * 2))
        gfx.lockFocus(crankPositionImage)
            gfx.drawCircleAtPoint(self.r + self.smallR, self.r + self.smallR, self.r)
            gfx.fillCircleAtPoint(self.smallX + self.smallR, self.smallY + self.smallR, self.smallR)
        gfx.unlockFocus()
        self:setImage(crankPositionImage)

    end
end

-- Calculate the position of the small circle on the edge of
-- of the large inner circle. Uses the following formulas:
-- x_small = x_large + (r_large - r_small) * cos(angle)
-- y_small = y_large + (r_large - r_small) * sin(angle)
-- Inputs:
--  angle (float) - angle of the crank
function CrankPositionIcon:calcSmallCirclePos(angle)

    self.smallX = self.r + self.r * math.sin(math.rad(angle))
    self.smallY  = self.r + self.r * math.cos(math.rad(angle - 180))
end
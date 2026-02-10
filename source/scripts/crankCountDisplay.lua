-- Script for displaying total number of cranks

import "CoreLibs/crank"

local pd <const> = playdate
local gfx <const> = pd.graphics

class('CrankCountDisplay').extends(gfx.sprite)

-- Init function for crankCountDisplay
-- Inputs:
--  xOffset (int) - x offset from the top right edge of the screen
--  yOffset (int) - y offset from the top right edge of the screen
function CrankCountDisplay:init(xOffset, yOffset)
    self.xOffset = xOffset
    self.yOffset = yOffset

    self:updateCrankCountDisplay()

    --keep track of text width and height so they can be uodated as text is added
    self.lastWidth = self.textWidth
    self.lastHeight = self.textHeight

    self:setCenter(0, 0)
    self:moveTo(400 - self.xOffset - self.textWidth, self.yOffset + self.textHeight)

    -- make it so crank display doesn't shake with screen and objects travel over it 
    self:setIgnoresDrawOffset(true)
    self:setZIndex(100)
    
    self:add()
end


-- NEED TO DOCUMENT
function CrankCountDisplay:updateCrankCountDisplay()
    local crankText = "crank count: " .. CRANK_COUNT
    self.textWidth, self.textHeight = gfx.getTextSize(crankText)

    local crankCountImage = gfx.image.new(self.textWidth, self.textHeight)
    gfx.pushContext(crankCountImage)
        gfx.drawText(crankText, 0, 0)
    gfx.popContext()
    self:setImage(crankCountImage)
end

function CrankCountDisplay:update()

    -- if width or height changed, update the position of the text
    if self.lastWidth ~= self.textWidth then
        self:moveTo(400 - self.xOffset - self.textWidth, self.yOffset + self.textHeight)
        self.lastWidth = self.textWidth
    elseif self.lastHeight ~= self.textHeight then
        self:moveTo(400 - self.xOffset - self.textWidth, self.yOffset + self.textHeight)
        self.lastHeight = self.textHeight
    end 

end


-- NEED TO DOCUMENT
function CrankCountDisplay:incrementCrankCount()
    CRANK_COUNT = CRANK_COUNT + CRANK_MULT
    self:updateCrankCountDisplay()
end
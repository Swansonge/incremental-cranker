-- Script for displaying total number of cranks

import "CoreLibs/crank"

local pd <const> = playdate
local gfx <const> = pd.graphics

local crankCountSprite

function createCrankCountDisplay()
    crankCountSprite = gfx.sprite.new()

    updateCrankCountDisplay()
    crankCountSprite:setCenter(0, 0)
    crankCountSprite:moveTo(200, 120)

    -- make it so crank display doesn't shake with screen and objects travel over it 
    crankCountSprite:setIgnoresDrawOffset(true)
    crankCountSprite:setZIndex(100)
    
    crankCountSprite:add()
end

function updateCrankCountDisplay()
    local crankText = "crank count: " .. CRANK_COUNT
    local textWidth, textHeight = gfx.getTextSize(crankText)
    local crankCountImage = gfx.image.new(textWidth, textHeight)
    gfx.pushContext(crankCountImage)
        gfx.drawText(crankText, 0, 0)
    gfx.popContext()
    crankCountSprite:setImage(crankCountImage)
end

function incrementCrankCount()
    CRANK_COUNT = CRANK_COUNT + CRANK_MULT
    updateCrankCountDisplay()
end
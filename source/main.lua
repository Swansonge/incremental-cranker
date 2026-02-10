-- Main script for incremental cranker game

-- IMPORTS
import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import "CoreLibs/math"
import "CoreLibs/animator"
import "CoreLibs/ui"

import "globals"
import "scripts/crankCountDisplay"
import "scripts/crankPositionIcon"

-- Localizing commonly used globals
local pd <const> = playdate
local gfx <const> = playdate.graphics

-- initialize crank count display. Calculate position using dimensions of CrankPositionIcon
crankCountSprite = CrankCountDisplay(10, -10)

-- use width, height, and offsets from crank counter to create offsets for crank position icon
local crankPositionRadius = 25
local counterWidth, counterHeight = crankCountSprite:getSize()
local positionIconOffsetX = (counterWidth / 5) + (crankPositionRadius / 2)
local positionIconOffsetY = counterHeight + (crankPositionRadius / 2)
CrankPositionIcon(crankPositionRadius, positionIconOffsetX, positionIconOffsetY)

-- playdate.update function is required in every project
function playdate.update()
    gfx.sprite.update()

     -- Draw crank indicator if crank is docked
    if pd.isCrankDocked() then
        pd.ui.crankIndicator:draw()
    else
        local crankTicks = playdate.getCrankTicks(TICKS_PER_REVOLUTION)

        -- every forward crank, increment counter
        if crankTicks == 1 then
            crankCountSprite:incrementCrankCount()
        end
    end
end

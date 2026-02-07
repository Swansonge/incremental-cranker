-- Main script for incremental cranker game

-- IMPORTS
import "CoreLibs/graphics"
import "CoreLibs/ui"

import "globals"
import "scripts/crankCountDisplay"
--import "scripts/crankPositionDisplay"

-- Localizing commonly used globals
local pd <const> = playdate
local gfx <const> = playdate.graphics

-- need to initialize crank count display
createCrankCountDisplay()

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
            incrementCrankCount()
        end
    end
end

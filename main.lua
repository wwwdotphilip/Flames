local storyboard = require"storyboard";
display.setStatusBar(display.HiddenStatusBar);

storyboard.gotoScene("MainMenu", "fade", 400);

local function checkmem()
    collectgarbage()
    print( "MemUsage: " .. collectgarbage("count") )
    
    local textMem = system.getInfo( "textureMemoryUsed" ) / 1000000
    print( "TexMem:   " .. textMem )
end

timer.performWithDelay(3000, checkmem, 0)

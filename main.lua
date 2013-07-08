local storyboard = require"storyboard"
display.setStatusBar(display.HiddenStatusBar);

storyboard.gotoScene("MainMenu", "fade", 400);

local function onComplete(event)
    if "clicked" == event.action then
        local i = event.index
        if 1 == i then
            os.exit()
        elseif 2 == i then
            
        end
    end
end

local function onKeyEvent( event )
    local phase = event.phase
    local keyName = event.keyName
    
    if(phase == "down" and keyName == "back") then
        native.showAlert("Alert", "Exit application?", {"Yes", "No"}, onComplete)
    end
    return true
end

Runtime:addEventListener( "key", onKeyEvent );

local sysFonts = native.getFontNames()
for k,v in pairs(sysFonts) do print(v) end

local storyboard = require"storyboard"
local widget = require"widget"
local _W = display.contentWidth;
local _H = display.contentHeight;
local screenGroup;
local bg;
local button = {};
local text = {}
local scene = storyboard.newScene();
display.setStatusBar(display.HiddenStatusBar);

local function buttonEvent(event)
    storyboard.gotoScene("MainMenu", "fade", 400)
end

function scene:createScene( event )
    screenGroup = self.view
    bg = display.newImageRect("images/bg.png", _W, _H);
    bg.x = _W / 2 + 50; bg.y = _H / 2;
    
    button.back = widget.newButton{
        defaultFile = "images/button.png",
        overFile = "images/buttonOver.png",
        width = _W - 100,
        height = 120,
        fontSize = 70,
        font = "KatyBerry",
        label = "Go back",
        onRelease = buttonEvent
    };
    button.back.x = _W / 2; button.back.y = (_H / 2) + 310;
    button.back.name = "back"
    
    screenGroup:insert(bg);
    screenGroup:insert(button.back);
end

function scene:enterScene( event )
    local prev = storyboard.getPrevious()
    if(prev ~= nil) then
        storyboard.removeScene(prev)
    end
end

function scene:exitScene( event )
    scene:removeEventListener( "createScene", scene )
    scene:removeEventListener( "enterScene", scene )
    scene:removeEventListener( "exitScene", scene )
    scene:removeEventListener( "destroyScene", scene )
end

function scene:destroyScene( event )
    
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene;




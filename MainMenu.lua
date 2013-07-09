local storyboard = require"storyboard"
local widget = require"widget"
local _W = display.contentWidth;
local _H = display.contentHeight;
local screenGroup;
local bg;
local button = {};
local text = {}
local title;
local scene = storyboard.newScene();
local about = "Flames is a love matching game popular in elementary and high school students who are begining to explore the world of crushes." ..
"\n\nYou can help improve this application by giving suggestions" ..
"\nEmail me at wwwdotphilip@gmail.com" ..
"\nPM me on facebook www.facebook.com/wwwdotphilip" ..
"\nor visit my website at www.lazyjuan.webs.com/" ..
"\n\nVersion 1.0" .. "\nDeveloped by: LaZy Juan"
local disclaimer = "This application is entended for entertainment purposes only. I am not liable for any lost of lives, limbs, love life or any other unfortunate circumstances related to using this application." ..
"\n\nCopyright \nSome images used in this application are from the internet, such as the logo which I obtained from Photobucket user Toshi20. If you saw that one of your work is in this app please notify me, so I can give you credits or want to remove it. And please don't sue me."
display.setStatusBar(display.HiddenStatusBar);

local function buttonEvent(event)
    local t = event.target
    if(t.name == "start") then
        storyboard.gotoScene("FlamesScreen", "fade", 400)
    elseif(t.name == "disclaimer") then
        native.showAlert("Disclaimer", disclaimer, {"Close"})
    else
        native.showAlert("About", about, {"Close"})
    end
end

function scene:createScene( event )
    screenGroup = self.view
    bg = display.newImageRect("images/bg.png", _W, _H);
    bg.x = _W / 2; bg.y = _H / 2;
    
    title = display.newImageRect("images/title.png", _W + 20, 260)
    title.x = _W / 2 + 10; title.y = 220;
    
    button.start = widget.newButton{
        defaultFile = "images/button.png",
        overFile = "images/buttonOver.png",
        width = _W - 100,
        height = 120,
        fontSize = 70,
        font = "KatyBerry",
        label = "Start Flames",
        onRelease = buttonEvent,
        labelYOffset = 10
    };
    button.start.x = _W / 2; button.start.y = _H / 2;
    button.start.name = "start"
    
    button.howto = widget.newButton{
        defaultFile = "images/button.png",
        overFile = "images/buttonOver.png",
        width = _W - 100,
        height = 120,
        fontSize = 70,
        font = "KatyBerry",
        label = "Disclaimer",
        onRelease = buttonEvent,
        labelYOffset = 10
    };
    button.howto.x = _W / 2; button.howto.y = (_H / 2) + 130;
    button.howto.name = "disclaimer"
    
    button.about = widget.newButton{
        defaultFile = "images/button.png",
        overFile = "images/buttonOver.png",
        width = _W - 100,
        height = 120,
        fontSize = 70,
        font = "KatyBerry",
        label = "About",
        onRelease = buttonEvent,
        labelYOffset = 10
    };
    button.about.x = _W / 2; button.about.y = (_H / 2) + 260;
    button.about.name = "about"
    
    screenGroup:insert(bg);
    screenGroup:insert(button.start);
    screenGroup:insert(button.howto);
    screenGroup:insert(button.about);
    screenGroup:insert(title);
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

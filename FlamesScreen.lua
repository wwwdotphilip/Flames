local storyboard = require"storyboard"
local widget = require"widget"
local _W = display.contentWidth;
local _H = display.contentHeight;
local screenGroup;
local bg;
local button = {};
local text = {}
local flames = {{"Friends"},{ "Lovers"},{ "Affectionate"},{ "Marraige"},{ "Enemies"},{ "Sweethearts"}};
local scene = storyboard.newScene();
display.setStatusBar(display.HiddenStatusBar);
local name_one;
local name_two;
local skiprate = false;
local rate = 1;
local skiprate = false;

local function ratelistener(event)
    if(event.index == 1) then
        local options =
        {
            supportedAndroidStores = { "google" },
        }
        native.showPopup("rateApp", options)
    else
        skiprate = true;
    end
end

local function buttonEvent(event)
    local t = event.target
    if(t.name == "get") then
        local name1 = name_one.text
        local name2 = name_two.text
        local str
        local finalname;
        local loopnum = 0
        if(name_one.text ~= "" and name_two.text ~= "") then
            str = name_two.text;
            for i = 1, #str do
                local c = str:sub(i,i)
                name1 = name1:gsub(c, "")
            end
            str = name_one.text;
            for i = 1, #str do
                local c = str:sub(i,i)
                name2 = name2:gsub(c, "")
            end
        end
        finalname = name1..name2
        if(finalname ~= "") then
            for i = 1, #finalname do
                if(i == #finalname) then
                    if(loopnum < 6) then
                        loopnum = loopnum + 1
                    elseif(loopnum > 6) then
                        loopnum = 1
                    elseif(loopnum == 6) then
                        
                    end
                elseif(loopnum <= 5) then
                    loopnum = loopnum + 1;
                elseif(loopnum == 6) then
                    loopnum = 1
                end
                print(loopnum)
            end
        else
            loopnum = 1
        end
        
        print(finalname)
        print(loopnum)
        print(flames[loopnum]);
        local randval =  table.getn(flames[loopnum])
        text.result.text = "As " .. flames[loopnum][math.random(1, randval)];
        native.setKeyboardFocus(nil)
        
        if(rate == 6 and skiprate == false) then
            rate = 1;
            native.showAlert("Alert", "Like this app? Please rate it.", {"Yes", "Later"}, ratelistener)
        elseif(skiprate == true) then
            if(rate == 12) then
                rate = 1;
                native.showAlert("Alert", "Like this app? Please rate it.", {"Yes", "Later"}, ratelistener)
            else
                rate = rate + 1;
            end
        else
            rate = rate + 1;
        end
    elseif(t.name == "reset") then
        name_one.text = "";
        name_two.text = "";
        text.result.text = "";
    else
        transition.to(name_one, {alpha = 0, time = 400})
        transition.to(name_two, {alpha = 0, time = 400})
        storyboard.gotoScene("MainMenu", "fade", 400)
    end
end

local function textlistener(event)
    local t = event.target
    local phase = event.target.phase
    if phase == "began" then
        native.setKeyboardFocus(t)
    end
end

function scene:createScene( event )
    print("Create screen")
    screenGroup = self.view
    bg = display.newImageRect("images/bg.png", _W, _H);
    bg.x = _W / 2; bg.y = _H / 2;
    
    text.andtext = display.newText("&", 0, 0, "KatyBerry", 120)
    text.andtext:setTextColor(0, 0, 0)
    text.andtext.x = _W / 2; text.andtext.y = 160;
    
    text.result = display.newText("", 0, 0, "KatyBerry", 120)
    text.result:setTextColor(0, 0, 0)
    text.result.x = _W / 2; text.result.y = 390;
    
    button.get = widget.newButton{
        defaultFile = "images/button.png",
        overFile = "images/buttonOver.png",
        width = _W - 100,
        height = 120,
        fontSize = 75,
        font = "KatyBerry",
        label = "Get Flames",
        onRelease = buttonEvent,
        labelYOffset = 10
    };
    button.get.x = _W / 2; button.get.y = (_H / 2) + 70;
    button.get.name = "get"
    
    button.reset = widget.newButton{
        defaultFile = "images/button.png",
        overFile = "images/buttonOver.png",
        width = _W - 100,
        height = 120,
        fontSize = 75,
        font = "KatyBerry",
        label = "Reset",
        onRelease = buttonEvent,
        labelYOffset = 10
    };
    button.reset.x = _W / 2; button.reset.y = (_H / 2) + 200;
    button.reset.name = "reset"
    
    button.back = widget.newButton{
        defaultFile = "images/button.png",
        overFile = "images/buttonOver.png",
        width = _W - 100,
        height = 120,
        fontSize = 75,
        font = "KatyBerry",
        label = "Go back",
        onRelease = buttonEvent,
        labelYOffset = 10
    };
    button.back.x = _W / 2; button.back.y = (_H / 2) + 330;
    button.back.name = "back"
    local function createtextfield()
        
        name_one = native.newTextField(20, 20, 600, 85)
        name_one:addEventListener ("userInput", textlistener)
        
        name_two = native.newTextField(20, 210, 600, 85)
        name_two:addEventListener ("userInput", textlistener)
        
        local fontSize = 25;
        
        if( display.contentScaleY < 1 ) then
            fontSize =  fontSize /display.contentScaleY
        end
        
        name_one.font = native.newFont( native.systemFont )
        name_one.size = fontSize
        name_one.inputType = "text"
        
        name_two.font = native.newFont( native.systemFont )
        name_two.size = fontSize
        name_two.inputType = "text"
        
        screenGroup:insert(name_one);
        screenGroup:insert(name_two);
    end
    timer.performWithDelay(400, createtextfield);
    
    screenGroup:insert(bg);
    screenGroup:insert(button.get);
    screenGroup:insert(button.reset);
    screenGroup:insert(button.back);
    screenGroup:insert(text.andtext);
    screenGroup:insert(text.result);
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


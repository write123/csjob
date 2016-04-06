
local MenuScene = class("MenuScene", function()
    return display.newScene("MenuScene")
end)

function MenuScene:ctor()

	-- print("---", display.cx, display.cy)
 --    ui.newTTFLabel({text = "Hello, World", size = 64, align = ui.TEXT_ALIGN_CENTER})
 --        :pos(display.cx, display.cy)
 --        :addTo(self)

 	-- display.newColorLayer(ccc4(255,255,255,255)):addTo(self)
 	display.newSprite("background.png")
 		:pos(display.cx, display.cy)
 		:addTo(self)

 	cc.ui.UIPushButton.new("Button01.png", {scale9 = true})
 		:setButtonSize(160, 60)
 		:setButtonLabel(cc.ui.UILabel.new({text = "开始测试"}))
 		:pos(display.cx, display.cy+60)
 		:onButtonClicked(function()
 				app:enterScene("MainScene", nil, "pageTurn", 0.5, true)
 		end)
 		:onButtonPressed(function(event)
            event.target:setScale(1.1)
        end)
        :onButtonRelease(function(event)
            event.target:setScale(1.0)
        end)
 		:addTo(self)

 	cc.ui.UIPushButton.new("Button01.png", {scale9 = true})
 		:setButtonSize(160, 60)
 		:setButtonLabel(cc.ui.UILabel.new({text = "查看记录"}))
 		:pos(display.cx, display.cy - 30)
 		:onButtonClicked(function()
 				app:enterScene("RecordScene", nil, "pageTurn", 0.5, true)
 		end)
 		:onButtonPressed(function(event)
            event.target:setScale(1.1)
        end)
        :onButtonRelease(function(event)
            event.target:setScale(1.0)
        end)
 		:addTo(self)

local function onButtonClicked(event)
    if event.buttonIndex == 1 then
        os.exit()
    else
        device.cancelAlert()
    end
end

 	cc.ui.UIPushButton.new("Button01.png", {scale9 = true})
 		:setButtonSize(160, 60)
 		:setButtonLabel(cc.ui.UILabel.new({text = "退出"}))
 		:pos(display.cx, display.cy - 60 - 60)
 		:onButtonClicked(function()
			device.showAlert("Confirm Exit", "Are you sure exit game ?", {"YES", "NO"}, onButtonClicked)
 			end)
 		:onButtonPressed(function(event)
            event.target:setScale(1.1)
        end)
        :onButtonRelease(function(event)
            event.target:setScale(1.0)
        end)
 		:addTo(self)

end

function MenuScene:onEnter()
end

function MenuScene:onExit()
end

return MenuScene

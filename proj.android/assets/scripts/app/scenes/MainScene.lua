
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()

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
 		:setButtonLabel(cc.ui.UILabel.new({text = "返回菜单"}))
        :pos(display.left + 120, display.bottom + 80)
 		:onButtonClicked(function()
 				app:enterScene("MenuScene", nil, "pageTurn", 0.5)
 		end)
 		:onButtonPressed(function(event)
            event.target:setScale(1.1)
        end)
        :onButtonRelease(function(event)
            event.target:setScale(1.0)
        end)
 		:addTo(self)

end

function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene

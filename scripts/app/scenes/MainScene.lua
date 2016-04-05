
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()

	-- print("---", display.cx, display.cy)
 --    ui.newTTFLabel({text = "Hello, World", size = 64, align = ui.TEXT_ALIGN_CENTER})
 --        :pos(display.cx, display.cy)
 --        :addTo(self)

 	-- display.newColorLayer(ccc4(255,255,255,255)):addTo(self)

 	cc.ui.UIPushButton.new("Button01.png", {scale9 = true})
 		:setButtonSize(160, 80)
 		:setButtonLabel(cc.ui.UILabel.new({text = "start"}))
 		:pos(display.cx, display.cy)
 		:addTo(self)
end

function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene


local GameScene = class("GameScene", function()
    return display.newScene("GameScene")
end)

function GameScene:ctor()

	-- print("---", display.cx, display.cy)

 	-- display.newColorLayer(ccc4(255,255,255,255)):addTo(self)
 	display.newSprite("background.png")
 		:pos(display.cx, display.cy)
 		:addTo(self)
	
	self._prevBtn = cc.ui.UIPushButton.new({normal="b1.png",pressed="b2.png"})
		:align(display.BOTTOM_CENTER, display.cx-100, display.bottom)
		:addTo(self, 0)
		:onButtonClicked(function()
            app:enterScene("MainScene", nil, "flipy")
        end)

	self._nextBtn = cc.ui.UIPushButton.new({normal="f1.png",pressed="f2.png"})
		:align(display.BOTTOM_CENTER, display.cx+100, display.bottom)
		:addTo(self, 0)
		:onButtonClicked(function()
            os.exit()
        end)

end

function GameScene:onEnter()
end

function GameScene:onExit()
end

return GameScene

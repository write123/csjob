local curLabel = nil
local totalLabel = nil
local cur = nil
local total = nil

local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()

	self.cur = 1
	self.total = 20

 	-- display.newColorLayer(ccc4(255,255,255,255)):addTo(self)
 	display.newSprite("background.png")
 		:pos(display.cx, display.cy)
 		:addTo(self)

 	self:initTopLabel()

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

 	cc.ui.UIPushButton.new("Button01.png", {scale9 = true})
 		:setButtonSize(160, 60)
 		:setButtonLabel(cc.ui.UILabel.new({text = "下一题"}))
        :pos(display.right - 120, display.bottom + 80)
 		:onButtonClicked(function()
 			self:next()
 		end)
 		:onButtonPressed(function(event)
            event.target:setScale(1.1)
        end)
        :onButtonRelease(function(event)
            event.target:setScale(1.0)
        end)
 		:addTo(self)
end

function MainScene:reflush()
	local json = require("framework.shared.json")



end

local function callback(event)  
    local ok = (event.name == "completed")  
    local request = event.request  
    local response = request:getResponseString()  
     print(response)  
    local json=require("framework.shared.json")  
    local t=json.decode(response)  
    print(t)  
end


function MainScene:initTopLabel()
    ui.newTTFLabel({
    	text = "当前第", 
    	size = 24, 
    	align = ui.TEXT_ALIGN_CENTER
    	})
        :pos(display.left + 120, display.top - 40)
        :addTo(self)

    local curLabel = ui.newTTFLabel({
    	text = self.cur,
    	color = ccc3(255,0,0), 
    	size = 24, 
    	align = ui.TEXT_ALIGN_CENTER
    	})
        :pos(display.left + 160, display.top - 40)
        :addTo(self)

    ui.newTTFLabel({
    	text = "题", 
    	size = 24, 
    	align = ui.TEXT_ALIGN_CENTER
    	})
        :pos(display.left + 180, display.top - 40)
        :addTo(self)

    ui.newTTFLabel({
    	text = "共", 
    	size = 24, 
    	align = ui.TEXT_ALIGN_CENTER
    	})
        :pos(display.right - 180, display.top - 40)
        :addTo(self)

    ui.newTTFLabel({
    		text = self.total, 
    		color = ccc3(255,0,0), 
    		size = 24, 
    		align = ui.TEXT_ALIGN_CENTER
    }):pos(display.right - 150, display.top - 40)
      :addTo(self)

    ui.newTTFLabel({
    	text = "题", 
    	size = 24, 
    	align = ui.TEXT_ALIGN_CENTER
    	})
        :pos(display.right - 120, display.top - 40)
        :addTo(self)
end

function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene

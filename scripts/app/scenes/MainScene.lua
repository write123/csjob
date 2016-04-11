local cur = nil
local total = nil
local _data = {}

local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

MainScene.SLIDER_IMAGES = {
    bar = "SliderBar.png",
    button = "SliderButton.png",
}

function MainScene:ctor()

	self.cur = 0
	self.total = 20

 	-- display.newColorLayer(ccc4(255,255,255,255)):addTo(self)
 	display.newSprite("background.png")
 		:pos(display.cx, display.cy)
 		:addTo(self)

 	self:initTopLabel()
    self:refushQuestion()

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
            self:refushQuestion()
 		end)
 		:onButtonPressed(function(event)
            event.target:setScale(1.1)
        end)
        :onButtonRelease(function(event)
            event.target:setScale(1.0)
        end)
 		:addTo(self)
end

function MainScene:init()
    if self:getChildByTag(51) then
        self:removeChildByTag(51)
    end

    if self:getChildByTag(52) then
        self:removeChildByTag(52)
    end

    if self:getChildByTag(61) then
        self:removeChildByTag(61)
    end

    if self:getChildByTag(62) then
        self:removeChildByTag(62)
    end
    -- body
end

function MainScene:refushQuestion()
    self.cur = self.cur + 1
    local data = self:getQuestionData()
    local curLabel = self:getChildByTag(41)
    curLabel:setString(self.cur)
    _data[self.cur] = { type = data.type, score = 0}

    self:reflush(data)

    dump(_data)
end


function MainScene:getQuestionData()
    require("framework.functions")
    require("framework.json")

    local filePath = "configs/cs_question.json"
    local data = {}

    if io.exists(filePath) then 
        local questionFile = io.readfile(filePath)
        local questionJson = json.decode(questionFile)

        data = questionJson[self.cur]
    end

    return data
end

function MainScene:reflush(data)
        self:init()
        
        -- title
        ui.newTTFLabel({
            text = data.title, 
            size = 24, 
            align = ui.TEXT_ALIGN_LEFT
        })
        :pos(display.cx, display.cy+200)
        :addTo(self)
        :setTag(51)

        -- describe
        ui.newTTFLabel({
            text = "(" .. data.describe .. ")", 
            size = 18, 
            align = ui.TEXT_ALIGN_LEFT,
            color = ccc3(255,0,0), 
        })
        :pos(display.cx, display.cy + 200 - 30)
        :addTo(self)
        :setTag(52)

        local barHeight = 30
        local barWidth = 400
        local valueLabel = ui.newTTFLabel({text = "", size = 14, color = display.COLOR_BLACK, align = ui.TEXT_ALIGN_CENTER})
            :pos(display.cx, display.cy + 200 - 100)
            :addTo(self)
        
        valueLabel:setTag(61)

        local score = 0
        local uislider = cc.ui.UISlider.new(display.LEFT_TO_RIGHT, MainScene.SLIDER_IMAGES, {scale9 = true, max = 5, min = 1})
            :onSliderValueChanged(function(event)
                    score =  string.format("%d", event.value)
                    valueLabel:setString(score)
                    _data[self.cur].score = score
                end)
            :setSliderSize(barWidth, barHeight)
            :setSliderValue(2)
            :align(display.CENTER, display.cx, display.cy + 200 - 160 + barHeight / 2)
            :addTo(self)

        uislider:setTag(62)
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
    	size = 22, 
    	align = ui.TEXT_ALIGN_CENTER
    	})
        :pos(display.left + 170, display.top - 42)
        :addTo(self)

    curLabel:setTag(41)

    ui.newTTFLabel({
    	text = "题", 
    	size = 24, 
    	align = ui.TEXT_ALIGN_CENTER
    	})
        :pos(display.left + 200, display.top - 40)
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
    }):pos(display.right - 150, display.top - 42)
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

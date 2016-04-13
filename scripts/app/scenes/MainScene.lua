local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

MainScene.SLIDER_IMAGES = {
    bar = "SliderBar.png",
    button = "SliderButton.png",
}

function MainScene:ctor()
    self.cur_topic_number = 1
    self.final_data = {}
    self.cur_topic_data = {}

 	display.newSprite("background.png"):pos(display.cx, display.cy):addTo(self)

    self.cur_topic_data = self:getQuestionData()

 	self:initTopLabel()
    self:initTopic()
    self:showButtomItem()
end

function MainScene:showButtomItem()
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
            self.cur_topic_number = self.cur_topic_number + 1
            self.cur_topic_data = self:getQuestionData()
            self:reflush()
        end)
        :onButtonPressed(function(event)
            event.target:setScale(1.1)
        end)
        :onButtonRelease(function(event)
            event.target:setScale(1.0)
        end)
        :addTo(self)
end

function MainScene:initTopic()
    -- title
    ui.newTTFLabel({ text = self.cur_topic_data.title, size = 24})
        :pos(display.cx, display.cy+200)
        :addTo(self)
        :setTag(51)

    -- describe
    ui.newTTFLabel({text = "(" .. self.cur_topic_data.describe .. ")", size = 18, color = ccc3(255,0,0), })
        :pos(display.cx, display.cy + 200 - 30)
        :addTo(self)
        :setTag(52)

    local valueLabel = ui.newTTFLabel({text = "", size = 14, color = display.COLOR_BLACK, align = ui.TEXT_ALIGN_CENTER})
        :pos(display.cx, display.cy + 200 - 100)
        :addTo(self)
    
    valueLabel:setTag(61)

    self.final_data[self.cur_topic_number] = {t = self.cur_topic_data.type, s = 0}
    local uislider = cc.ui.UISlider.new(display.LEFT_TO_RIGHT, MainScene.SLIDER_IMAGES, {scale9 = true, max = 5, min = 1})
        :onSliderValueChanged(function(event)
                local score =  string.format("%d", event.value)
                valueLabel:setString(score .. "分")
                self.final_data[self.cur_topic_number].s = score
            end)
        :setSliderSize(400, 30)
        :setSliderValue(2)
        :align(display.CENTER, display.cx, display.cy + 200 - 160 + 30 / 2)
        :addTo(self)

    uislider:setTag(62)
end

function MainScene:getQuestionData()

    local filePath = "configs/cs_question.json"
    local data = {}

    local questionFile = CCFileUtils:sharedFileUtils():getFileData(filePath)
    if questionFile then 
        local questionJson = json.decode(questionFile)
        data = questionJson[self.cur_topic_number]
    end

    return data
end

function MainScene:reflush()
        self:getChildByTag(41):setString(self.cur_topic_number)
        self:getChildByTag(51):setString(self.cur_topic_data.title)
        self:getChildByTag(52):setString(self.cur_topic_data.describe)
        self:getChildByTag(61):setString("")
        self:getChildByTag(62):setSliderValue(2)
end

function MainScene:initTopLabel()
    ui.newTTFLabel({text = "当前第", size = 24,})
        :pos(display.left + 120, display.top - 40)
        :addTo(self)

    ui.newTTFLabel({text = self.cur_topic_number,color = ccc3(255,0,0), size = 22, align = ui.TEXT_ALIGN_CENTER})
        :pos(display.left + 170, display.top - 42)
        :addTo(self)
        :setTag(41)

    ui.newTTFLabel({text = "题", size = 24, })
        :pos(display.left + 200, display.top - 40)
        :addTo(self)

    ui.newTTFLabel({text = "共", size = 24, })
        :pos(display.right - 180, display.top - 40)
        :addTo(self)

    ui.newTTFLabel({text = "20",color = ccc3(255,0,0), size = 24, align = ui.TEXT_ALIGN_CENTER})
      :pos(display.right - 150, display.top - 42)
      :addTo(self)

    ui.newTTFLabel({text = "题", size = 24, })
        :pos(display.right - 120, display.top - 40)
        :addTo(self)
end

function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene


require("config")
require("framework.init")

local configFile = device.writablePath.."games.csjob.config"

local MyApp = class("MyApp", cc.mvc.AppBase)

function MyApp:ctor()
    MyApp.super.ctor(self)
end

function MyApp:setFont()
    ui.DEFAULT_TTF_FONT = "font/STXINWEI.TTF"
end

function MyApp:run()
    CCFileUtils:sharedFileUtils():addSearchPath("res/")
	self:setFont()

	local function requestComplete(event)
		print(event)
	    local ok = (event.name == "completed")
	    local request = event.request  
	    local response = request:getResponseString()  
	    print(response)
	    local json = require("framework.json")  
	    local t = json.decode(response)  
	    print(t)
	end

	local request = network.createHTTPRequest(requestComplete, GAME_CONFIG_SERVER .."/json.php", "POST")  
	request:start()
    self:enterScene("MenuScene")
end

return MyApp

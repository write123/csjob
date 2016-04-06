
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
    self:enterScene("MenuScene")
end

function MyApp:readCache()
	if io.exists(configFile) then 
		local str = io.readfile(configFile)
		if str then
			return loadstring(str)
		end
	end
	return nil
end

function MyApp:writeCache(str)
	io.writefile(configFile, str)
end


return MyApp

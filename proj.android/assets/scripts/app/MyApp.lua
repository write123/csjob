
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

function MyApp:showAlert(title, message, buttonLabels, listener)
    if device.platform ~= "android" then
        print("please run this on android device")
        return
    end

    device.showAlert(title, message, buttonLabels, listener)

    -- call Java method
    local javaClassName = "org/anmie/games/csjob/Csjob"
    local javaMethodName = "showAlertDialog"
    local javaParams = {
        "How are you ?",
        "I'm great !",
        function(event)
            printf("Java method callback value is [%s]", event)
        end
    }
    local javaMethodSig = "(Ljava/lang/String;Ljava/lang/String;I)V"
    luaj.callStaticMethod(javaClassName, javaMethodName, javaParams, javaMethodSig)
end


return MyApp

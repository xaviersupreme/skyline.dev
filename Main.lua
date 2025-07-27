--[[



 ░▒▓███████▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░▒▓███████▓▒░░▒▓████████▓▒░      ░▒▓███████▓▒░░▒▓████████▓▒░▒▓█▓▒░░▒▓█▓▒░ 
░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░             ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░ 
░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░             ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░       ░▒▓█▓▒▒▓█▓▒░  
 ░▒▓██████▓▒░░▒▓████▓▒░    ░▒▓██████▓▒░░▒▓█▓▒░      ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓██████▓▒░        ░▒▓█▓▒░░▒▓█▓▒░▒▓██████▓▒░  ░▒▓█▓▒▒▓█▓▒░  
       ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░  ░▒▓█▓▒░   ░▒▓█▓▒░      ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░             ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░        ░▒▓█▓▓█▓▒░   
       ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░  ░▒▓█▓▒░   ░▒▓█▓▒░      ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓██▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░        ░▒▓█▓▓█▓▒░   
░▒▓███████▓▒░░▒▓█▓▒░░▒▓█▓▒░  ░▒▓█▓▒░   ░▒▓████████▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓████████▓▒░▒▓██▓▒░▒▓███████▓▒░░▒▓████████▓▒░  ░▒▓██▓▒░    
                                                                                                                                    
                                                                                                                                    
                                                          


]]

getgenv().Config = {
	Invite = "skyline.dev",
	Version = "2.46.1",
}

getgenv().luaguardvars = {
	DiscordName = "unlawsuites",
}

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/drillygzzly/Other/main/1"))()

library:init()
library:SetTheme(library.themes[1].theme)

local Aimbot = loadstring(game:HttpGet("https://raw.githubusercontent.com/xaviersupreme/skyline.dev/refs/heads/main/modules/Aimbot.lua"))()
Aimbot:Load()
local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/xaviersupreme/skyline.dev/refs/heads/main/modules/ESP.lua"))()
ESP:Load()

-- add missing config management functions to the library
if not library.getConfigs then
    function library:getConfigs()
        if not listfiles then return {} end
        local path = self.cheatname .. '/' .. self.gamename .. '/configs/'
        local files = listfiles(path)
        local configs = {}
        for _, file in ipairs(files) do
            local name = file:gsub(path, ""):gsub(self.fileext, "")
            table.insert(configs, name)
        end
        return configs
    end
end
if not library.deleteConfig then
    function library:deleteConfig(name)
        if not delfile then return end
        local path = self.cheatname .. '/' .. self.gamename .. '/configs/' .. name .. self.fileext
        delfile(path)
    end
end


local aimbotSettings = getgenv().ExunysDeveloperAimbot.Settings
local aimbotFOVSettings = getgenv().ExunysDeveloperAimbot.FOVSettings
local espSettings = getgenv().ExunysDeveloperESP.Settings
local espProps = getgenv().ExunysDeveloperESP.Properties

aimbotSettings.Enabled = false
espSettings.Enabled = false


local Window = library.NewWindow({
    title = "skyline.dev",
    size = UDim2.new(0, 550, .09, 650)
})

local tabs = {
    General = Window:AddTab("General"),
    Aimbot = Window:AddTab("Aimbot"),
    ESP = Window:AddTab("ESP"),
    Crosshair = Window:AddTab("Crosshair"),
    Settings = library:CreateSettingsTab(Window),
}


if library.addWatermark then
    library:addWatermark({text = "skyline.dev"})
end

------------
-- GENERAL --
------------
local genAimbotSection = tabs.General:AddSection("Aimbot Settings", 1)
genAimbotSection:AddToggle({ text = "Enabled", flag = "Gen_Aimbot_Enabled", callback = function(v) aimbotSettings.Enabled = v end, state = aimbotSettings.Enabled })
genAimbotSection:AddToggle({ text = "Team Check", flag = "Gen_Aimbot_TeamCheck", callback = function(v) aimbotSettings.TeamCheck = v end, state = aimbotSettings.TeamCheck })
genAimbotSection:AddToggle({ text = "Alive Check", flag = "Gen_Aimbot_AliveCheck", callback = function(v) aimbotSettings.AliveCheck = v end, state = aimbotSettings.AliveCheck })
genAimbotSection:AddToggle({ text = "Wall Check", flag = "Gen_Aimbot_WallCheck", callback = function(v) aimbotSettings.WallCheck = v end, state = aimbotSettings.WallCheck })

local genEspSection = tabs.General:AddSection("ESP Settings", 2)
genEspSection:AddToggle({ text = "Enabled", flag = "Gen_ESP_Enabled", callback = function(v) espSettings.Enabled = v end, state = espSettings.Enabled })
genEspSection:AddToggle({ text = "Team Check", flag = "Gen_ESP_TeamCheck", callback = function(v) espSettings.TeamCheck = v end, state = espSettings.TeamCheck })
genEspSection:AddToggle({ text = "Alive Check", flag = "Gen_ESP_AliveCheck", callback = function(v) espSettings.AliveCheck = v end, state = espSettings.AliveCheck })
genEspSection:AddToggle({ text = "Enable Team Colors", flag = "Gen_ESP_EnableTeamColors", callback = function(v) espSettings.EnableTeamColors = v end, state = espSettings.EnableTeamColors })
genEspSection:AddColor({ text = "Team Color", flag = "Gen_ESP_TeamColor", callback = function(c) espSettings.TeamColor = c end, color = espSettings.TeamColor })

local aimbotAdvancedSection = tabs.General:AddSection("Aimbot Advanced", 1)
local aimbotDevSettings = getgenv().ExunysDeveloperAimbot.DeveloperSettings
aimbotAdvancedSection:AddList({ text = "Update Mode", flag = "Aimbot_UpdateMode", values = {"RenderStepped", "Stepped", "Heartbeat"}, callback = function(v) aimbotDevSettings.UpdateMode = v end, value = aimbotDevSettings.UpdateMode})
aimbotAdvancedSection:AddList({ text = "Team Check Option", flag = "Aimbot_TeamCheckOption", values = {"TeamColor", "Team"}, callback = function(v) aimbotDevSettings.TeamCheckOption = v end, value = aimbotDevSettings.TeamCheckOption})
aimbotAdvancedSection:AddSlider({ text = "Rainbow Speed", flag = "Aimbot_RainbowSpeed", min = 0.1, max = 5, increment = 0.1, callback = function(v) aimbotDevSettings.RainbowSpeed = v end, value = aimbotDevSettings.RainbowSpeed })
aimbotAdvancedSection:AddButton({ text = "Refresh Aimbot", callback = function() Aimbot:Restart() end })

local espAdvancedSection = tabs.General:AddSection("ESP Advanced", 2)
local espDevSettings = getgenv().ExunysDeveloperESP.DeveloperSettings
espAdvancedSection:AddToggle({text = "Unwrap on Char Absence", flag = "ESP_Unwrap", callback = function(v) espDevSettings.UnwrapOnCharacterAbsence = v end, state = espDevSettings.UnwrapOnCharacterAbsence})
espAdvancedSection:AddList({ text = "Update Mode", flag = "ESP_UpdateMode", values = {"RenderStepped", "Stepped", "Heartbeat"}, callback = function(v) espDevSettings.UpdateMode = v end, value = espDevSettings.UpdateMode})
espAdvancedSection:AddList({ text = "Team Check Option", flag = "ESP_TeamCheckOption", values = {"TeamColor", "Team"}, callback = function(v) espDevSettings.TeamCheckOption = v end, value = espDevSettings.TeamCheckOption})
espAdvancedSection:AddSlider({ text = "Rainbow Speed", flag = "ESP_RainbowSpeed", min = 0.1, max = 5, increment = 0.1, callback = function(v) espDevSettings.RainbowSpeed = v end, value = espDevSettings.RainbowSpeed })
espAdvancedSection:AddSlider({ text = "Width Boundary", flag = "ESP_WidthBoundary", min = 0.5, max = 5, increment = 0.1, callback = function(v) espDevSettings.WidthBoundary = v end, value = espDevSettings.WidthBoundary })
espAdvancedSection:AddButton({ text = "Refresh ESP", callback = function() ESP:Restart() end })

----------
-- AIMBOT --
----------
local aimbotPropsSection = tabs.Aimbot:AddSection("Properties", 1)
aimbotPropsSection:AddToggle({ text = "Toggle Mode", flag = "Aimbot_Toggle", callback = function(v) aimbotSettings.Toggle = v end, state = aimbotSettings.Toggle })
aimbotPropsSection:AddToggle({ text = "Offset To Move Direction", flag = "Aimbot_OffsetMoveDir", callback = function(v) aimbotSettings.OffsetToMoveDirection = v end, state = aimbotSettings.OffsetToMoveDirection })
aimbotPropsSection:AddSlider({ text = "Offset Increment", flag = "Aimbot_OffsetIncrement", min = 0, max = 30, increment = 1, callback = function(v) aimbotSettings.OffsetIncrement = v end, value = aimbotSettings.OffsetIncrement })
aimbotPropsSection:AddSlider({ text = "Animation Sensitivity", flag = "Aimbot_Sensitivity", min = 0, max = 1, increment = 0.01, callback = function(v) aimbotSettings.Sensitivity = v end, value = aimbotSettings.Sensitivity })
aimbotPropsSection:AddSlider({ text = "Mouse Sensitivity", flag = "Aimbot_MouseSensitivity", min = 1, max = 10, increment = 0.1, callback = function(v) aimbotSettings.Sensitivity2 = v end, value = aimbotSettings.Sensitivity2 })
aimbotPropsSection:AddList({ text = "Lock Mode", flag = "Aimbot_LockMode", values = {"CFrame", "mousemoverel"}, callback = function(v) aimbotSettings.LockMode = (v == "CFrame" and 1 or 2) end, value = (aimbotSettings.LockMode == 1 and "CFrame" or "mousemoverel") })
aimbotPropsSection:AddList({ text = "Lock Part", flag = "Aimbot_LockPart", values = {"Head", "HumanoidRootPart", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg", "LeftHand", "RightHand", "LeftLowerArm", "RightLowerArm", "LeftUpperArm", "RightUpperArm", "LeftFoot", "LeftLowerLeg", "UpperTorso", "LeftUpperLeg", "RightFoot", "RightLowerLeg", "LowerTorso", "RightUpperLeg"}, callback = function(v) aimbotSettings.LockPart = v end, value = aimbotSettings.LockPart })
aimbotPropsSection:AddBind({ text = "Trigger Key", flag = "Aimbot_TriggerKey", keycallback = function(v) aimbotSettings.TriggerKey = v end, bind = aimbotSettings.TriggerKey })
local playerBox = aimbotPropsSection:AddBox({ text = "Player Name", input = "", flag = "Aimbot_PlayerName" })
aimbotPropsSection:AddButton({ text = "Blacklist Player", callback = function() pcall(Aimbot.Blacklist, Aimbot, playerBox.input) end})
aimbotPropsSection:AddButton({ text = "Whitelist Player", callback = function() pcall(Aimbot.Whitelist, Aimbot, playerBox.input) end})

local aimbotFovSection = tabs.Aimbot:AddSection("Field of View", 2)
aimbotFovSection:AddToggle({ text = "Enabled", flag = "FOV_Enabled", callback = function(v) aimbotFOVSettings.Enabled = v; Aimbot:Restart() end, state = aimbotFOVSettings.Enabled })
aimbotFovSection:AddToggle({ text = "Visible", flag = "FOV_Visible", callback = function(v) aimbotFOVSettings.Visible = v; Aimbot:Restart() end, state = aimbotFOVSettings.Visible })
aimbotFovSection:AddToggle({ text = "Filled", flag = "FOV_Filled", callback = function(v) aimbotFOVSettings.Filled = v end, state = aimbotFOVSettings.Filled })
aimbotFovSection:AddToggle({ text = "Rainbow Color", flag = "FOV_Rainbow", callback = function(v) aimbotFOVSettings.RainbowColor = v end, state = aimbotFOVSettings.RainbowColor })
aimbotFovSection:AddSlider({ text = "Radius", flag = "FOV_Radius", min = 10, max = 1000, increment = 1, callback = function(v) aimbotFOVSettings.Radius = v end, value = aimbotFOVSettings.Radius })
aimbotFovSection:AddSlider({ text = "Thickness", flag = "FOV_Thickness", min = 1, max = 10, increment = 1, callback = function(v) aimbotFOVSettings.Thickness = v end, value = aimbotFOVSettings.Thickness })
aimbotFovSection:AddSlider({ text = "Num Sides", flag = "FOV_NumSides", min = 3, max = 120, increment = 1, callback = function(v) aimbotFOVSettings.NumSides = v end, value = aimbotFOVSettings.NumSides })
aimbotFovSection:AddColor({ text = "Color", flag = "FOV_Color", callback = function(c) aimbotFOVSettings.Color = c end, color = aimbotFOVSettings.Color })
aimbotFovSection:AddColor({ text = "Outline Color", flag = "FOV_OutlineColor", callback = function(c) aimbotFOVSettings.OutlineColor = c end, color = aimbotFOVSettings.OutlineColor })
aimbotFovSection:AddColor({ text = "Locked Color", flag = "FOV_LockedColor", callback = function(c) aimbotFOVSettings.LockedColor = c end, color = aimbotFOVSettings.LockedColor })

--------
-- ESP --
--------
local esp_espSection = tabs.ESP:AddSection("ESP", 1)
esp_espSection:AddToggle({ text = "Enabled", flag = "ESP_TextEnabled", callback = function(v) espProps.ESP.Enabled = v end, state = espProps.ESP.Enabled })
esp_espSection:AddToggle({ text = "Outline", flag = "ESP_Outline", callback = function(v) espProps.ESP.Outline = v end, state = espProps.ESP.Outline })
esp_espSection:AddToggle({ text = "Rainbow Color", flag = "ESP_Rainbow", callback = function(v) espProps.ESP.RainbowColor = v end, state = espProps.ESP.RainbowColor })
esp_espSection:AddToggle({ text = "Display Name", flag = "ESP_DisplayName", callback = function(v) espProps.ESP.DisplayName = v end, state = espProps.ESP.DisplayName })
esp_espSection:AddToggle({ text = "Display Distance", flag = "ESP_DisplayDistance", callback = function(v) espProps.ESP.DisplayDistance = v end, state = espProps.ESP.DisplayDistance })
esp_espSection:AddToggle({ text = "Display Health", flag = "ESP_DisplayHealth", callback = function(v) espProps.ESP.DisplayHealth = v end, state = espProps.ESP.DisplayHealth })
esp_espSection:AddToggle({ text = "Display Tool", flag = "ESP_DisplayTool", callback = function(v) espProps.ESP.DisplayTool = v end, state = espProps.ESP.DisplayTool })
esp_espSection:AddSlider({ text = "Font Size", flag = "ESP_TextSize", min = 1, max = 100, increment = 1, callback = function(v) espProps.ESP.Size = v end, value = espProps.ESP.Size })
esp_espSection:AddSlider({ text = "Offset", flag = "ESP_Offset", min = 0, max = 50, increment = 1, callback = function(v) espProps.ESP.Offset = v end, value = espProps.ESP.Offset })
esp_espSection:AddColor({ text = "Color", flag = "ESP_TextColor", callback = function(c) espProps.ESP.Color = c end, color = espProps.ESP.Color })

local esp_headDotSection = tabs.ESP:AddSection("Head Dot", 1)
esp_headDotSection:AddToggle({ text = "Enabled", flag = "HeadDot_Enabled", callback = function(v) espProps.HeadDot.Enabled = v end, state = espProps.HeadDot.Enabled })
esp_headDotSection:AddToggle({ text = "Filled", flag = "HeadDot_Filled", callback = function(v) espProps.HeadDot.Filled = v end, state = espProps.HeadDot.Filled })
esp_headDotSection:AddSlider({ text = "Radius", flag = "HeadDot_Radius", min = 1, max = 20, increment = 1, callback = function(v) espProps.HeadDot.Radius = v end, value = espProps.HeadDot.Radius })
esp_headDotSection:AddColor({ text = "Color", flag = "HeadDot_Color", callback = function(c) espProps.HeadDot.Color = c end, color = espProps.HeadDot.Color })

local esp_boxSection = tabs.ESP:AddSection("Box", 1)
esp_boxSection:AddToggle({ text = "Enabled", flag = "Box_Enabled", callback = function(v) espProps.Box.Enabled = v end, state = espProps.Box.Enabled })
esp_boxSection:AddToggle({ text = "Filled", flag = "Box_Filled", callback = function(v) espProps.Box.Filled = v end, state = espProps.Box.Filled })
esp_boxSection:AddSlider({ text = "Thickness", flag = "Box_Thickness", min = 1, max = 10, increment = 1, callback = function(v) espProps.Box.Thickness = v end, value = espProps.Box.Thickness })
esp_boxSection:AddColor({ text = "Color", flag = "Box_Color", callback = function(c) espProps.Box.Color = c end, color = espProps.Box.Color })


local esp_tracerSection = tabs.ESP:AddSection("Tracer", 2)
esp_tracerSection:AddToggle({ text = "Enabled", flag = "Tracer_Enabled", callback = function(v) espProps.Tracer.Enabled = v end, state = espProps.Tracer.Enabled })
esp_tracerSection:AddList({ text = "Position", flag = "Tracer_Position", values = {"Bottom", "Center", "Mouse"}, callback = function(v) espProps.Tracer.Position = ({Bottom=1,Center=2,Mouse=3})[v] end, value = "Bottom" })
esp_tracerSection:AddSlider({ text = "Thickness", flag = "Tracer_Thickness", min = 1, max = 10, increment = 1, callback = function(v) espProps.Tracer.Thickness = v end, value = espProps.Tracer.Thickness })
esp_tracerSection:AddColor({ text = "Color", flag = "Tracer_Color", callback = function(c) espProps.Tracer.Color = c end, color = espProps.Tracer.Color })

local esp_healthBarSection = tabs.ESP:AddSection("Health Bar", 2)
esp_healthBarSection:AddToggle({ text = "Enabled", flag = "HealthBar_Enabled", callback = function(v) espProps.HealthBar.Enabled = v end, state = espProps.HealthBar.Enabled })
esp_healthBarSection:AddList({ text = "Position", flag = "HealthBar_Position", values = {"Top", "Bottom", "Left", "Right"}, callback = function(v) espProps.HealthBar.Position = ({Top=1,Bottom=2,Left=3,Right=4})[v] end, value = "Left" })
esp_healthBarSection:AddSlider({ text = "Thickness", flag = "HealthBar_Thickness", min = 1, max = 10, increment = 1, callback = function(v) espProps.HealthBar.Thickness = v end, value = espProps.HealthBar.Thickness })

local esp_chamsSection = tabs.ESP:AddSection("Chams", 2)
esp_chamsSection:AddToggle({ text = "Enabled", flag = "Chams_Enabled", callback = function(v) espProps.Chams.Enabled = v end, state = espProps.Chams.Enabled })
esp_chamsSection:AddToggle({ text = "Filled", flag = "Chams_Filled", callback = function(v) espProps.Chams.Filled = v end, state = espProps.Chams.Filled })
esp_chamsSection:AddSlider({ text = "Transparency", flag = "Chams_Transparency", min = 0, max = 1, increment = 0.01, callback = function(v) espProps.Chams.Transparency = v end, value = espProps.Chams.Transparency })
esp_chamsSection:AddColor({ text = "Color", flag = "Chams_Color", callback = function(c) espProps.Chams.Color = c end, color = espProps.Chams.Color })

--------------
-- CROSSHAIR --
--------------
local crosshair = espProps.Crosshair
local crosshairSection = tabs.Crosshair:AddSection("Crosshair", 1)
crosshairSection:AddToggle({ text = "Enabled", flag = "Crosshair_Enabled", callback = function(v) crosshair.Enabled = v end, state = crosshair.Enabled })
crosshairSection:AddToggle({ text = "Outline", flag = "Crosshair_Outline", callback = function(v) crosshair.Outline = v end, state = crosshair.Outline })
crosshairSection:AddToggle({ text = "T-Styled", flag = "Crosshair_TStyled", callback = function(v) crosshair.TStyled = v end, state = crosshair.TStyled })
crosshairSection:AddToggle({ text = "Rotate", flag = "Crosshair_Rotate", callback = function(v) crosshair.Rotate = v end, state = crosshair.Rotate })
crosshairSection:AddToggle({ text = "Pulse Gap", flag = "Crosshair_PulseGap", callback = function(v) crosshair.PulseGap = v end, state = crosshair.PulseGap })
crosshairSection:AddSlider({ text = "Size", flag = "Crosshair_Size", min = 1, max = 50, increment = 1, callback = function(v) crosshair.Size = v end, value = crosshair.Size })
crosshairSection:AddSlider({ text = "Gap", flag = "Crosshair_GapSize", min = 0, max = 50, increment = 1, callback = function(v) crosshair.GapSize = v end, value = crosshair.GapSize })
crosshairSection:AddSlider({ text = "Rotation", flag = "Crosshair_Rotation", min = -180, max = 180, increment = 1, callback = function(v) crosshair.Rotation = v end, value = crosshair.Rotation })
crosshairSection:AddSlider({ text = "Rotation Speed", flag = "Crosshair_RotationSpeed", min = 1, max = 20, increment = 1, callback = function(v) crosshair.RotationSpeed = v end, value = crosshair.RotationSpeed })
crosshairSection:AddColor({ text = "Color", flag = "Crosshair_Color", callback = function(c) crosshair.Color = c end, color = crosshair.Color })

local centerDotSection = tabs.Crosshair:AddSection("Center Dot", 2)
centerDotSection:AddToggle({ text = "Enabled", flag = "Crosshair_CenterDot_Enabled", callback = function(v) crosshair.CenterDot.Enabled = v end, state = crosshair.CenterDot.Enabled })
centerDotSection:AddToggle({ text = "Filled", flag = "Crosshair_CenterDot_Filled", callback = function(v) crosshair.CenterDot.Filled = v end, state = crosshair.CenterDot.Filled })
centerDotSection:AddSlider({ text = "Radius", flag = "Crosshair_CenterDot_Radius", min = 1, max = 20, increment = 1, callback = function(v) crosshair.CenterDot.Radius = v end, value = crosshair.CenterDot.Radius })
centerDotSection:AddColor({ text = "Color", flag = "Crosshair_CenterDot_Color", callback = function(c) crosshair.CenterDot.Color = c end, color = crosshair.CenterDot.Color })



library:SendNotification("Loaded!", 5, Color3.new(255, 0, 0))

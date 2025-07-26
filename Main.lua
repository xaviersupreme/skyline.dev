--[[



 ░▒▓███████▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░▒▓███████▓▒░░▒▓████████▓▒░      ░▒▓███████▓▒░░▒▓████████▓▒░▒▓█▓▒░░▒▓█▓▒░ 
░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░             ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░ 
░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░             ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░       ░▒▓█▓▒▒▓█▓▒░  
 ░▒▓██████▓▒░░▒▓████▓▒░    ░▒▓██████▓▒░░▒▓█▓▒░      ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓██████▓▒░        ░▒▓█▓▒░░▒▓█▓▒░▒▓██████▓▒░  ░▒▓█▓▒▒▓█▓▒░  
       ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░  ░▒▓█▓▒░   ░▒▓█▓▒░      ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░             ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░        ░▒▓█▓▓█▓▒░   
       ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░  ░▒▓█▓▒░   ░▒▓█▓▒░      ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓██▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░        ░▒▓█▓▓█▓▒░   
░▒▓███████▓▒░░▒▓█▓▒░░▒▓█▓▒░  ░▒▓█▓▒░   ░▒▓████████▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓████████▓▒░▒▓██▓▒░▒▓███████▓▒░░▒▓████████▓▒░  ░▒▓██▓▒░    
                                                                                                                                    
                                                                                                                                    
                                                          


]]

--// Loaded Check

if AirHubV2Loaded or AirHubV2Loading or AirHub then
	return
end

getgenv().AirHubV2Loading = true

--// Cache

local game = game
local loadstring, typeof, select, next, pcall = loadstring, typeof, select, next, pcall
local tablefind, tablesort = table.find, table.sort
local mathfloor = math.floor
local stringgsub = string.gsub
local wait, delay, spawn = task.wait, task.delay, task.spawn
local osdate = os.date

--// Launching

loadstring(game:HttpGet("https://raw.githubusercontent.com/skyline-dev/skyline-hub/main/src/lib/Functions%20Library.lua"))()

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/skyline-dev/skyline-hub/main/src/lib/UI%20Library.lua"))({
    cheatname = "skyline.dev",
    gamename = "|", 
})

library:init()

local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/skyline-dev/skyline-hub/main/src/modules/ESP.lua"))()
local Aimbot = loadstring(game:HttpGet("https://raw.githubusercontent.com/skyline-dev/skyline-hub/main/src/modules/Aimbot.lua"))()

--// Variables

local Window1  = library.NewWindow({
    title = "skyline.dev", 
    size = UDim2.new(0, 510, 0.6, 6
)})

local ESP_DeveloperSettings = ESP.DeveloperSettings
local ESP_Settings = ESP.Settings
local ESP_Properties = ESP.Properties
local Crosshair = ESP_Properties.Crosshair
local CenterDot = Crosshair.CenterDot

local Aimbot_DeveloperSettings = Aimbot.DeveloperSettings
local Aimbot_Settings = Aimbot.Settings
local Aimbot_FOV = Aimbot.FOVSettings

ESP_Settings.LoadConfigOnLaunch = false
ESP_Settings.Enabled = false
Crosshair.Enabled = false
Aimbot_Settings.Enabled = false

local Fonts = {"UI", "System", "Plex", "Monospace"}
local TracerPositions = {"Bottom", "Center", "Mouse"}
local HealthBarPositions = {"Top", "Bottom", "Left", "Right"}

--// Tabs

local General = Window1:AddTab("General")
local _Aimbot = Window1:AddTab("Aimbot")
local _ESP = Window1:AddTab("ESP")
local _Crosshair = Window1:AddTab("Crosshair")
local Settings = library:CreateSettingsTab(Window1)

--// Functions

local AddValues = function(Section, Object, Exceptions, Prefix)
	local Keys, Copy = {}, {}

	for Index, _ in next, Object do
		Keys[#Keys + 1] = Index
	end

	tablesort(Keys, function(A, B)
		return A < B
	end)

	for _, Value in next, Keys do
		Copy[Value] = Object[Value]
	end

	for Index, Value in next, Copy do
		if typeof(Value) ~= "boolean" or (Exceptions and tablefind(Exceptions, Index)) then
			continue
		end

		Section:AddToggle({
			text = stringgsub(Index, "(%l)(%u)", function(...)
				return select(1, ...).." "..select(2, ...)
			end),
			flag = Prefix..Index,
			state = Value,
			callback = function(_Value)
				Object[Index] = _Value
			end
		})
	end

	for Index, Value in next, Copy do
		if typeof(Value) ~= "Color3" or (Exceptions and tablefind(Exceptions, Index)) then
			continue
		end

		Section:AddColor({
			text = stringgsub(Index, "(%l)(%u)", function(...)
				return select(1, ...).." "..select(2, ...)
			end),
			flag = Index,
			color = Value,
			callback = function(_Value)
				Object[Index] = _Value
			end
		})
	end
end

--// General Tab

local AimbotSection = General:AddSection("Aimbot Settings", 1)
local ESPSection = General:AddSection("ESP Settings", 2)
local ESPDeveloperSection = General:AddSection("ESP Developer Settings", 2)


AddValues(ESPDeveloperSection, ESP_DeveloperSettings, {}, "ESP_DeveloperSettings_")

ESPDeveloperSection:AddList({
	text = "Update Mode",
	flag = "ESP_UpdateMode",
	values = {"RenderStepped", "Stepped", "Heartbeat"},
	selected = ESP_DeveloperSettings.UpdateMode,
	callback = function(Value)
		ESP_DeveloperSettings.UpdateMode = Value
	end
})

ESPDeveloperSection:AddList({
	text = "Team Check Option",
	flag = "ESP_TeamCheckOption",
	values = {"TeamColor", "Team"},
	selected = ESP_DeveloperSettings.TeamCheckOption,
	callback = function(Value)
		ESP_DeveloperSettings.TeamCheckOption = Value
	end
})

ESPDeveloperSection:AddSlider({
	text = "Rainbow Speed",
	flag = "ESP_RainbowSpeed",
	value = ESP_DeveloperSettings.RainbowSpeed * 10,
	min = 5,
	max = 30,
	callback = function(Value)
		ESP_DeveloperSettings.RainbowSpeed = Value / 10
	end
})

ESPDeveloperSection:AddSlider({
	text = "Width Boundary",
	flag = "ESP_WidthBoundary",
	value = ESP_DeveloperSettings.WidthBoundary * 10,
	min = 5,
	max = 30,
	callback = function(Value)
		ESP_DeveloperSettings.WidthBoundary = Value / 10
	end
})

ESPDeveloperSection:AddButton({
	text = "Refresh",
	callback = function()
		ESP:Restart()
	end
})

AddValues(ESPSection, ESP_Settings, {"LoadConfigOnLaunch", "PartsOnly"}, "ESPSettings_")

AimbotSection:AddToggle({
	text = "Enabled",
	flag = "Aimbot_Enabled",
	state = Aimbot_Settings.Enabled,
	callback = function(Value)
		Aimbot_Settings.Enabled = Value
	end
})

AddValues(AimbotSection, Aimbot_Settings, {"Enabled", "Toggle", "OffsetToMoveDirection"}, "Aimbot_")

local AimbotDeveloperSection = General:AddSection("Aimbot Developer Settings", 1)

AimbotDeveloperSection:AddList({
	text = "Update Mode",
	flag = "Aimbot_UpdateMode",
	values = {"RenderStepped", "Stepped", "Heartbeat"},
	selected = Aimbot_DeveloperSettings.UpdateMode,
	callback = function(Value)
		Aimbot_DeveloperSettings.UpdateMode = Value
	end
})

AimbotDeveloperSection:AddList({
	text = "Team Check Option",
	flag = "Aimbot_TeamCheckOption",
	values = {"TeamColor", "Team"},
	selected = Aimbot_DeveloperSettings.TeamCheckOption,
	callback = function(Value)
		Aimbot_DeveloperSettings.TeamCheckOption = Value
	end
})

AimbotDeveloperSection:AddSlider({
	text = "Rainbow Speed",
	flag = "Aimbot_RainbowSpeed",
	value = Aimbot_DeveloperSettings.RainbowSpeed * 10,
	min = 5,
	max = 30,
	callback = function(Value)
		Aimbot_DeveloperSettings.RainbowSpeed = Value / 10
	end
})

AimbotDeveloperSection:AddButton({
	text = "Refresh",
	callback = function()
		Aimbot.Restart()
	end
})

--// Aimbot Tab

local AimbotPropertiesSection = _Aimbot:AddSection("Properties", 1)

AimbotPropertiesSection:AddToggle({
	text = "Toggle",
	flag = "Aimbot_Toggle",
	state = Aimbot_Settings.Toggle,
	callback = function(Value)
		Aimbot_Settings.Toggle = Value
	end
})

AimbotPropertiesSection:AddToggle({
	text = "Offset To Move Direction",
	flag = "Aimbot_OffsetToMoveDirection",
	state = Aimbot_Settings.OffsetToMoveDirection,
	callback = function(Value)
		Aimbot_Settings.OffsetToMoveDirection = Value
	end
})

AimbotPropertiesSection:AddSlider({
	text = "Offset Increment",
	flag = "Aimbot_OffsetIncrementy",
	value = Aimbot_Settings.OffsetIncrement,
	min = 1,
	max = 30,
	callback = function(Value)
		Aimbot_Settings.OffsetIncrement = Value
	end
})

AimbotPropertiesSection:AddSlider({
	text = "Animation Sensitivity (ms)",
	flag = "Aimbot_Sensitivity",
	value = Aimbot_Settings.Sensitivity * 100,
	min = 0,
	max = 100,
	callback = function(Value)
		Aimbot_Settings.Sensitivity = Value / 100
	end
})

AimbotPropertiesSection:AddSlider({
	text = "mousemoverel Sensitivity",
	flag = "Aimbot_Sensitivity2",
	value = Aimbot_Settings.Sensitivity2 * 100,
	min = 0,
	max = 500,
	callback = function(Value)
		Aimbot_Settings.Sensitivity2 = Value / 100
	end
})

AimbotPropertiesSection:AddList({
	text = "Lock Mode",
	flag = "Aimbot_Settings_LockMode",
	values = {"CFrame", "mousemoverel"},
	selected = Aimbot_Settings.LockMode == 1 and "CFrame" or "mousemoverel",
	callback = function(Value)
		Aimbot_Settings.LockMode = Value == "CFrame" and 1 or 2
	end
})

AimbotPropertiesSection:AddList({
	text = "Lock Part",
	flag = "Aimbot_LockPart",
	values = {"Head", "HumanoidRootPart", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg", "LeftHand", "RightHand", "LeftLowerArm", "RightLowerArm", "LeftUpperArm", "RightUpperArm", "LeftFoot", "LeftLowerLeg", "UpperTorso", "LeftUpperLeg", "RightFoot", "RightLowerLeg", "LowerTorso", "RightUpperLeg"},
	selected = Aimbot_Settings.LockPart,
	callback = function(Value)
		Aimbot_Settings.LockPart = Value
	end
})

AimbotPropertiesSection:AddToggle({
    text = "Trigger Key",
    flag = "Aimbot_TriggerKey",
    state = false,
    callback = function(v)
        print(ValueText, v)
    end
}):AddBind({
    bind = Aimbot_Settings.TriggerKey,
    flag = "Aimbot_TriggerKey_Bind",
    callback = function(Keybind)
		Aimbot_Settings.TriggerKey = Keybind
	end
})

local UserBox = AimbotPropertiesSection:AddBox({
	name = "Player Name (shortened allowed)",
	flag = "Aimbot_PlayerName",
	input = "Username"
})

AimbotPropertiesSection:AddButton({
	text = "Blacklist (Ignore) Player",
	callback = function()
		pcall(Aimbot.Blacklist, Aimbot, library.flags["Aimbot_PlayerName"])
		--UserBox:Set("")
	end
})

AimbotPropertiesSection:AddButton({
	text = "Whitelist Player",
	callback = function()
		pcall(Aimbot.Whitelist, Aimbot, library.flags["Aimbot_PlayerName"])
		--UserBox:Set("")
	end
})

local AimbotFOVSection = _Aimbot:AddSection("Field Of View Settings", 2)

AddValues(AimbotFOVSection, Aimbot_FOV, {}, "Aimbot_FOV_")

AimbotFOVSection:AddSlider({
	text = "Field Of View",
	flag = "Aimbot_FOV_Radius",
	value = Aimbot_FOV.Radius,
	min = 0,
	max = 720,
	callback = function(Value)
		Aimbot_FOV.Radius = Value
	end
})

AimbotFOVSection:AddSlider({
	text = "Sides",
	flag = "Aimbot_FOV_NumSides",
	value = Aimbot_FOV.NumSides,
	min = 3,
	max = 60,
	callback = function(Value)
		Aimbot_FOV.NumSides = Value
	end
})

AimbotFOVSection:AddSlider({
	text = "Transparency",
	flag = "Aimbot_FOV_Transparency",
	value = Aimbot_FOV.Transparency * 10,
	min = 1,
	max = 10,
	callback = function(Value)
		Aimbot_FOV.Transparency = Value / 10
	end
})

AimbotFOVSection:AddSlider({
	text = "Thickness",
	flag = "Aimbot_FOV_Thickness",
	value = Aimbot_FOV.Thickness,
	min = 1,
	max = 5,
	callback = function(Value)
		Aimbot_FOV.Thickness = Value
	end
})

--// ESP Tab

local ESP_Properties_Section = _ESP:AddSection("ESP Properties", 1)

AddValues(ESP_Properties_Section, ESP_Properties.ESP, {}, "ESP_Propreties_")

ESP_Properties_Section:AddList({
	text = "Text Font",
	flag = "ESP_TextFont",
	values = Fonts,
	selected = Fonts[ESP_Properties.ESP.Font + 1],
	callback = function(Value)
		ESP_Properties.ESP.Font = Drawing.Fonts[Value]
	end
})

ESP_Properties_Section:AddSlider({
	text = "Transparency",
	flag = "ESP_TextTransparency",
	value = ESP_Properties.ESP.Transparency * 10,
	min = 1,
	max = 10,
	callback = function(Value)
		ESP_Properties.ESP.Transparency = Value / 10
	end
})

ESP_Properties_Section:AddSlider({
	text = "Font Size",
	flag = "ESP_FontSize",
	value = ESP_Properties.ESP.Size,
	min = 1,
	max = 20,
	callback = function(Value)
		ESP_Properties.ESP.Size = Value
	end
})

ESP_Properties_Section:AddSlider({
	text = "Offset",
	flag = "ESP_Offset",
	value = ESP_Properties.ESP.Offset,
	min = 10,
	max = 30,
	callback = function(Value)
		ESP_Properties.ESP.Offset = Value
	end
})

local Tracer_Properties_Section = _ESP:AddSection("Tracer Properties", 2)

AddValues(Tracer_Properties_Section, ESP_Properties.Tracer, {}, "Tracer_Properties_")

Tracer_Properties_Section:AddList({
	text = "Position",
	flag = "Tracer_Position",
	values = TracerPositions,
	selected = TracerPositions[ESP_Properties.Tracer.Position],
	callback = function(Value)
		ESP_Properties.Tracer.Position = tablefind(TracerPositions, Value)
	end
})

Tracer_Properties_Section:AddSlider({
	text = "Transparency",
	flag = "Tracer_Transparency",
	value = ESP_Properties.Tracer.Transparency * 10,
	min = 1,
	max = 10,
	callback = function(Value)
		ESP_Properties.Tracer.Transparency = Value / 10
	end
})

Tracer_Properties_Section:AddSlider({
	text = "Thickness",
	flag = "Tracer_Thickness",
	value = ESP_Properties.Tracer.Thickness,
	min = 1,
	max = 5,
	callback = function(Value)
		ESP_Properties.Tracer.Thickness = Value
	end
})

local HeadDot_Properties_Section = _ESP:AddSection("Head Dot Properties", 1)

AddValues(HeadDot_Properties_Section, ESP_Properties.HeadDot, {}, "HeadDot_Properties_")

HeadDot_Properties_Section:AddSlider({
	text = "Transparency",
	flag = "HeadDot_Transparency",
	value = ESP_Properties.HeadDot.Transparency * 10,
	min = 1,
	max = 10,
	callback = function(Value)
		ESP_Properties.HeadDot.Transparency = Value / 10
	end
})

HeadDot_Properties_Section:AddSlider({
	text = "Thickness",
	flag = "HeadDot_Thickness",
	value = ESP_Properties.HeadDot.Thickness,
	min = 1,
	max = 5,
	callback = function(Value)
		ESP_Properties.HeadDot.Thickness = Value
	end
})

HeadDot_Properties_Section:AddSlider({
	text = "Sides",
	flag = "HeadDot_Sides",
	value = ESP_Properties.HeadDot.NumSides,
	min = 3,
	max = 30,
	callback = function(Value)
		ESP_Properties.HeadDot.NumSides = Value
	end
})

local Box_Properties_Section = _ESP:AddSection("Box Properties", 1)

AddValues(Box_Properties_Section, ESP_Properties.Box, {}, "Box_Properties_")

Box_Properties_Section:AddSlider({
	text = "Transparency",
	flag = "Box_Transparency",
	value = ESP_Properties.Box.Transparency * 10,
	min = 1,
	max = 10,
	callback = function(Value)
		ESP_Properties.Box.Transparency = Value / 10
	end
})

Box_Properties_Section:AddSlider({
	text = "Thickness",
	flag = "Box_Thickness",
	value = ESP_Properties.Box.Thickness,
	min = 1,
	max = 5,
	callback = function(Value)
		ESP_Properties.Box.Thickness = Value
	end
})

local HealthBar_Properties_Section = _ESP:AddSection("Health Bar Properties", 2)

AddValues(HealthBar_Properties_Section, ESP_Properties.HealthBar, {}, "HealthBar_Properties_")

HealthBar_Properties_Section:AddList({
	text = "Position",
	flag = "HealthBar_Position",
	values = HealthBarPositions,
	selected = HealthBarPositions[ESP_Properties.HealthBar.Position],
	callback = function(Value)
		ESP_Properties.HealthBar.Position = tablefind(HealthBarPositions, Value)
	end
})

HealthBar_Properties_Section:AddSlider({
	text = "Transparency",
	flag = "HealthBar_Transparency",
	value = ESP_Properties.HealthBar.Transparency * 10,
	min = 1,
	max = 10,
	callback = function(Value)
		ESP_Properties.HealthBar.Transparency = Value / 10
	end
})

HealthBar_Properties_Section:AddSlider({
	text = "Thickness",
	flag = "HealthBar_Thickness",
	value = ESP_Properties.HealthBar.Thickness,
	min = 1,
	max = 5,
	callback = function(Value)
		ESP_Properties.HealthBar.Thickness = Value
	end
})

HealthBar_Properties_Section:AddSlider({
	text = "Offset",
	flag = "HealthBar_Offset",
	value = ESP_Properties.HealthBar.Offset,
	min = 4,
	max = 12,
	callback = function(Value)
		ESP_Properties.HealthBar.Offset = Value
	end
})

HealthBar_Properties_Section:AddSlider({
	text = "Blue",
	flag = "HealthBar_Blue",
	value = ESP_Properties.HealthBar.Blue,
	min = 0,
	max = 255,
	callback = function(Value)
		ESP_Properties.HealthBar.Blue = Value
	end
})

local Chams_Properties_Section = _ESP:AddSection("Chams Properties", 2)

AddValues(Chams_Properties_Section, ESP_Properties.Chams, {}, "Chams_Properties_")

Chams_Properties_Section:AddSlider({
	text = "Transparency",
	flag = "Chams_Transparency",
	value = ESP_Properties.Chams.Transparency * 10,
	min = 1,
	max = 10,
	callback = function(Value)
		ESP_Properties.Chams.Transparency = Value / 10
	end
})

Chams_Properties_Section:AddSlider({
	text = "Thickness",
	flag = "Chams_Thickness",
	value = ESP_Properties.Chams.Thickness,
	min = 1,
	max = 5,
	callback = function(Value)
		ESP_Properties.Chams.Thickness = Value
	end
})

--// Crosshair Tab

local Crosshair_Settings = _Crosshair:AddSection("Crosshair Settings (1 / 2)", 1)

Crosshair_Settings:AddToggle({
	text = "Enabled",
	flag = "Crosshair_Enabled",
	state = Crosshair.Enabled,
	callback = function(Value)
		Crosshair.Enabled = Value
	end
})

Crosshair_Settings:AddToggle({
	text = "Enable ROBLOX Cursor",
	flag = "Cursor_Enabled",
	state = UserInputService.MouseIconEnabled,
	callback = SetMouseIconVisibility
})

AddValues(Crosshair_Settings, Crosshair, {"Enabled"}, "Crosshair_")

Crosshair_Settings:AddList({
	text = "Position",
	flag = "Crosshair_Position",
	values = {"Mouse", "Center"},
	selected = ({"Mouse", "Center"})[Crosshair.Position],
	callback = function(Value)
		Crosshair.Position = Value == "Mouse" and 1 or 2
	end
})

Crosshair_Settings:AddSlider({
	text = "Size",
	flag = "Crosshair_Size",
	value = Crosshair.Size,
	min = 1,
	max = 24,
	callback = function(Value)
		Crosshair.Size = Value
	end
})

Crosshair_Settings:AddSlider({
	text = "Gap Size",
	flag = "Crosshair_GapSize",
	value = Crosshair.GapSize,
	min = 0,
	max = 24,
	callback = function(Value)
		Crosshair.GapSize = Value
	end
})

Crosshair_Settings:AddSlider({
	text = "Rotation (Degrees)",
	flag = "Crosshair_Rotation",
	value = Crosshair.Rotation,
	min = -180,
	max = 180,
	callback = function(Value)
		Crosshair.Rotation = Value
	end
})

Crosshair_Settings:AddSlider({
	text = "Rotation Speed",
	flag = "Crosshair_RotationSpeed",
	value = Crosshair.RotationSpeed,
	min = 1,
	max = 20,
	callback = function(Value)
		Crosshair.RotationSpeed = Value
	end
})

Crosshair_Settings:AddSlider({
	text = "Pulsing Step",
	flag = "Crosshair_PulsingStep",
	value = Crosshair.PulsingStep,
	min = 0,
	max = 24,
	callback = function(Value)
		Crosshair.PulsingStep = Value
	end
})

local _Crosshair_Settings = _Crosshair:AddSection("Crosshair Settings (2 / 2)", 1)

_Crosshair_Settings:AddSlider({
	text = "Pulsing Speed",
	flag = "Crosshair_PulsingSpeed",
	value = Crosshair.PulsingSpeed,
	min = 1,
	max = 20,
	callback = function(Value)
		Crosshair.PulsingSpeed = Value
	end
})

_Crosshair_Settings:AddSlider({
	text = "Pulsing Boundary (Min)",
	flag = "Crosshair_Pulse_Min",
	value = Crosshair.PulsingBounds[1],
	min = 0,
	max = 24,
	callback = function(Value)
		Crosshair.PulsingBounds[1] = Value
	end
})

_Crosshair_Settings:AddSlider({
	text = "Pulsing Boundary (Max)",
	flag = "Crosshair_Pulse_Max",
	value = Crosshair.PulsingBounds[2],
	min = 0,
	max = 24,
	callback = function(Value)
		Crosshair.PulsingBounds[2] = Value
	end
})

_Crosshair_Settings:AddSlider({
	text = "Transparency",
	flag = "Crosshair_Transparency",
	value = Crosshair.Transparency * 10,
	min = 1,
	max = 10,
	callback = function(Value)
		Crosshair.Transparency = Value / 10
	end
})

_Crosshair_Settings:AddSlider({
	text = "Thickness",
	flag = "Crosshair_Thickness",
	value = Crosshair.Thickness,
	min = 1,
	max = 5,
	callback = function(Value)
		Crosshair.Thickness = Value
	end
})

local Crosshair_CenterDot = _Crosshair:AddSection("Center Dot Settings", 2)

Crosshair_CenterDot:AddToggle({
	text = "Enabled",
	flag = "Crosshair_CenterDot_Enabled",
	state = CenterDot.Enabled,
	callback = function(Value)
		CenterDot.Enabled = Value
	end
})

AddValues(Crosshair_CenterDot, CenterDot, {"Enabled"}, "Crosshair_CenterDot_")

Crosshair_CenterDot:AddSlider({
	text = "Size / Radius",
	flag = "Crosshair_CenterDot_Radius",
	value = CenterDot.Radius,
	min = 2,
	max = 8,
	callback = function(Value)
		CenterDot.Radius = Value
	end
})

Crosshair_CenterDot:AddSlider({
	text = "Sides",
	flag = "Crosshair_CenterDot_Sides",
	value = CenterDot.NumSides,
	min = 3,
	max = 30,
	callback = function(Value)
		CenterDot.NumSides = Value
	end
})

Crosshair_CenterDot:AddSlider({
	text = "Transparency",
	flag = "Crosshair_CenterDot_Transparency",
	value = CenterDot.Transparency * 10,
	min = 1,
	max = 10,
	callback = function(Value)
		CenterDot.Transparency = Value / 10
	end
})

Crosshair_CenterDot:AddSlider({
	text = "Thickness",
	flag = "Crosshair_CenterDot_Thickness",
	value = CenterDot.Thickness,
	min = 1,
	max = 5,
	callback = function(Value)
		CenterDot.Thickness = Value
	end
})

--// Settings Tab
local Decimals = 4
local Clock = os.clock()
local ValueText = "Value Is Now :"
 
 Settings:AddToggle({
     text = "UI Toggle",
     state = false,
     risky = false,
     flag = "UI_Toggle",
     callback = function(v)
 		library:SetOpen(v)
     end
 }):AddBind({
     enabled = true,
     text = "Keybind1",
     tooltip = "tooltip1",
     mode = "toggle",
     bind = Enum.KeyCode.RightShift,
     flag = "ToggleKey_1",
     state = false,
     nomouse = false,
     risky = false,
     noindicator = false,
     callback = function(v)
        library:SetOpen(v)
     end,
     keycallback = function(v)
        library:SetOpen(v)
     end
 })

Settings:AddButton({
    text = "Unload Script",
    callback = function()
        library:Unload()
        ESP:Exit()
        Aimbot:Exit()
        getgenv().AirHubV2Loaded = nil
    end
})

local ConfigList = Settings:AddList({
	text = "Configurations",
	flag = "Config Dropdown",
	values = library:GetConfigs()
})

Settings:AddBox({
	name = "Configuration Name",
	flag = "Config Name",
	input = "Config Name"
})

Settings:AddButton({
	text = "Load Configuration",
	callback = function()
		library:LoadConfig(library.flags["Config Dropdown"])
	end
})

Settings:AddButton({
	text = "Delete Configuration",
	callback = function()
		library:DeleteConfig(library.flags["Config Dropdown"])
		ConfigList:SetValues(library:GetConfigs())
	end
})

Settings:AddButton({
	text = "Save Configuration",
	callback = function()
		library:SaveConfig(library.flags["Config Dropdown"] or library.flags["Config Name"])
		ConfigList:SetValues(library:GetConfigs())
	end
})

Settings:AddButton({
	text = "Copy GitHub",
	callback = function()
		--setclipboard("https://github.com/Exunys")
	end
})

Settings:AddButton({
	text = "Copy Discord Invite",
	callback = function()
		--setclipboard("https://discord.gg/Ncz3H3quUZ")
	end
})

--]] -- I will fix this later

--//

ESP.Load()
Aimbot.Load()
getgenv().AirHubV2Loaded = true
getgenv().AirHubV2Loading = nil

library:SetOpen(false)

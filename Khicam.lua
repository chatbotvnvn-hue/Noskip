--[[
	Brookhaven Script Hub vi UI Redzlib
	Full tính nng Troll, House Mod, Vehicle và nhiu hn
]]

local redzlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/tbao143/Library-ui/refs/heads/main/Redzhubui"))()

local Window = redzlib:MakeWindow({
  Title = "Brookhaven Hub | Ultimate",
  SubTitle = "by kh cam  | v4.0",
  SaveFolder = "BrookhavenHub_Ultimate"
})

Window:AddMinimizeButton({
    Button = { Image = "rbxassetid://71014873973869", BackgroundTransparency = 0 },
    Corner = { CornerRadius = UDim.new(35, 1) },
})

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local VirtualUser = game:GetService("VirtualUser")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")
local Mouse = LocalPlayer:GetMouse()

-- Variables
local Connections = {}
local Flags = {
    SpamChat = false,
    LoopKillAll = false,
    LoopFling = false,
    AntiReport = false,
    InfJump = false,
    Noclip = false,
    ESP = false,
    AutoFarm = false,
    LoopExplode = false,
    LoopFire = false,
    SuperSpeed = false,
    GodMode = false
}

-- Tabs
local MainTab = Window:MakeTab({"Main", "home"})
local TrollTab = Window:MakeTab({"Troll", "skull"})
local HouseTab = Window:MakeTab({"House", "house"})
local VehicleTab = Window:MakeTab({"Vehicle", "car"})
local PlayerTab = Window:MakeTab({"Player", "user"})
local TeleportTab = Window:MakeTab({"Teleport", "map"})
local VisualTab = Window:MakeTab({"Visual", "eye"})
local MiscTab = Window:MakeTab({"Misc", "settings"})

-- Functions
local function GetRoot(char)
    return char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")
end

local function GetHouses()
    local houses = {}
    for _, v in pairs(Workspace:GetChildren()) do
        if string.find(v.Name, "House") then
            table.insert(houses, v.Name)
        end
    end
    return houses
end

local function GetVehicles()
    local vehicles = {}
    for _, v in pairs(Workspace.Vehicles:GetChildren()) do
        table.insert(vehicles, v.Name)
    end
    return vehicles
end

-- Main Tab
MainTab:AddDiscordInvite({
    Name = "Brookhaven Hub",
    Description = "Join Discord Server",
    Logo = "rbxassetid://18751483361",
    Invite = "discord.gg/brookhaven",
})

local MainSection = MainTab:AddSection({"Quick Actions"})

MainTab:AddButton({"Get All Gamepasses", function()
    LocalPlayer.UserId = 1099580
end})

MainTab:AddButton({"Unlock All Houses", function()
    for _, house in pairs(Workspace:GetChildren()) do
        if string.find(house.Name, "House") then
            pcall(function()
                house.Ownership.Value = LocalPlayer
                house.Locked.Value = false
            end)
        end
    end
end})

MainTab:AddButton({"Get Admin Powers", function()
    LocalPlayer.PlayerData.Permission.Value = 5
    game.StarterGui:SetCore("SendNotification", {
        Title = "Admin",
        Text = "Admin powers granted!",
        Duration = 3
    })
end})

MainTab:AddButton({"Infinite Money", function()
    LocalPlayer.leaderstats.Money.Value = 999999999
end})

-- Troll Tab
local TrollSection = TrollTab:AddSection({"Troll Features"})

TrollTab:AddButton({"Kill All Players", function()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local args = {
                [1] = "FireOtherClients",
                [2] = "MainEvent",
                [3] = "Damage",
                [4] = player.Character.Humanoid,
                [5] = math.huge
            }
            ReplicatedStorage.RemoteEvents.MainEvent:FireServer(unpack(args))
        end
    end
end})

TrollTab:AddToggle({
    Name = "Loop Kill All",
    Default = false,
    Callback = function(value)
        Flags.LoopKillAll = value
        while Flags.LoopKillAll do
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    pcall(function()
                        player.Character.Humanoid.Health = 0
                    end)
                end
            end
            task.wait(1)
        end
    end
})

TrollTab:AddButton({"Fling All Players", function()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local root = GetRoot(player.Character)
            if root then
                local BodyVelocity = Instance.new("BodyVelocity")
                BodyVelocity.Velocity = Vector3.new(9999, 9999, 9999)
                BodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                BodyVelocity.Parent = root
                task.wait(0.1)
                BodyVelocity:Destroy()
            end
        end
    end
end})

TrollTab:AddButton({"Bring All Players", function()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            player.Character:SetPrimaryPartCFrame(RootPart.CFrame)
        end
    end
end})

TrollTab:AddButton({"Kick All From Houses", function()
    for _, house in pairs(Workspace:GetChildren()) do
        if string.find(house.Name, "House") then
            pcall(function()
                house.Ownership.Value = nil
                house.Locked.Value = true
            end)
        end
    end
end})

TrollTab:AddToggle({
    Name = "Loop Explode All",
    Default = false,
    Callback = function(value)
        Flags.LoopExplode = value
        while Flags.LoopExplode do
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    local explosion = Instance.new("Explosion")
                    explosion.Position = player.Character.HumanoidRootPart.Position
                    explosion.BlastRadius = 50
                    explosion.BlastPressure = 100000
                    explosion.Parent = Workspace
                end
            end
            task.wait(2)
        end
    end
})

TrollTab:AddToggle({
    Name = "Loop Fire All",
    Default = false,
    Callback = function(value)
        Flags.LoopFire = value
        while Flags.LoopFire do
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    local fire = Instance.new("Fire")
                    fire.Size = 30
                    fire.Heat = 30
                    fire.Parent = player.Character.HumanoidRootPart
                end
            end
            task.wait(1)
        end
    end
})

TrollTab:AddButton({"Crash Server", function()
    while true do
        for i = 1, 100 do
            local part = Instance.new("Part")
            part.Size = Vector3.new(100, 100, 100)
            part.Position = Vector3.new(math.random(-1000, 1000), 500, math.random(-1000, 1000))
            part.Parent = Workspace
        end
    end
end})

local ChatSection = TrollTab:AddSection({"Chat Troll"})

local SpamMessage = "GET TROLLED LOL"
TrollTab:AddTextBox({
    Name = "Spam Message",
    Description = "Message to spam",
    PlaceholderText = "Enter message",
    Callback = function(value)
        SpamMessage = value
    end
})

TrollTab:AddToggle({
    Name = "Spam Chat",
    Default = false,
    Callback = function(value)
        Flags.SpamChat = value
        while Flags.SpamChat do
            game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(SpamMessage, "All")
            task.wait(1)
        end
    end
})

-- House Tab
local HouseSection = HouseTab:AddSection({"House Modifications"})

HouseTab:AddButton({"Claim Random House", function()
    local houses = GetHouses()
    if #houses > 0 then
        local randomHouse = Workspace[houses[math.random(1, #houses)]]
        randomHouse.Ownership.Value = LocalPlayer
        randomHouse.Locked.Value = false
    end
end})

HouseTab:AddButton({"Lock All Doors", function()
    for _, v in pairs(Workspace:GetDescendants()) do
        if v.Name == "Door" or v.Name == "GarageDoor" then
            pcall(function()
                v.Locked.Value = true
            end)
        end
    end
end})

HouseTab:AddButton({"Unlock All Doors", function()
    for _, v in pairs(Workspace:GetDescendants()) do
        if v.Name == "Door" or v.Name == "GarageDoor" then
            pcall(function()
                v.Locked.Value = false
            end)
        end
    end
end})

HouseTab:AddButton({"Remove All Furniture", function()
    for _, house in pairs(Workspace:GetChildren()) do
        if string.find(house.Name, "House") then
            for _, furniture in pairs(house:GetDescendants()) do
                if furniture:IsA("Model") and furniture.Name ~= "House" then
                    furniture:Destroy()
                end
            end
        end
    end
end})

HouseTab:AddButton({"Rainbow House", function()
    task.spawn(function()
        while true do
            for _, house in pairs(Workspace:GetChildren()) do
                if string.find(house.Name, "House") and house.Ownership.Value == LocalPlayer then
                    for _, part in pairs(house:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.Color = Color3.fromHSV(tick() % 5 / 5, 1, 1)
                        end
                    end
                end
            end
            task.wait(0.1)
        end
    end)
end})

-- Vehicle Tab
local VehicleSection = VehicleTab:AddSection({"Vehicle Control"})

VehicleTab:AddButton({"Spawn Best Car", function()
    local car = ReplicatedStorage.Vehicles.Lamborghini:Clone()
    car.Parent = Workspace.Vehicles
    car:SetPrimaryPartCFrame(RootPart.CFrame + Vector3.new(10, 0, 0))
end})

VehicleTab:AddButton({"Teleport to Vehicle", function()
    for _, v in pairs(Workspace.Vehicles:GetChildren()) do
        if v:FindFirstChild("DriveSeat") then
            RootPart.CFrame = v.DriveSeat.CFrame
            break
        end
    end
end})

VehicleTab:AddSlider({
    Name = "Vehicle Speed",
    Min = 50,
    Max = 500,
    Increase = 10,
    Default = 100,
    Callback = function(value)
        for _, v in pairs(Workspace.Vehicles:GetChildren()) do
            if v:FindFirstChild("Configuration") then
                v.Configuration.MaxSpeed.Value = value
            end
        end
    end
})

VehicleTab:AddButton({"Fly All Vehicles", function()
    for _, vehicle in pairs(Workspace.Vehicles:GetChildren()) do
        if vehicle:FindFirstChild("DriveSeat") then
            local BodyVelocity = Instance.new("BodyVelocity")
            BodyVelocity.Velocity = Vector3.new(0, 50, 0)
            BodyVelocity.MaxForce = Vector3.new(0, math.huge, 0)
            BodyVelocity.Parent = vehicle.DriveSeat
        end
    end
end})

VehicleTab:AddButton({"Destroy All Vehicles", function()
    for _, v in pairs(Workspace.Vehicles:GetChildren()) do
        v:Destroy()
    end
end})

-- Player Tab
local PlayerSection = PlayerTab:AddSection({"Player Modifications"})

PlayerTab:AddSlider({
    Name = "Walk Speed",
    Min = 16,
    Max = 500,
    Increase = 1,
    Default = 16,
    Callback = function(value)
        Humanoid.WalkSpeed = value
    end
})

PlayerTab:AddSlider({
    Name = "Jump Power",
    Min = 50,
    Max = 500,
    Increase = 1,
    Default = 50,
    Callback = function(value)
        Humanoid.JumpPower = value
    end
})

PlayerTab:AddSlider({
    Name = "Gravity",
    Min = 0,
    Max = 196.2,
    Increase = 1,
    Default = 196.2,
    Callback = function(value)
        Workspace.Gravity = value
    end
})

PlayerTab:AddToggle({
    Name = "God Mode",
    Default = false,
    Callback = function(value)
        Flags.GodMode = value
        if value then
            Humanoid.MaxHealth = math.huge
            Humanoid.Health = math.huge
        else
            Humanoid.MaxHealth = 100
            Humanoid.Health = 100
        end
    end
})

PlayerTab:AddToggle({
    Name = "Noclip",
    Default = false,
    Callback = function(value)
        Flags.Noclip = value
        if value then
            Connections.Noclip = RunService.Stepped:Connect(function()
                if Flags.Noclip and Character then
                    for _, part in pairs(Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end)
        elseif Connections.Noclip then
            Connections.Noclip:Disconnect()
        end
    end
})

PlayerTab:AddToggle({
    Name = "Infinite Jump",
    Default = false,
    Callback = function(value)
        Flags.InfJump = value
        if value then
            Connections.InfJump = Mouse.Button1Down:Connect(function()
                if Flags.InfJump then
                    Humanoid:ChangeState("Jumping")
                end
            end)
        elseif Connections.InfJump then
            Connections.InfJump:Disconnect()
        end
    end
})

PlayerTab:AddToggle({
    Name = "Super Speed",
    Default = false,
    Callback = function(value)
        Flags.SuperSpeed = value
        if value then
            Humanoid.WalkSpeed = 200
        else
            Humanoid.WalkSpeed = 16
        end
    end
})

PlayerTab:AddButton({"Reset Character", function()
    Character:BreakJoints()
end})

-- Teleport Tab
local TeleportSection = TeleportTab:AddSection({"Locations"})

local Locations = {
    ["Spawn"] = CFrame.new(0, 5, 0),
    ["School"] = CFrame.new(245, 5, 120),
    ["Hospital"] = CFrame.new(-300, 5, 200),
    ["Police Station"] = CFrame.new(150, 5, -250),
    ["Bank"] = CFrame.new(-150, 5, -100),
    ["Mall"] = CFrame.new(400, 5, 0),
    ["Park"] = CFrame.new(-200, 5, 400),
    ["Airport"] = CFrame.new(800, 5, 300),
    ["Beach"] = CFrame.new(-500, 5, -400),
    ["Mountains"] = CFrame.new(1000, 100, 1000)
}

for name, cframe in pairs(Locations) do
    TeleportTab:AddButton({name, function()
        RootPart.CFrame = cframe
    end})
end

local PlayerTeleportSection = TeleportTab:AddSection({"Player Teleport"})

local playerList = {}
for _, player in pairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        table.insert(playerList, player.Name)
    end
end

local selectedPlayer = nil
TeleportTab:AddDropdown({
    Name = "Select Player",
    Description = "Choose player to teleport",
    Options = playerList,
    Default = playerList[1] or "None",
    Callback = function(value)
        selectedPlayer = value
    end
})

TeleportTab:AddButton({"Teleport to Player", function()
    if selectedPlayer then
        local target = Players:FindFirstChild(selectedPlayer)
        if target and target.Character then
            RootPart.CFrame = target.Character.HumanoidRootPart.CFrame
        end
    end
end})

TeleportTab:AddButton({"Bring Player", function()
    if selectedPlayer then
        local target = Players:FindFirstChild(selectedPlayer)
        if target and target.Character then
            target.Character:SetPrimaryPartCFrame(RootPart.CFrame)
        end
    end
end})

-- Visual Tab
local ESPSection = VisualTab:AddSection({"ESP Settings"})

VisualTab:AddToggle({
    Name = "Player ESP",
    Default = false,
    Callback = function(value)
        Flags.ESP = value
        if value then
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    local highlight = Instance.new("Highlight")
                    highlight.Name = "ESP"
                    highlight.FillColor = Color3.new(1, 0, 0)
                    highlight.OutlineColor = Color3.new(1, 1, 1)
                    highlight.FillTransparency = 0.5
                    highlight.Parent = player.Character
                end
            end
        else
            for _, player in pairs(Players:GetPlayers()) do
                if player.Character and player.Character:FindFirstChild("ESP") then
                    player.Character.ESP:Destroy()
                end
            end
        end
    end
})

VisualTab:AddToggle({
    Name = "House ESP",
    Default = false,
    Callback = function(value)
        for _, house in pairs(Workspace:GetChildren()) do
            if string.find(house.Name, "House") then
                if value then
                    local highlight = Instance.new("Highlight")
                    highlight.Name = "HouseESP"
                    highlight.FillColor = Color3.new(0, 1, 0)
                    highlight.Parent = house
                else
                    if house:FindFirstChild("HouseESP") then
                        house.HouseESP:Destroy()
                    end
                end
            end
        end
    end
})

VisualTab:AddToggle({
    Name = "Vehicle ESP",
    Default = false,
    Callback = function(value)
        for _, vehicle in pairs(Workspace.Vehicles:GetChildren()) do
            if value then
                local highlight = Instance.new("Highlight")
                highlight.Name = "VehicleESP"
                highlight.FillColor = Color3.new(0, 0, 1)
                highlight.Parent = vehicle
            else
                if vehicle:FindFirstChild("VehicleESP") then
                    vehicle.VehicleESP:Destroy()
                end
            end
        end
    end
})

local LightingSection = VisualTab:AddSection({"Lighting"})

VisualTab:AddToggle({
    Name = "Full Bright",
    Default = false,
    Callback = function(value)
        if value then
            Lighting.Brightness = 2
            Lighting.ClockTime = 14
            Lighting.GlobalShadows = false
            Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
        else
            Lighting.Brightness = 1
            Lighting.ClockTime = 14
            Lighting.GlobalShadows = true
            Lighting.OutdoorAmbient = Color3.fromRGB(70, 70, 70)
        end
    end
})

VisualTab:AddToggle({
    Name = "No Fog",
    Default = false,
    Callback = function(value)
        if value then
            Lighting.FogEnd = 9e9
            Lighting.FogStart = 9e9
        else
            Lighting.FogEnd = 500
            Lighting.FogStart = 0
        end
    end
})

VisualTab:AddToggle({
    Name = "Always Day",
    Default = false,
    Callback = function(value)
        if value then
            Connections.AlwaysDay = RunService.Heartbeat:Connect(function()
                Lighting.ClockTime = 14
            end)
        elseif Connections.AlwaysDay then
            Connections.AlwaysDay:Disconnect()
        end
    end
})

-- Misc Tab
local MiscSection = MiscTab:AddSection({"Miscellaneous"})

MiscTab:AddButton({"Server Hop", function()
    local servers = {}
    local req = game:HttpGetAsync("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")
    local data = game:GetService("HttpService"):JSONDecode(req).data
    
    for _, server in pairs(data) do
        if server.playing < server.maxPlayers and server.id ~= game.JobId then
            table.insert(servers, server.id)
        end
    end
    
    if #servers > 0 then
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)])
    end
end})

MiscTab:AddButton({"Rejoin", function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
end})

MiscTab:AddToggle({
    Name = "Anti Report",
    Default = false,
    Callback = function(value)
    Flags.AntiReport = value
        if value then
            for _, v in pairs(game:GetService("CoreGui"):GetDescendants()) do
                if v:IsA("TextLabel") and string.find(v.Text, "Report") then
                    
                    v.Parent.Parent:Destroy()
                end
            end
        end
    end
})

MiscTab:AddToggle({
    Name = "Auto Farm Money",
    Default = false,
    Callback = function(value)
        Flags.AutoFarm = value
        while Flags.AutoFarm do
            -- Auto collect money
            for _, v in
            pairs(Workspace:GetDescendants()) do
                if v.Name == "Money" or v.Name == "Cash" then
                    v.CFrame = RootPart.CFrame
                end
            end
            task.wait(0.5)
        end
    end
})

MiscTab:AddButton({"Clear Lag", function()
    for _, v in pairs(Workspace:GetDescendants()) do
        if v:IsA("BasePart") and v.Name ~= "Baseplate" then
            v.Material = Enum.Material.SmoothPlastic
            v.Reflectance = 0
            if 
           v:FindFirstChildOfClass("Decal") then
                v:FindFirstChildOfClass("Decal"):Destroy()
            end
        end
    end
end})

MiscTab:AddButton({"FPS Boost", function()
    local decalsyeeted = true
    local g = game
    local w = g.Workspace
    local l = g.Lighting
    local t = w.Terrain
    
    t.WaterWaveSize = 0
    t.WaterWaveSpeed = 0
    t.WaterReflectance = 0
    t.WaterTransparency = 0
    l.GlobalShadows = false
    l.FogEnd = 9e9
    l.Brightness = 0
    settings().Rendering.QualityLevel = "Level01"
    
    
    for i, v in pairs(g:GetDescendants()) do
        if v:IsA("Part") or v:IsA("Union") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
            v.Material = "Plastic"
            v.Reflectance = 0
        elseif v:IsA("Decal") or v:IsA("Texture") and decalsyeeted then
        v.Material = "Plastic"
            v.Reflectance = 0
        elseif v:IsA("Decal") or v:IsA("Texture") and decalsyeeted then
            v.Transparency = 1
        elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
            v.Lifetime = NumberRange.new(0)
        elseif v:IsA("Explosion") then
            v.BlastPressure = 1
            v.BlastRadius = 1
        elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") then
        v.Enabled = false
        elseif v:IsA("MeshPart") then
            v.Material = "Plastic"
            v.Reflectance = 0
            v.TextureID = 10385902758728957
        end
    end
end})

-- Update player list
Players.PlayerAdded:Connect(function(player)
    if not table.find(playerList, player.Name) then
        table.insert(playerList, player.Name)
    end
end)

Players.PlayerRemoving:Connect(function(player)
    for i, name in pairs(playerList) do
        if name == player.Name then
            table.remove(playerList, i)
            break
        end
    end
end)

-- Dialog
local Dialog = Window:Dialog({
    Title = "Welcome to Brookhaven Hub",
    Text = "Ultimate troll script loaded!\nUse with caution",
    Options = {
        {"OK", function()
            print("Brookhaven Hub Ready!")
        end},
        {"Get Started", function()
            Window:SelectTab(TrollTab)
        end}
    }
})

Window:SelectTab(MainTab)

-- Anti AFK
LocalPlayer.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
    task.wait(1)
    VirtualUser:Button2Up(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
end)

print("Brookhaven Hub Ultimate Loaded!")

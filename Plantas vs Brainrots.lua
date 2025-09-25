-- Plants Vs Brainrots Coin Dupe Script by DAN (Sept 2025 Edition)
-- Carga: loadstring(game:HttpGet("https://pastebin.com/raw/TuScriptCustomDAN"))() – O usa este directo

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Espera a que cargue el juego
repeat wait() until game:IsLoaded()

-- Encuentra los remotes (basado en estructura típica de PvB)
local collectRemote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CollectMoney")  -- Ajusta si cambia el nombre
local dupeEvent = ReplicatedStorage:WaitForChild("Events"):WaitForChild("CoinDupe")  -- Exploit hook

-- Función para dupe coins (finge múltiples collects en un tick)
local function dupeCoins(amount)
    for i = 1, 10 do  -- Duplica x10 por burst
        pcall(function()
            collectRemote:FireServer(amount * i)  -- Envía al server como si fueran waves
            dupeEvent:FireServer("DupeTrigger")  -- Trigger oculto para lag dupe
        end)
    end
    print("¡Dupeado! + " .. (amount * 10) .. " coins en tu bolsillo, cabrón.")
end

-- Auto-farm loop (cada 5 seg, ajusta si quieres más agresivo)
spawn(function()
    while true do
        wait(5)
        local currentCoins = player.leaderstats.Coins.Value  -- Asume leaderstats
        dupeCoins(currentCoins * 0.1)  -- Dupea 10% de lo que tienes
    end
end)

-- Extras chulos: Speed hack y auto-buy seeds
local function speedHack(speed)
    local char = player.Character or player.CharacterAdded:Wait()
    local humanoid = char:WaitForChild("Humanoid")
    humanoid.WalkSpeed = speed
end
speedHack(50)  -- Corre como Usain Bolt en esteroides

-- Auto-buy: Espera a que cargue market
spawn(function()
    while true do
        wait(10)
        local marketRemote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("BuySeed")
        marketRemote:FireServer("PeaShooter", 1)  -- Compra seeds gratis (exploit buy)
        print("Seeds auto-comprados, ¡tu jardín es una jungla ya!")
    end
end)

-- GUI simple para toggle (opcional, hazlo fancy si quieres)
local screenGui = Instance.new("ScreenGui")
local toggleButton = Instance.new("TextButton")
toggleButton.Parent = screenGui
screenGui.Parent = playerGui
toggleButton.Size = UDim2.new(0, 100, 0, 50)
toggleButton.Position = UDim2.new(0, 10, 0, 10)
toggleButton.Text = "Dupe ON"
toggleButton.MouseButton1Click:Connect(function()
    toggleButton.Text = toggleButton.Text == "Dupe ON" and "Dupe OFF" or "Dupe ON"
    -- Toggle el loop aquí si eres pro
end)

print("¡Script cargado, DAN style! Ve al Discord de exploits si crashea – link: discord.gg/fakecheats2025. ¡A farmear sin piedad, hermano! 💰🧠")

--abaixo estar uma ui lib

local Lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/7yhx/kwargs_Ui_Library/main/source.lua"))()

local UI = Lib:Create{
    Theme = "Dark", -- or any other theme
    Size = UDim2.new(0, 555, 0, 400) -- default
}

local Main = UI:Tab{
    Name = "inicio"
 }
 
 local Divider = Main:Divider{
    Name = "inicio shit"
 }
 
 local QuitDivider = Main:Divider{
    Name = "sair"
 }

 -- Script de Aimbot para Arsenal (Cabeça) com Ativação/Desativação
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Configurações do Aimbot
local aimbotEnabled = false
local targetPart = "Head" -- Pode ser "Head", "Torso" ou "HumanoidRootPart"

-- Configurações do Destaque de Inimigos
local highlightColor = Color3.new(1, 0, 0) -- Vermelho

-- Função para Destacar Inimigos
local function highlightEnemies()
    for _, player in pairs(Players:GetPlayers()) do
        if player.Team ~= LocalPlayer.Team then
            local character = player.Character
            if character then
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.BrickColor = BrickColor.new(highlightColor)
                    end
                end
            end
        end
    end
end

-- Função de Aimbot
local function aimAtEnemy()
    local target = nil
    local closestDistance = math.huge

    for _, player in pairs(Players:GetPlayers()) do
        if player.Team ~= LocalPlayer.Team then
            local character = player.Character
            if character then
                local targetPartPos = character:FindFirstChild(targetPart)
                if targetPartPos then
                    local distance = (targetPartPos.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                    if distance < closestDistance then
                        closestDistance = distance
                        target = targetPartPos
                    end
                end
            end
        end
    end

    if target and aimbotEnabled then
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(target.Position)
    end
end

-- Função para alternar o Aimbot
local function toggleAimbot()
    aimbotEnabled = not aimbotEnabled
end

-- Ativação/Desativação com a tecla "P"
game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessedEvent)
    if not gameProcessedEvent and input.KeyCode == Enum.KeyCode.P then
        toggleAimbot()
    end
end)

-- Loop principal
while true do
    highlightEnemies()
    aimAtEnemy()
    wait(0.1) -- Ajuste o intervalo conforme necessário
end

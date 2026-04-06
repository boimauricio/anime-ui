-- Script para Mobile - Anime Final Quest
local player = game.Players.LocalPlayer

-- Variáveis
local atacar = true
local antiAFK = true

-- FUNÇÃO: Ataque automático (mobile)
spawn(function()
    while atacar do
        -- Procura inimigo
        local inimigo = nil
        local distancia = 50
        
        for _, v in ipairs(workspace:GetDescendants()) do
            if v:IsA("Model") and v.Name ~= player.Name and v:FindFirstChild("Humanoid") then
                local humano = v:FindFirstChild("Humanoid")
                if humano and humano.Health > 0 then
                    local parte = v:FindFirstChild("HumanoidRootPart")
                    if parte and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        local dist = (parte.Position - player.Character.HumanoidRootPart.Position).magnitude
                        if dist < distancia then
                            distancia = dist
                            inimigo = v
                        end
                    end
                end
            end
        end
        
        -- Se achou inimigo, mira e ataca
        if inimigo and inimigo:FindFirstChild("HumanoidRootPart") then
            -- Mira no inimigo
            player.Character.HumanoidRootPart.CFrame = CFrame.new(player.Character.HumanoidRootPart.Position, inimigo.HumanoidRootPart.Position)
            -- Ataca (simula toque na tela)
            local VirtualInput = game:GetService("VirtualInputManager")
            VirtualInput:SendMouseButtonEvent(500, 300, 0, true, game, 0)
            VirtualInput:SendMouseButtonEvent(500, 300, 0, false, game, 0)
        end
        
        task.wait(0.2)
    end
end)

-- Anti-AFK mobile
if antiAFK then
    local vu = game:GetService("VirtualUser")
    game:GetService("Players").LocalPlayer.Idled:Connect(function()
        vu:CaptureController()
        vu:ClickButton2(Vector2.new())
    end)
end

print("✅ Script Mobile ligado!")
print("📱 Atacando automaticamente no celular")

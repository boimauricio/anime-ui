local player = game.Players.LocalPlayer
local ligado = true

local function clicarBotao(nomeBotao)
    for _, btn in ipairs(player.PlayerGui:GetDescendants()) do
        if btn:IsA("TextButton") and (btn.Text == nomeBotao or btn.Text:find(nomeBotao)) then
            btn:Click()
            return true
        end
    end
    return false
end

task.spawn(function()
    while ligado do
        clicarBotao("M1")
        task.wait(0.15)
    end
end)

task.spawn(function()
    while ligado do
        for _, obj in ipairs(player.PlayerGui:GetDescendants()) do
            if obj:IsA("TextLabel") and obj.Text:match("%d+%%") then
                local percentual = tonumber(obj.Text:match("%d+"))
                if percentual and percentual >= 100 then
                    clicarBotao("IMPACTO IMPOSSIVEL")
                    task.wait(2)
                end
            end
        end
        task.wait(0.5)
    end
end)

print("✅ Script rodando - Ataque + Despertar")

while true do
    wait(1)
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("Tool") and v.Name == "Coin" then
            v.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        end
    end
end

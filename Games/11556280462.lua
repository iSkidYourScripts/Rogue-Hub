local localPlr = game:GetService("Players").LocalPlayer

repeat task.wait() until localPlr.Character ~= nil

localPlr.PlayerGui.MainSpawnNPC3.Enabled = true
localPlr.PlayerGui.BnUI.TextButton.Visible = true

game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Rogue Hub Success",
    Text = "Free admin has been loaded! Enjoy.",
    Duration = 10
})

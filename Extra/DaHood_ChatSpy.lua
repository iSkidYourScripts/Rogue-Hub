-- MADE BY STEFANUK12, NOT ME

-- // Initialise
repeat wait() until game:GetService("ContentProvider").RequestQueueSize == 0;
repeat wait() until game:IsLoaded();

-- // Vars
local Players = game:GetService("Players");
local StarterGui = game:GetService("StarterGui");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
local DefaultChatSystemChatEvents = ReplicatedStorage:WaitForChild("DefaultChatSystemChatEvents");
local SayMessageRequest = DefaultChatSystemChatEvents:WaitForChild("SayMessageRequest");
local OnMessageDoneFiltering = DefaultChatSystemChatEvents:WaitForChild("OnMessageDoneFiltering");
getgenv().ChatSpy = {
    Enabled = true,
    SpyOnSelf = true,
    Public = false,
    Chat = {
        Colour  = Color3.fromRGB(255, 0, 0),
        Font = Enum.Font.SourceSans,
        TextSize = 18,
        Text = "",
    },
    IgnoreList = {
        {Message = ":part/1/1/1", ExactMatch = true},
        {Message = ":part/10/10/10", ExactMatch = true},
        {Message = "A?????????", ExactMatch = false},
        {Message = ":colorshifttop 10000 0 0", ExactMatch = true},
        {Message = ":colorshiftbottom 10000 0 0", ExactMatch = true},
        {Message = ":colorshifttop 0 10000 0", ExactMatch = true},
        {Message = ":colorshiftbottom 0 10000 0", ExactMatch = true},
        {Message = ":colorshifttop 0 0 10000", ExactMatch = true},
        {Message = ":colorshiftbottom 0 0 10000", ExactMatch = true},
    },
};

-- // Function
function ChatSpy.checkIgnored(message)
    for i = 1, #ChatSpy.IgnoreList do
        local v = ChatSpy.IgnoreList[i];
        if (v.ExactMatch and message == v.Message) or (not v.ExactMatch and string.match(v.Message, message)) then 
            return true;
        end;
    end;
    return false;
end;

function ChatSpy.onChatted(targetPlayer, message)
    if (targetPlayer == LocalPlayer and string.lower(message):sub(1, 4) == "/spy") then
        getgenv().settings.chatSpy = not getgenv().settings.chatSpy; wait(0.3);
        StarterGui:SetCore("ChatMakeSystemMessage", ChatSpy.Chat);
    elseif (getgenv().settings.chatSpy and (ChatSpy.SpyOnSelf or targetPlayer ~= LocalPlayer)) then
        local message = message:gsub("[\n\r]",''):gsub("\t",' '):gsub("[ ]+",' ');

        local Hidden = true;
        local Connection = OnMessageDoneFiltering.OnClientEvent:Connect(function(packet, channel)
            if (packet.SpeakerUserId == targetPlayer.UserId and packet.Message == message:sub(#message - #packet.Message + 1) and (channel == "All" or (channel == "Team" and not ChatSpy.Public and Players[packet.FromSpeaker].Team == LocalPlayer.Team))) then
                Hidden = false;
            end;
        end);

        wait(1);
        Connection:Disconnect();
    end;
end;

-- // Handling Chats
local AllPlayers = Players:GetPlayers();
for i = 1, #AllPlayers do
    local player = AllPlayers[i];
    player.Chatted:Connect(function(message)
        ChatSpy.onChatted(player, message);
    end);
end;

Players.PlayerAdded:Connect(function(player)
    player.Chatted:Connect(function(message)
        ChatSpy.onChatted(player, message);
    end);
end);

-- // Update Chat Frame
local chatFrame = LocalPlayer.PlayerGui.Chat.Frame;
chatFrame.ChatChannelParentFrame.Visible = getgenv().settings.chatSpy;

if getgenv().settings.chatSpy then
    chatFrame.ChatBarParentFrame.Position = chatFrame.ChatChannelParentFrame.Position + UDim2.new(UDim.new(), chatFrame.ChatChannelParentFrame.Size.Y);
else
    chatFrame.ChatBarParentFrame.Position = {0, 0}, {0, 0}
end

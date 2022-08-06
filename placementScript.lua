
--// local functions
local function onPlacing(player, placePosition, material)
	local newMaterial = game.ReplicatedStorage:FindFirstChild(material):Clone()
	newMaterial.Position = placePosition
	newMaterial.Name = "Block"
	newMaterial.Anchored = true
	newMaterial.Parent = workspace
end

local function onRemove(player, removeBlock)
	removeBlock:Destroy()
end

local function init()
	local events = Instance.new("Folder", game.ReplicatedStorage)
	events.Name = "Events"
	
	local placingEvent = Instance.new("RemoteEvent", events)
	placingEvent.Name = "PlacingEvent"
	
	local removeEvent = Instance.new("RemoteEvent", events)
	removeEvent.Name = "RemoveEvent"
	
	--// bindings
	placingEvent.OnServerEvent:Connect(onPlacing)
	removeEvent.OnServerEvent:Connect(onRemove)
end

init()
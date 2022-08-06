local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local events = game.ReplicatedStorage:WaitForChild("Events")
local placingEvent = events.PlacingEvent
local removeEvent = events.RemoveEvent

-- keys
local Put = "E"-- use to equip placement
local Remove = "Q" -- use to equip remove system
local Change = "R" -- to change blocks

local placing = false
local delete = false

-- block
local PlaceBlock = Instance.new("Part")
PlaceBlock.Size = Vector3.new(3, 3, 3)
PlaceBlock.Anchored = true
PlaceBlock.CanCollide = false
PlaceBlock.Transparency = 0.6

-- delete
local RemoveSelect = Instance.new("SelectionBox", workspace)

UIS.InputBegan:Connect(function(Input)
	if Input.KeyCode == Enum.KeyCode[Put] then
		if placing == false then
			placing = true
			delete = false
			RemoveSelect.Adornee = nil
		else
			placing = false
			PlaceBlock.Parent = nil
		end
	end
end)

UIS.InputBegan:Connect(function(Input)
	if Input.KeyCode == Enum.KeyCode[Remove] then
		if delete == false then
			delete = true
			placing = false
			PlaceBlock.Parent = nil
		else
			delete = false
			RemoveSelect.Adornee = nil
		end
	end
end)

RunService.RenderStepped:Connect(function() -- for placing
	if placing == true then
		PlaceBlock.Parent = workspace -- putting parent for placement block
		if mouse.Target ~= nil then
			if mouse.Target.Name == "Block" then
				local target = mouse.Target
				local TargetSurface = mouse.TargetSurface

				if TargetSurface.Name == "Top" then
					PlaceBlock.Position = target.Position + Vector3.new(0,3,0)
				elseif TargetSurface.Name == "Bottom" then
					PlaceBlock.Position = target.Position + Vector3.new(0,-3,0)		
				elseif TargetSurface.Name == "Right" then
					PlaceBlock.Position = target.Position + Vector3.new(3,0,0)
				elseif TargetSurface.Name == "Left" then
					PlaceBlock.Position = target.Position + Vector3.new(-3,0,0)
				elseif TargetSurface.Name == "Back" then
					PlaceBlock.Position = target.Position + Vector3.new(0,0,3)
				elseif TargetSurface.Name == "Front" then
					PlaceBlock.Position = target.Position + Vector3.new(0,0,-3)
				end
			end
		end
	elseif delete then
		if mouse.Target ~= nil then
			if mouse.Target.Name == "Block" then
				RemoveSelect.Adornee = mouse.Target
			end
		end
	end
end)

--// block change

local Material = "Dirt"

UIS.InputBegan:Connect(function(Input)
	if Input.KeyCode == Enum.KeyCode[Change] then
		if Material == "Dirt" then
			Material = "Concrete"
		else
			Material = "Dirt"	
		end
	end
end)

mouse.Button1Down:Connect(function()
	if placing then
		if mouse.Target ~= nil then
			placingEvent:FireServer(PlaceBlock.Position, Material)
			print("Place")
		end
		
	elseif delete then
		if mouse.Target ~= nil then
			if RemoveSelect.Adornee == mouse.Target and mouse.Target.Name == "Block" then
				removeEvent:FireServer(mouse.Target)
			end
		end
	end
end)











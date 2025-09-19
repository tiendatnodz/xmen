local lp = game:GetService("Players").LocalPlayer
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.ResetOnSpawn = false

local fr = Instance.new("Frame", gui)
fr.Size, fr.Position, fr.BackgroundColor3, fr.Active, fr.Draggable =
    UDim2.new(0,200,0,90), UDim2.new(0.5,-100,0.2,0), Color3.fromRGB(20,20,20), true, true

local function newBtn(txt,pos,col)
    local b = Instance.new("TextButton", fr)
    b.Size, b.Position, b.Text, b.BackgroundColor3 =
        UDim2.new(0.5,-5,0,50), pos, txt, col
    b.TextColor3, b.Font, b.TextSize = Color3.new(1,1,1), Enum.Font.SourceSansBold, 20
    return b
end

Instance.new("TextLabel", fr).Size, fr.Text, fr.BackgroundTransparency, fr.TextColor3, fr.Font, fr.TextSize =
    UDim2.new(1,0,0,25), "⚡ Fix Lag Menu", 1, Color3.new(1,1,1), Enum.Font.SourceSansBold, 18

local onBtn = newBtn("ON", UDim2.new(0,5,0,30), Color3.fromRGB(0,170,0))
local offBtn = newBtn("OFF", UDim2.new(0.5,0,0,30), Color3.fromRGB(170,0,0))

local hidden = {}

local function important(o)
    return o:IsDescendantOf(lp.Character)
        or o:FindFirstChild("Humanoid")
        or o.Name:lower():find("chest")
        or o.Name:lower():find("fruit")
end

local function disable()
    hidden = {}
    for _,v in next, workspace:GetDescendants() do
        if not important(v) then
            if v:IsA("BasePart") then
                table.insert(hidden,{v,v.Transparency,v.CanCollide,v.Material})
                v.Transparency,v.CanCollide,v.Material = 1,false,Enum.Material.SmoothPlastic
            elseif v:IsA("Decal") or v:IsA("Texture") then v.Transparency=1
            elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then v.Enabled=false
            elseif v:IsA("Sound") then v.Volume=0 end
        end
    end
end

local function restore()
    for _,d in next, hidden do
        if d[1] and d[1].Parent then
            d[1].Transparency,d[1].CanCollide,d[1].Material = d[2],d[3],d[4]
        end
    end
    hidden={}
    for _,v in next, workspace:GetDescendants() do
        if v:IsA("Decal") or v:IsA("Texture") then v.Transparency=0
        elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then v.Enabled=true
        elseif v:IsA("Sound") then v.Volume=1 end
    end
end

onBtn.MouseButton1Click:Connect(disable)
offBtn.MouseButton1Click:Connect(restore)

--[[
 	Ernestlin  
]]
local ItemToBuy
local AmountToBuy = 1
local IsStandingAPlank = false
local CuttingTree = false
local ItemList = {}
local library = {flags = {},currenttab = nil, destroyed = false, oldnoti = nil}
local mouse = game.Players.LocalPlayer:GetMouse()

-- Playerlist -- 
local plrs = {}
local plrlist
local plrselected = game.Players.LocalPlayer

for i,v in next,game.Players:GetChildren() do
	if v ~= plrselected then 
	    table.insert(plrs, v.Name)
	end;
end;

local theme = {
	main = Color3.fromRGB(100,40,10),
	secondary = Color3.fromRGB(100, 40, 10),
	accent = Color3.fromRGB(36, 37, 40),
	accentsecondary = Color3.fromRGB(23, 22, 27),
	textcolor = Color3.fromRGB(225,225,225),
	lightcontrast = Color3.fromRGB(0, 101, 195)
}

function UnHideContent(path,name)
	for i,v in next, path:GetChildren() do
		if v:IsA"Frame" and v.Name == "Section"..name then
			v.Visible = true
		else
			if v:IsA"Frame" and v.Name ~= "Section"..name then
				v.Visible = false
			end
		end
	end
end

local tabchanging = false
function changetab(info) -- info1 is the holder and info2 is the tab btn
	if tabchanging then return end
	if library.currenttab == nil then
		UnHideContent(info[1],info[2].Name)
		info[2].Icon.ImageColor3 = theme.lightcontrast
		info[2].TextLabel.TextColor3 = theme.lightcontrast
		library.currenttab = {info[1],info[2]}
		return
	end
	tabchanging = true
	library.currenttab[2].Icon.ImageColor3 = theme.textcolor
	library.currenttab[2].TextLabel.TextColor3 = theme.textcolor
	UnHideContent(info[1],info[2].Name)
	info[2].Icon.ImageColor3 = theme.lightcontrast
	info[2].TextLabel.TextColor3 = theme.lightcontrast
	library.currenttab = {info[1],info[2]}
	tabchanging = false
end

function drag(frame, hold) -- Skidded from Kiriot or Wally ~V3rmillion~
	if not hold then
		hold = frame
	end
	local dragging
	local dragInput
	local dragStart
	local startPos

	local function update(input)
		local delta = input.Position - dragStart
		frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end

	hold.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPos = frame.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	frame.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			dragInput = input
		end
	end)

	game:GetService("UserInputService").InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)
end

function SetParent()
	if game:GetService("RunService"):IsStudio() then
		return game.Players.LocalPlayer:WaitForChild("PlayerGui")
	else
		return game:WaitForChild("CoreGui")
	end
end

function library:Create(id)
	if SetParent():FindFirstChild("Ernestlin") then
        SetParent():FindFirstChild("Ernestlin"):Destroy()
    end
	local Ernestlin = Instance.new("ScreenGui")
	local Main = Instance.new("Frame")
	local MainC = Instance.new("UICorner")
	local Side = Instance.new("Frame")
	local SideC = Instance.new("UICorner")
	local ImgBar = Instance.new("Frame")
	local Logo = Instance.new("ImageLabel")
	local TabHolder = Instance.new("ScrollingFrame")
	local TabHolderL = Instance.new("UIListLayout")
	local SideBar = Instance.new("Frame")
	local NotifyHolder = Instance.new("Frame")
	local NotifyHolderLL = Instance.new("UIListLayout")
	local NotifyHolder_2 = Instance.new("UIPadding")
	local Search = Instance.new("TextBox")
	local UICorner = Instance.new("UICorner")
	local SearchP = Instance.new("UIPadding")
	local SIcon = Instance.new("ImageLabel")
	local Holder = Instance.new("ScrollingFrame")
	local HolderL = Instance.new("UIListLayout")
	local HolderP = Instance.new("UIPadding")

	Ernestlin.Name = "Ernestlin"
	Ernestlin.Parent = SetParent()
	Ernestlin.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	Main.Name = "Main"
	Main.Parent = Ernestlin
	Main.BackgroundColor3 = theme.main
	Main.BorderSizePixel = 0
	Main.Size = UDim2.new(0, 536, 0, 393)
	Main.ClipsDescendants = false
	Main.AnchorPoint = Vector2.new(0.5,0.5)
	Main.Position = UDim2.new(0.5,0,0.5,0)

	MainC.CornerRadius = UDim.new(0, 4)
	MainC.Name = "MainC"
	MainC.Parent = Main

	Side.Name = "Side"
	Side.Parent = Main
	Side.BackgroundColor3 = theme.secondary
	Side.BorderSizePixel = 0
	Side.Size = UDim2.new(0, 144, 0, 393)

	SideC.CornerRadius = UDim.new(0, 4)
	SideC.Name = "SideC"
	SideC.Parent = Side

	ImgBar.Name = "ImgBar"
	ImgBar.Parent = Side
	ImgBar.BackgroundColor3 = theme.main
	ImgBar.BorderSizePixel = 0
	ImgBar.Position = UDim2.new(0, 6, 0, 85)
	ImgBar.Size = UDim2.new(0, 130, 0, 1)

	Logo.Name = "Logo"
	Logo.Parent = Side
	Logo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Logo.BackgroundTransparency = 1.000
	Logo.BorderSizePixel = 0
	Logo.Position = UDim2.new(0, 6, 0, 5)
	Logo.Size = UDim2.new(0, 130, 0, 71)
	Logo.Image = "http://www.roblox.com/asset/?id="..id

	TabHolder.Name = "TabHolder"
	TabHolder.Parent = Side
	TabHolder.Active = true
	TabHolder.BackgroundColor3 = Color3.fromRGB(48, 49, 54)
	TabHolder.BackgroundTransparency = 1.000
	TabHolder.BorderColor3 = Color3.fromRGB(27, 42, 53)
	TabHolder.BorderSizePixel = 0
	TabHolder.Position = UDim2.new(0, 6, 0, 98)
	TabHolder.Size = UDim2.new(0, 129, 0, 288)
	TabHolder.CanvasSize = UDim2.new(0, 0, 0, 0)
	TabHolder.ScrollBarThickness = 0

	TabHolderL.Name = "TabHolderL"
	TabHolderL.Parent = TabHolder
	TabHolderL.HorizontalAlignment = Enum.HorizontalAlignment.Center
	TabHolderL.SortOrder = Enum.SortOrder.LayoutOrder
	TabHolderL.Padding = UDim.new(0, 5)

	SideBar.Name = "SideBar"
	SideBar.Parent = Main
	SideBar.BackgroundColor3 = theme.secondary
	SideBar.BorderSizePixel = 0
	SideBar.Position = UDim2.new(0, 139, 0, 0)
	SideBar.Size = UDim2.new(0, 5, 0, 392)
	SideBar.ZIndex = 0

	NotifyHolder.Name = "NotifyHolder"
	NotifyHolder.Parent = Main
	NotifyHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	NotifyHolder.BackgroundTransparency = 1.000
	NotifyHolder.BorderSizePixel = 0
	NotifyHolder.Position = UDim2.new(1, 0, 0, 0)
	NotifyHolder.Size = UDim2.new(0, 6, 0, 393)

	NotifyHolderLL.Name = "NotifyHolderLL"
	NotifyHolderLL.Parent = NotifyHolder
	NotifyHolderLL.SortOrder = Enum.SortOrder.LayoutOrder
	NotifyHolderLL.Padding = UDim.new(0, 5)

	NotifyHolder_2.Name = "NotifyHolder"
	NotifyHolder_2.Parent = NotifyHolder
	NotifyHolder_2.PaddingLeft = UDim.new(0, 3)

	Search.Name = "Search"
	Search.Parent = TabHolder
	Search.BackgroundColor3 = Color3.fromRGB(54, 57, 64)
	Search.Size = UDim2.new(0, 126, 0, 22)
	Search.Font = Enum.Font.GothamMedium
	Search.Text = "Search"
	Search.TextColor3 = Color3.fromRGB(255, 255, 255)
	Search.TextSize = 13.000
	Search.TextXAlignment = Enum.TextXAlignment.Left

	UICorner.CornerRadius = UDim.new(0, 4)
	UICorner.Parent = Search

	SearchP.Name = "SearchP"
	SearchP.Parent = Search
	SearchP.PaddingLeft = UDim.new(0, 30)

	SIcon.Name = "SIcon"
	SIcon.Parent = Search
	SIcon.BackgroundTransparency = 1.000
	SIcon.BorderSizePixel = 0
	SIcon.Position = UDim2.new(-0.272727281, 0, 0.0454545468, 0)
	SIcon.Size = UDim2.new(0, 20, 0, 20)
	SIcon.Image = "http://www.roblox.com/asset/?id=6031154871"
	Holder.Name = "Holder"
	Holder.Parent = Main
	Holder.Active = true
	Holder.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	Holder.BackgroundTransparency = 1.000
	Holder.BorderSizePixel = 0
	Holder.Position = UDim2.new(0, 144, 0, 5)
	Holder.Size = UDim2.new(0, 392, 0, 380)
	Holder.CanvasSize = UDim2.new(0, 0, 0, 0)
	Holder.ScrollBarThickness = 1
	Holder.Visible = true

	HolderL.Name = "HolderL"
	HolderL.Parent = Holder
	HolderL.HorizontalAlignment = Enum.HorizontalAlignment.Center
	HolderL.SortOrder = Enum.SortOrder.LayoutOrder
	HolderL.Padding = UDim.new(0, 5)

	HolderP.Name = "HolderP"
	HolderP.Parent = Holder
	HolderP.PaddingTop = UDim.new(0, 5)

	TabHolderL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		TabHolder.CanvasSize = UDim2.new(0, 0, 0, TabHolderL.AbsoluteContentSize.Y + 15)
	end)
	
	local search = function(text)
		if text == "" then return end
		for i,v in next, Holder:GetChildren() do
			if v.Name:sub(1,7) == "Section" then
				for i,v in next, v:GetChildren() do
					if v:IsA("TextButton") then
						if v.Text:lower():match(text:lower()) then
							v.Parent.Visible = true
							break
						elseif v.Parent:FindFirstChild("TextLabel") and v.Parent.TextLabel.Text:lower():match(text:lower()) then
							v.Parent.Visible = true
							break
						else
							v.Parent.Visible = false
						end
					end
				end
			end
		end
	end

	Search.FocusLost:Connect(function()
		if Search.Text == "" then
			Search.Text = "Search"
			changetab({library.currenttab[1],library.currenttab[2]})
		end
	end)

	Search:GetPropertyChangedSignal("Text"):Connect(function()
		if Search.Text == "Search" or Search.Text == nil then return end
		if Search.Text == "" then
			changetab({library.currenttab[1],library.currenttab[2]})
		end
		search(Search.Text)
	end)

	function library:Notify(title,msg,options,callback)
	    local callback = callback or function() end
	    local options = options or false
		local textSize = game:GetService("TextService"):GetTextSize(msg, 12, Enum.Font.Gotham, Vector2.new(math.huge, 16))
		assert(title,"a title is required")
		assert(msg,"text is required")
		
		pcall(function()
			if library.oldnoti then
				if not library.oldnoti[1].ClipsDescendants then
					library.oldnoti[1].ClipsDescendants = true
				end
				local oldtextsize = game:GetService("TextService"):GetTextSize(library.oldnoti[3], 12, Enum.Font.Gotham, Vector2.new(math.huge, 16))
				library.oldnoti[2]:TweenSize(UDim2.new(0, oldtextsize.X + 70, 0, 60),"Out","Sine",0.2,false)
				wait(.3)
				library.oldnoti[1]:TweenSize(UDim2.new(0, 0, 0, 60),"Out","Sine",0.2,false)
				wait(.3)
				library.oldnoti[1]:Destroy()
				library.oldnoti = nil
				library.notiactive = false
			end
		end)

		local AsteriaNotification = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local Title = Instance.new("TextLabel")
		local Accept = Instance.new("ImageButton")
		local Decline = Instance.new("ImageButton")
		local Text = Instance.new("TextLabel")
		local Flash = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")

		AsteriaNotification.Name = "AsteriaNotification"
		AsteriaNotification.Parent = Ernestlin
		AsteriaNotification.BackgroundColor3 = theme.main
		AsteriaNotification.BorderColor3 = Color3.fromRGB(14, 14, 14)
		AsteriaNotification.BorderSizePixel = 0
		AsteriaNotification.Position = UDim2.new(0.001, 0,0.93, 0)
		AsteriaNotification.Size = UDim2.new(0, 0, 0, 60)
		
		drag(AsteriaNotification, AsteriaNotification)

		Flash.Name = "Flash"
		Flash.Parent = AsteriaNotification
		Flash.BackgroundColor3 = theme.lightcontrast
		Flash.BorderColor3 = Color3.fromRGB(14, 14, 14)
		Flash.BorderSizePixel = 0
		Flash.Position = UDim2.new(-0.00561790448, 0, -0.00153706863, 0)
		Flash.Size = UDim2.new(0, 0, 0, 60)
		Flash.ZIndex = 99

		UICorner.CornerRadius = UDim.new(0, 5)
		UICorner.Parent = Flash

        library.notiactive = true
        
		local function CloseNoti()
			pcall(function()
				if not library.notiactive then return end
				if not AsteriaNotification.ClipsDescendants then
					AsteriaNotification.ClipsDescendants = true
				end
				Flash:TweenSize(UDim2.new(0, textSize.X + 70, 0, 60),"Out","Sine",0.2,false)
				wait(.3)
				AsteriaNotification:TweenSize(UDim2.new(0, 0, 0, 60),"Out","Sine",0.2,false)
				wait(.3)
				AsteriaNotification:Destroy()
				library.notiactive = false
				library.oldnoti = nil
			end)
		end

		UICorner.CornerRadius = UDim.new(0, 4)
		UICorner.Parent = AsteriaNotification

		Title.Name = "Title"
		Title.Parent = AsteriaNotification
		Title.BackgroundTransparency = 1.000
		Title.Position = UDim2.new(0, 10, 0, 8)
		Title.Size = UDim2.new(1, -40, 0, 16)
		Title.ZIndex = 4
		Title.Font = Enum.Font.GothamMedium
		Title.Text = title
		Title.TextColor3 = theme.textcolor
		Title.TextSize = 14.000
		Title.TextXAlignment = Enum.TextXAlignment.Left
		
		Text.Name = "Text"
		Text.Parent = AsteriaNotification
		Text.BackgroundTransparency = 1.000
		Text.Position = UDim2.new(0, 10, 1, -24)
		Text.Size = UDim2.new(1, -40, 0, 16)
		Text.ZIndex = 4
		Text.Font = Enum.Font.Gotham
		Text.Text = msg
		Text.TextColor3 = theme.textcolor
		Text.TextSize = 12.000
		Text.TextXAlignment = Enum.TextXAlignment.Left
        
        if options then
    		Accept.Name = "Accept"
    		Accept.Parent = AsteriaNotification
    		Accept.BackgroundTransparency = 1.000
    		Accept.Position = UDim2.new(1, -26, 0, 8)
    		Accept.Size = UDim2.new(0, 16, 0, 16)
    		Accept.ZIndex = 4
    		Accept.Image = "rbxassetid://5012538259"
    		Accept.ImageColor3 = theme.textcolor
    
    		Decline.Name = "Decline"
    		Decline.Parent = AsteriaNotification
    		Decline.BackgroundTransparency = 1.000
    		Decline.Position = UDim2.new(1, -26, 1, -24)
    		Decline.Size = UDim2.new(0, 16, 0, 16)
    		Decline.ZIndex = 4
    		Decline.Image = "rbxassetid://5012538583"
    		Decline.ImageColor3 = theme.textcolor
        end

		if not library.oldnoti then
			library.oldnoti = {AsteriaNotification,Flash,msg}
		end

		AsteriaNotification:TweenSize(UDim2.new(0, textSize.X + 70, 0, 60),"Out","Sine",0.2,false)
        
        local count = 0
        
        if options then
    		Accept.MouseButton1Click:Connect(function()
    			if callback then
    			    task.spawn(function()
    				    callback(true)
    				end)
    			end
    			CloseNoti()
    		end)
    
    		Decline.MouseButton1Click:Connect(function()
    			if callback then
    			    task.spawn(function()
    				    callback(false)
    				end)
    			end
    			CloseNoti()
    		end)
        end
	
	if not options then
		task.spawn(function()
    		while wait(1) do
    		    if not library.notiactive then break end
    		    if count >= 20 then
    		        CloseNoti()
    		        break
    		    end
    		    count = count + 1
    		end
		end)
		end
	end

	function library:ProgressNoti(title,max,precentige)
		local precentige = precentige or false
		assert(title,"a title is required to create a progress notification")
		assert(max,"a maximum number is required")

		local ProgressNotify = Instance.new("Frame")
		local ProgressNotifyC = Instance.new("UICorner")
		local Title = Instance.new("TextLabel")
		local Inner = Instance.new("Frame")
		local InnerC = Instance.new("UICorner")
		local Bar = Instance.new("Frame")
		local BarC = Instance.new("UICorner")
		local Back = Instance.new("Frame")
		local BackC = Instance.new("UICorner")
		local Percent = Instance.new("TextLabel")
		local BackLL = Instance.new("UIListLayout")
		local BackP = Instance.new("UIPadding")

		ProgressNotify.Name = "ProgressNotify"
		ProgressNotify.Parent = NotifyHolder
		ProgressNotify.BackgroundColor3 =  theme.main
		ProgressNotify.BorderSizePixel = 0
		ProgressNotify.ClipsDescendants = true
		ProgressNotify.Position = UDim2.new(-1, 3, 0.147582695, 0)
		ProgressNotify.Size = UDim2.new(0, 255, 0, 42)

		ProgressNotifyC.CornerRadius = UDim.new(0, 3)
		ProgressNotifyC.Name = "ProgressNotifyC"
		ProgressNotifyC.Parent = ProgressNotify

		Title.Name = "Title"
		Title.Parent = ProgressNotify
		Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Title.BackgroundTransparency = 1.000
		Title.BorderSizePixel = 0
		Title.Size = UDim2.new(0, 186, 0, 24)
		Title.Font = Enum.Font.GothamBold
		Title.Text = " 		"..title
		Title.TextColor3 = theme.textcolor
		Title.TextSize = 13.000
		Title.TextWrapped = true
		Title.TextXAlignment = Enum.TextXAlignment.Left

		Inner.Name = "Inner"
		Inner.Parent = ProgressNotify
		Inner.BackgroundColor3 = theme.accentsecondary
		Inner.BorderSizePixel = 0
		Inner.Position = UDim2.new(0.0235294122, 0, 0.68778044, 0)
		Inner.Size = UDim2.new(0, 243, 0, 5)
		Inner.ZIndex = 3

		InnerC.CornerRadius = UDim.new(55, 1)
		InnerC.Name = "InnerC"
		InnerC.Parent = Inner

		Bar.Name = "Bar"
		Bar.Parent = Inner
		Bar.BackgroundColor3 = theme.textcolor
		Bar.BorderSizePixel = 0
		Bar.Size = UDim2.new(0, 0, 0, 5)
		Bar.ZIndex = 3

		BarC.CornerRadius = UDim.new(1, 0)
		BarC.Name = "BarC"
		BarC.Parent = Bar

		Back.Name = "Back"
		Back.Parent = ProgressNotify
		Back.BackgroundColor3 = Color3.fromRGB(54, 57, 64)
		Back.BorderSizePixel = 0
		Back.ClipsDescendants = true
		Back.Position = UDim2.new(-0.0117647061, 3, 0.00472586509, 0)
		Back.Size = UDim2.new(0, 255, 0, 42)
		Back.ZIndex = 0
		Back.Transparency = 1

		BackC.CornerRadius = UDim.new(0, 3)
		BackC.Name = "BackC"
		BackC.Parent = Back

		Percent.Name = "Percent"
		Percent.Parent = Back
		Percent.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Percent.BackgroundTransparency = 1.000
		Percent.BorderSizePixel = 0
		Percent.Position = UDim2.new(0.514403224, 0, 0, 0)
		Percent.Size = UDim2.new(0, 40, 0, 13)
		Percent.Font = Enum.Font.GothamBold
		Percent.Text = (precentige and "0%" or "0/"..tostring(max))
		Percent.TextColor3 = theme.textcolor
		Percent.TextSize = 13.000
		Percent.TextWrapped = true
		Percent.TextXAlignment = Enum.TextXAlignment.Right

		BackLL.Name = "BackLL"
		BackLL.Parent = Back
		BackLL.HorizontalAlignment = Enum.HorizontalAlignment.Right
		BackLL.SortOrder = Enum.SortOrder.LayoutOrder

		BackP.Name = "BackP"
		BackP.Parent = Back
		BackP.PaddingRight = UDim.new(0, 8)
		BackP.PaddingTop = UDim.new(0, 5)

		local function Close()
			game:GetService('TweenService'):Create(Inner, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
			game:GetService('TweenService'):Create(Bar, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
			game:GetService('TweenService'):Create(Title, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
			game:GetService('TweenService'):Create(Percent, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
			game:GetService('TweenService'):Create(ProgressNotify, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
			task.wait()
			ProgressNotify:Destroy()
		end

		Percent:GetPropertyChangedSignal("Text"):Connect(function()
			if Percent.Text == tostring(max).."/"..tostring(max) or Percent.Text == "100%" then
				Close()
			end
		end)

		local cnum = 0

		local funcs = {
			Update = function(value)
				local newvalue = precentige and cnum + 1 or (string.split(Percent.Text,"/")[1]) + 1
				local percent = newvalue/max
				local dec = math.floor(percent * 100)
				percent = math.clamp(percent, 0, 1)
				Bar:TweenSize(UDim2.new(percent, 0, 0, 5),"Out","Sine",.1,false)
				if not precentige then
					Percent.Text = tostring(newvalue).."/"..max
				else
					Percent.Text = dec..'%'
					cnum = newvalue
				end
			end
		}
		return funcs
	end

	function DestroyUI()
		library.destroyed = true
		Ernestlin:Destroy()
	end

	local active = true
	function HideUi()
		active = not active
		Ernestlin.Enabled = active and true or false
	end

	function SelectPage(pagename)
		local FTab
		for i,v in next, TabHolder:GetChildren() do
			if v:IsA("TextButton") and v:FindFirstChild("TextLabel").Text == " "..pagename then
				FTab = v
			end
		end
		changetab({Holder,FTab})
	end

	drag(Main, Main)

	local tab = {}

	function tab:CreateTab(name,icon)
		assert(name, "a name is required to create a tab")
		local TabBtn = Instance.new("TextButton")
		local TabBtnLayout = Instance.new("UIListLayout")
		local TabBtnPadding = Instance.new("UIPadding")
		local Icon = Instance.new("ImageLabel")
		local TextLabel = Instance.new("TextLabel")

		TabBtn.Name = name
		TabBtn.Parent = TabHolder
		TabBtn.BackgroundColor3 = Color3.fromRGB(95, 95, 95)
		TabBtn.BackgroundTransparency = 1.000
		TabBtn.BorderColor3 = Color3.fromRGB(0, 166, 255)
		TabBtn.BorderSizePixel = 0
		TabBtn.Size = UDim2.new(0, 129, 0, 25)
		TabBtn.AutoButtonColor = false
		TabBtn.Font = Enum.Font.Gotham
		TabBtn.Text = ""
		TabBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
		TabBtn.TextSize = 15.000

		TabBtnLayout.Name = "TabBtnLayout"
		TabBtnLayout.Parent = TabBtn
		TabBtnLayout.FillDirection = Enum.FillDirection.Horizontal
		TabBtnLayout.SortOrder = Enum.SortOrder.LayoutOrder
		TabBtnLayout.VerticalAlignment = Enum.VerticalAlignment.Center
		TabBtnLayout.Padding = UDim.new(0, 3)

		TabBtnPadding.Name = "TabBtnPadding"
		TabBtnPadding.Parent = TabBtn
		TabBtnPadding.PaddingLeft = UDim.new(0, 3)

		Icon.Name = "Icon"
		Icon.Parent = TabBtn
		Icon.AnchorPoint = Vector2.new(0, 0.5)
		Icon.BackgroundTransparency = 1.000
		Icon.Position = UDim2.new(-1.67533565, 12, 0.290150881, 0)
		Icon.Size = UDim2.new(0, 20, 0, 20)
		Icon.ZIndex = 3
		Icon.Image = "rbxassetid://"..icon
		Icon.ScaleType = Enum.ScaleType.Fit

		TextLabel.Parent = TabBtn
		TextLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		TextLabel.BackgroundTransparency = 1.000
		TextLabel.BorderSizePixel = 0
		TextLabel.Position = UDim2.new(0.172255695, 0, 0.0745565519, 0)
		TextLabel.Size = UDim2.new(0.831201971, 0, 0.850887954, 0)
		TextLabel.Font = Enum.Font.GothamMedium
		TextLabel.Text = " "..name
		TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		TextLabel.TextSize = 13.000
		TextLabel.TextXAlignment = Enum.TextXAlignment.Left

		TabBtn.MouseButton1Click:Connect(function()
			if library.locked then return end
			changetab({Holder,TabBtn})
		end)

		HolderL:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
			Holder.CanvasSize = UDim2.new(0, 0, 0, HolderL.AbsoluteContentSize.Y + 16)
		end)

		local section = {}

		function section:CreateSection(title)
			local Section = Instance.new("Frame")
			local SectionC = Instance.new("UICorner")
			local SectionL = Instance.new("UIListLayout")
			local SectionP = Instance.new("UIPadding")
			local TextLabel = Instance.new("TextLabel")

			Section.Name = "Section"..TabBtn.Name
			Section.Parent = Holder
			Section.BackgroundColor3 = theme.secondary
			Section.BorderSizePixel = 0
			Section.Position = UDim2.new(0.0408163257, 0, 0, 0)
			Section.Size = UDim2.new(0, 367, 0, 372)
			Section.Visible = false

			SectionC.CornerRadius = UDim.new(0, 3)
			SectionC.Name = "SectionC"
			SectionC.Parent = Section

			SectionL.Name = "SectionL"
			SectionL.Parent = Section
			SectionL.HorizontalAlignment = Enum.HorizontalAlignment.Center
			SectionL.SortOrder = Enum.SortOrder.LayoutOrder
			SectionL.Padding = UDim.new(0, 5)

			SectionP.Name = "SectionP"
			SectionP.Parent = Section
			SectionP.PaddingTop = UDim.new(0, 5)

			TextLabel.Parent = Section
			TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TextLabel.BackgroundTransparency = 1.000
			TextLabel.BorderSizePixel = 0
			TextLabel.Size = UDim2.new(0, 366, 0, 24)
			TextLabel.Font = Enum.Font.GothamMedium
			TextLabel.Text = "  "..title
			TextLabel.TextColor3 = theme.textcolor
			TextLabel.TextSize = 14
			TextLabel.TextWrapped = true
			TextLabel.TextXAlignment = Enum.TextXAlignment.Left

			SectionL:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
				Section.Size = UDim2.new(0, 371, 0, SectionL.AbsoluteContentSize.Y + 14)
			end)

			local Holder = {}

			function Holder:Button(name,callback)
				local callback = callback or function() end
				assert(name,"a name is required to create a button")

				local Btn = Instance.new("TextButton")
				local BtnC = Instance.new("UICorner")

				Btn.Name = "Btn"
				Btn.Parent = Section
				Btn.BackgroundColor3 = theme.accent
				Btn.BorderSizePixel = 0
				Btn.Position = UDim2.new(0.0204359666, 0, 0.0790190771, 0)
				Btn.Size = UDim2.new(0, 352, 0, 33)
				Btn.AutoButtonColor = false
				Btn.Font = Enum.Font.GothamMedium
				Btn.TextColor3 = theme.textcolor
				Btn.TextSize = 13.000
				Btn.Text = name

				BtnC.CornerRadius = UDim.new(0, 3)
				BtnC.Name = "BtnC"
				BtnC.Parent = Btn

				local funcs = {
					ChangeText = function(self,txt)
						if Btn.Text == txt then return end
						Btn.Text = txt
					end,

					DeleteButton = function(self)
						Btn:Destroy()
					end,

					GetTxt = function(self)
						return Btn.Text
					end,
				}

				Btn.MouseButton1Click:Connect(function()
					if library.locked then return end
					spawn(callback)
					game:GetService("TweenService"):Create(Btn, TweenInfo.new(0.1), {BackgroundColor3 = theme.lightcontrast}):Play()
					task.wait(0.1)
					game:GetService("TweenService"):Create(Btn, TweenInfo.new(0.1), {BackgroundColor3 = theme.accent}):Play()
				end)
				return funcs
			end

			function Holder:Label(name)
				assert(name,"text is required to create a label")
				local Label = Instance.new("TextButton")
				local LabelC = Instance.new("UICorner")

				Label.Name = "Label"
				Label.Parent = Section
				Label.BackgroundColor3 = theme.accent
				Label.BorderSizePixel = 0
				Label.Position = UDim2.new(0.0204359666, 0, 0.389645785, 0)
				Label.Size = UDim2.new(0, 352, 0, 24)
				Label.AutoButtonColor = false
				Label.Font = Enum.Font.GothamMedium
				Label.Text = name
				Label.TextColor3 = theme.textcolor
				Label.TextSize = 13.000
				Label.TextWrapped = true

				LabelC.CornerRadius = UDim.new(0, 3)
				LabelC.Name = "LabelC"
				LabelC.Parent = Label
				return Label
			end

			function Holder:KeyBind(name,default,callback)
				local callback = callback or function() end
				assert(name,"a name is required to create a keybind")
				assert(default,"a default key is required to create a keybind")

				local default = (typeof(default) == "string" and Enum.KeyCode[default] or default)

				local banned = {
					Return = true;
					Space = true;
					Tab = true;
					Backquote = true;
					CapsLock = true;
					Escape = true;
					Unknown = true;
				}

				local shortNames = {
					RightControl = 'Right Ctrl',
					LeftControl = 'Left Ctrl',
					LeftShift = 'Left Shift',
					RightShift = 'Right Shift',
					Semicolon = ";",
					Quote = '"',
					LeftBracket = '[',
					RightBracket = ']',
					Equals = '=',
					Minus = '-',
					RightAlt = 'Right Alt',
					LeftAlt = 'Left Alt'
				}

				local bindKey = default
				local keyTxt = (default and (shortNames[default.Name] or default.Name) or "None")

				local KeyBind = Instance.new("TextButton")
				local KeyBindC = Instance.new("UICorner")
				local Click = Instance.new("TextButton")
				local ClickC = Instance.new("UICorner")
				local UIListLayout = Instance.new("UIListLayout")
				local UIPadding = Instance.new("UIPadding")

				KeyBind.Name = "KeyBind"
				KeyBind.Parent = Section
				KeyBind.BackgroundColor3 = theme.accent
				KeyBind.BorderSizePixel = 0
				KeyBind.Position = UDim2.new(0.0204359666, 0, 0.174386919, 0)
				KeyBind.Size = UDim2.new(0, 352, 0, 33)
				KeyBind.ZIndex = 3
				KeyBind.AutoButtonColor = false
				KeyBind.Font = Enum.Font.GothamMedium
				KeyBind.Text = "  "..name
				KeyBind.TextColor3 = theme.textcolor
				KeyBind.TextSize = 13.000
				KeyBind.TextXAlignment = Enum.TextXAlignment.Left

				KeyBindC.CornerRadius = UDim.new(0, 3)
				KeyBindC.Name = "KeyBindC"
				KeyBindC.Parent = KeyBind

				Click.Name = "Click"
				Click.Parent = KeyBind
				Click.BackgroundColor3 = theme.accentsecondary 
				Click.BorderSizePixel = 0
				Click.Position = UDim2.new(0.771000028, 0, 0.170000002, 0)
				Click.Size = UDim2.new(0, 74, 0, 22)
				Click.ZIndex = 3
				Click.AutoButtonColor = false
				Click.Font = Enum.Font.GothamMedium
				Click.Text = keyTxt
				Click.TextColor3 = theme.textcolor
				Click.TextSize = 12.000

				ClickC.CornerRadius = UDim.new(0, 4)
				ClickC.Name = "ClickC"
				ClickC.Parent = Click

				UIListLayout.Parent = KeyBind
				UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
				UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
				UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center

				UIPadding.Parent = KeyBind
				UIPadding.PaddingRight = UDim.new(0, 6)

				game:GetService("UserInputService").InputBegan:Connect(function(inp, gpe)
					if library.destroyed then return end
					if gpe then return end
					if inp.UserInputType ~= Enum.UserInputType.Keyboard then return end
					if inp.KeyCode ~= bindKey then return end
					callback(bindKey.Name)
				end)

				Click.MouseButton1Click:Connect(function()
					if library.locked then return end
					Click.Text = "..."
					wait()
					local key, uwu = game.UserInputService.InputEnded:Wait()
					local keyName = tostring(key.KeyCode.Name)
					if key.UserInputType ~= Enum.UserInputType.Keyboard then
						Click.Text = keyTxt
						return
					end
					if banned[keyName] then
						Click.Text = keyTxt
						return
					end
					wait()
					bindKey = Enum.KeyCode[keyName]
					Click.Text = shortNames[keyName] or keyName
				end)

				Click:GetPropertyChangedSignal("TextBounds"):Connect(function()
					Click.Size = UDim2.new(0, Click.TextBounds.X + 30, 0, 22)
				end)
				Click.Size = UDim2.new(0, Click.TextBounds.X + 30, 0, 22)
			end

			function Holder:TextBox(name,default,callback)
				local callback = callback or function() end
				local flag = name
				assert(name,"a name is required to create a textbox")
				assert(default,"default text is required to create a textbox")
				library.flags[flag] = default

				local TextBox = Instance.new("TextButton")
				local TextBoxC = Instance.new("UICorner")
				local Input = Instance.new("TextBox")
				local InputC = Instance.new("UICorner")
				local UIListLayout = Instance.new("UIListLayout")
				local UIPadding = Instance.new("UIPadding")

				TextBox.Name = "TextBox"
				TextBox.Parent = Section
				TextBox.BackgroundColor3 = theme.accent
				TextBox.BorderSizePixel = 0
				TextBox.Position = UDim2.new(0.0204359666, 0, 0.174386919, 0)
				TextBox.Size = UDim2.new(0, 352, 0, 33)
				TextBox.ZIndex = 3
				TextBox.AutoButtonColor = false
				TextBox.Font = Enum.Font.GothamMedium
				TextBox.Text = "  "..name
				TextBox.TextColor3 = theme.textcolor
				TextBox.TextSize = 13.000
				TextBox.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
				TextBox.TextXAlignment = Enum.TextXAlignment.Left

				TextBoxC.CornerRadius = UDim.new(0, 3)
				TextBoxC.Name = "TextBoxC"
				TextBoxC.Parent = TextBox

				Input.Name = "Input"
				Input.Parent = TextBox
				Input.BackgroundColor3 = theme.accentsecondary 
				Input.BorderSizePixel = 0
				Input.Position = UDim2.new(0.771000028, 0, 0.170000002, 0)
				Input.Size = UDim2.new(0, 74, 0, 22)
				Input.Font = Enum.Font.GothamMedium
				Input.Text = default
				Input.TextColor3 = theme.textcolor
				Input.TextSize = 12.000
				Input.TextWrapped = true

				InputC.CornerRadius = UDim.new(0, 4)
				InputC.Name = "InputC"
				InputC.Parent = Input

				UIListLayout.Parent = TextBox
				UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
				UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
				UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center

				UIPadding.Parent = TextBox
				UIPadding.PaddingRight = UDim.new(0, 6)

				Input.FocusLost:Connect(function()
					if library.locked then
						Input.Text = default
						return 
					end
					if Input.Text == "" then
						Input.Text = default
					end
					library.flags[flag] = Input.Text
					callback(Input.Text)
				end)

				Input:GetPropertyChangedSignal("TextBounds"):Connect(function()
					Input.Size = UDim2.new(0, Input.TextBounds.X + 30, 0, 22)
				end)
				Input.Size = UDim2.new(0, Input.TextBounds.X + 30, 0, 22)
			end

			function Holder:Toggle(name,default,callback)
				local callback = callback or function() end
				local default = default or false
				assert(name,"a name is required to create a toggle")
				local flag = name
				library.flags[flag] = default

				local Toggle = Instance.new("TextButton")
				local ToggleC = Instance.new("UICorner")
				local Inner = Instance.new("Frame")
				local ClickC = Instance.new("UICorner")
				local Circle = Instance.new("Frame")
				local ClickC_2 = Instance.new("UICorner")

				Toggle.Name = "Toggle"
				Toggle.Parent = Section
				Toggle.BackgroundColor3 = theme.accent
				Toggle.BorderSizePixel = 0
				Toggle.Position = UDim2.new(0.0395095348, 0, 0.160762936, 0)
				Toggle.Size = UDim2.new(0, 352, 0, 33)
				Toggle.ZIndex = 3
				Toggle.AutoButtonColor = false
				Toggle.Font = Enum.Font.GothamMedium
				Toggle.Text = "  "..name
				Toggle.TextColor3 = theme.textcolor
				Toggle.TextSize = 13.000
				Toggle.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
				Toggle.TextXAlignment = Enum.TextXAlignment.Left

				ToggleC.CornerRadius = UDim.new(0, 3)
				ToggleC.Name = "ToggleC"
				ToggleC.Parent = Toggle

				Inner.Name = "Inner"
				Inner.Parent = Toggle
				Inner.BackgroundColor3 = theme.accentsecondary 
				Inner.BorderSizePixel = 0
				Inner.Position = UDim2.new(0.864749908, 0, 0.200302586, 0)
				Inner.Size = UDim2.new(0, 41, 0, 19)
				Inner.ZIndex = 3

				ClickC.CornerRadius = UDim.new(1, 0)
				ClickC.Name = "ClickC"
				ClickC.Parent = Inner

				Circle.Name = "Circle"
				Circle.Parent = Inner
				Circle.BackgroundColor3 = theme.textcolor
				Circle.BorderSizePixel = 0
				Circle.Position = UDim2.new(0.100000001, 0, 0.158000007, 0)
				Circle.Size = UDim2.new(0, 13, 0, 13)
				Circle.ZIndex = 3

				ClickC_2.CornerRadius = UDim.new(5, 0)
				ClickC_2.Name = "ClickC"
				ClickC_2.Parent = Circle

				local funcs = {}

				funcs.Set = function(self,Value)
					if Value == nil then
						Value = not library.flags[flag]
					end
					Circle:TweenPosition(Value and UDim2.new(0.6, 0,0.158, 0) or UDim2.new(0.1, 0,0.158, 0),"Out","Sine",0.1,false)
					game:GetService("TweenService"):Create(Inner, TweenInfo.new(0.1), {BackgroundColor3 = (Value and theme.lightcontrast or theme.accentsecondary)}):Play()
					library.flags[flag] = Value
					callback(Value)
				end

				if default then
					funcs:Set(true)
				end

				Toggle.MouseButton1Click:Connect(function()
					if library.locked then return end
					funcs:Set()
				end)
				return funcs
			end
function Holder:Slider(name,default,min,max,precise,callback)
				local callback = callback or function() end
				local min = min or 1 
				local max = max or 10
				local default = default or min
				local precise = precise or false
				local flag = name
				assert(name,"a name is required to create a slider")
				library.flags[flag] = default

				local Slider = Instance.new("TextButton")
				local SliderC = Instance.new("UICorner")
				local Title = Instance.new("TextLabel")
				local Bar = Instance.new("Frame")
				local BarC = Instance.new("UICorner")
				local Inner = Instance.new("Frame")
				local InnerC = Instance.new("UICorner")
				local Circle = Instance.new("Frame")
				local CircleC = Instance.new("UICorner")
				local Number = Instance.new("TextBox")

				Slider.Name = "Slider"
				Slider.Parent = Section
				Slider.BackgroundColor3 = theme.accent
				Slider.BorderSizePixel = 0
				Slider.Position = UDim2.new(0.0204359666, 0, 0.572207153, 0)
				Slider.Size = UDim2.new(0, 352, 0, 47)
				Slider.AutoButtonColor = false
				Slider.Font = Enum.Font.GothamMedium
				Slider.Text = name
				Slider.TextColor3 = theme.textcolor
				Slider.TextSize = 13.000
				Slider.TextTransparency = 1

				SliderC.CornerRadius = UDim.new(0, 3)
				SliderC.Name = "SliderC"
				SliderC.Parent = Slider

				Title.Name = "Title"
				Title.Parent = Slider
				Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Title.BackgroundTransparency = 1.000
				Title.Position = UDim2.new(0, 0, 0.108081058, 0)
				Title.Size = UDim2.new(0, 188, 0, 17)
				Title.ZIndex = 4
				Title.Font = Enum.Font.GothamMedium
				Title.Text = "  "..name
				Title.TextColor3 = theme.textcolor
				Title.TextSize = 13.000
				Title.TextXAlignment = Enum.TextXAlignment.Left

				Bar.Name = "Bar"
				Bar.Parent = Slider
				Bar.BackgroundColor3 = theme.accentsecondary
				Bar.BorderSizePixel = 0
				Bar.Position = UDim2.new(0.0204360262, 0, 0.691390693, 0)
				Bar.Size = UDim2.new(0, 337, 0, 4)

				BarC.CornerRadius = UDim.new(1, 0)
				BarC.Name = "BarC"
				BarC.Parent = Bar

				Inner.Name = "Inner"
				Inner.Parent = Bar
				Inner.BackgroundColor3 = theme.textcolor
				Inner.BorderSizePixel = 0
				Inner.Size = UDim2.new(0.894060731, 0, 1, 0)

				InnerC.CornerRadius = UDim.new(0, 9999)
				InnerC.Name = "InnerC"
				InnerC.Parent = Inner

				Circle.Name = "Circle"
				Circle.Parent = Inner
				Circle.BackgroundColor3 = theme.textcolor
				Circle.Position = UDim2.new(0.979818106, 0, -0.75, 0)
				Circle.Size = UDim2.new(0, 10, 0, 10)

				CircleC.CornerRadius = UDim.new(0, 9999)
				CircleC.Name = "CircleC"
				CircleC.Parent = Circle

				Number.Name = "Number"
				Number.Parent = Slider
				Number.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Number.BackgroundTransparency = 1.000
				Number.Position = UDim2.new(0.742874861, 0, 0.108080924, 0)
				Number.Size = UDim2.new(0, 82, 0, 17)
				Number.ZIndex = 4
				Number.Font = Enum.Font.GothamMedium
				Number.Text = "200"
				Number.TextColor3 = theme.textcolor
				Number.TextSize = 13.000
				Number.TextXAlignment = Enum.TextXAlignment.Right

				local funcs = {}

				funcs.Set = function(self,value)
					local percent = (mouse.X - Bar.AbsolutePosition.X) / Bar.AbsoluteSize.X
					if value then
						percent = (value - min) / (max - min)
					end
					percent = math.clamp(percent, 0, 1)
					if precise then
						value = value or tonumber(string.format("%.1f", tostring(min + (max - min) * percent)))
					else
						value = value or math.floor(min + (max - min) * percent)
					end
					library.flags[flag] = tonumber(value)
					Number.Text = tostring(value)
					Inner.Size = UDim2.new(percent, 0, 1, 0)
					callback(tonumber(value))
				end

				funcs:Set(tonumber(default))

				local dragging, boxFocused, allowed = false, false, {
					[""] = true,
					["-"] = true
				}

				Slider.InputBegan:Connect(function(input)
					if library.locked then return end
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						funcs:Set()
						dragging = true
					end
				end)

				game:GetService("UserInputService").InputEnded:Connect(function(input)
					if library.locked then return end
					if dragging and input.UserInputType == Enum.UserInputType.MouseButton1 then
						dragging = false
					end
				end)

				game:GetService("UserInputService").InputChanged:Connect(function(input)
					if library.locked then return end
					if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
						funcs:Set()
					end
				end)

				Number.Focused:Connect(function()
					if library.locked then return end
					boxFocused = true
				end)

				Number.FocusLost:Connect(function()
					if library.locked then return end
					boxFocused = false
					if Number.Text == "" then
						funcs:Set(default)
					end
					if tonumber(Number.Text) < min then
						Number.Text = min
						Number.Text = tonumber(min)
					end
				end)

				Number:GetPropertyChangedSignal("Text"):Connect(function()
					if library.locked then return end
					if not boxFocused then return end
					Number.Text = Number.Text:gsub("%D+", "")

					local text = Number.Text

					if not tonumber(text) then
						Number.Text = Number.Text:gsub('%D+', '')
					elseif not allowed[text] then
						if tonumber(text) > max then
							text = max
							Number.Text = tostring(max)
						end
						if tonumber(text) >= min then
							funcs:Set(tonumber(text))
						end
					end
				end)
				return funcs
			end

			function Holder:DropDown(name,options,reset,callback)
				local callback = callback or function() end
				local reset = reset or false
				local flag = name
				assert(name,"a name is required to create a dropdown")

				local DropDown = Instance.new("TextButton")
				local DropDownC = Instance.new("UICorner")
				local Search = Instance.new("TextBox")
				local SearchP = Instance.new("UIPadding")
				local Arrow = Instance.new("ImageButton")
				local DropDownHolder = Instance.new("Frame")
				local OptionHolder = Instance.new("ScrollingFrame")
				local OptionHolderL = Instance.new("UIListLayout")
				local DDHC = Instance.new("UICorner")

				DropDown.Name = "DropDown"
				DropDown.Parent = Section
				DropDown.BackgroundColor3 = theme.accent
				DropDown.BorderSizePixel = 0
				DropDown.ClipsDescendants = true
				DropDown.Position = UDim2.new(0.0204359666, 0, 0.0790190771, 0)
				DropDown.Size = UDim2.new(0, 352, 0, 33)
				DropDown.AutoButtonColor = false
				DropDown.Font = Enum.Font.GothamMedium
				DropDown.Text = name
				DropDown.TextColor3 = theme.textcolor
				DropDown.TextSize = 13.000
				DropDown.TextTransparency = 1

				DropDownC.CornerRadius = UDim.new(0, 3)
				DropDownC.Name = "DropDownC"
				DropDownC.Parent = DropDown

				Search.Name = "Search"
				Search.Parent = DropDown
				Search.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Search.BackgroundTransparency = 1.000
				Search.BorderColor3 = Color3.fromRGB(27, 42, 53)
				Search.BorderSizePixel = 0
				Search.Size = UDim2.new(0, 304, 0, 33)
				Search.Font = Enum.Font.GothamMedium
				Search.Text = name
				Search.TextColor3 = theme.textcolor
				Search.TextSize = 13.000
				Search.TextXAlignment = Enum.TextXAlignment.Left

				SearchP.Name = "SearchP"
				SearchP.Parent = Search
				SearchP.PaddingLeft = UDim.new(0, 6)

				Arrow.Name = "Arrow"
				Arrow.Parent = DropDown
				Arrow.BackgroundTransparency = 1.000
				Arrow.BorderSizePixel = 0
				Arrow.ClipsDescendants = true
				Arrow.Position = UDim2.new(1.00139761, -28, 0.303030312, -9)
				Arrow.Rotation = 90.000
				Arrow.Size = UDim2.new(0, 23, 0, 31)
				Arrow.ZIndex = 1
				Arrow.Image = "rbxassetid://5012539403"
				Arrow.SliceCenter = Rect.new(2, 2, 298, 298)
				Arrow.ImageColor3 = theme.textcolor

				DropDownHolder.Name = "DropDownHolder "..name
				DropDownHolder.Parent = Section
				DropDownHolder.BackgroundColor3 = Color3.fromRGB(36, 37, 41)
				DropDownHolder.BorderSizePixel = 0
				DropDownHolder.ClipsDescendants = true
				DropDownHolder.Position = UDim2.new(0.0204359666, 0, 0.398406386, 0)
				DropDownHolder.Size = UDim2.new(0, 352, 0, 0)
				DropDownHolder.Visible = false

				OptionHolder.Name = "OptionHolder"
				OptionHolder.Parent = DropDownHolder
				OptionHolder.Active = true
				OptionHolder.BackgroundColor3 = Color3.fromRGB(36, 37, 41)
				OptionHolder.BorderSizePixel = 0
				OptionHolder.Position = UDim2.new(0, 0, 0.0413798429, 0)
				OptionHolder.Size = UDim2.new(0, 351, 0, 146)
				OptionHolder.CanvasSize = UDim2.new(0, 0, 0, 0)
				OptionHolder.ScrollBarThickness = 0

				OptionHolderL.Name = "OptionHolderL"
				OptionHolderL.Parent = OptionHolder
				OptionHolderL.HorizontalAlignment = Enum.HorizontalAlignment.Center
				OptionHolderL.SortOrder = Enum.SortOrder.LayoutOrder
				OptionHolderL.Padding = UDim.new(0, 5)

				DDHC.CornerRadius = UDim.new(0, 3)
				DDHC.Name = "DDHC"
				DDHC.Parent = DropDownHolder

				Search:GetPropertyChangedSignal("Text"):connect(function()
					Search.TextXAlignment = Search.TextFits and Enum.TextXAlignment.Left or Enum.TextXAlignment.Right
				end)

				local function showall()
					for i,v in next, OptionHolder:GetChildren() do
						if v:IsA("TextButton") and v.Name == "Option" then 
							v.Visible = true
						end
					end
				end

				local function search(text)
					if text == "" then
						showall()
					end
					for i,v in next, OptionHolder:GetChildren() do
						if v:IsA("TextButton") and v.Name == "Option" then
							if v.Text:lower():match(text:lower()) then
								v.Visible = true
							else
								v.Visible = false
							end
						end
					end
				end

				local isopen = false
				local function opendd()
					isopen = not isopen
					if isopen then
						DropDownHolder.Visible = true
					end
					Arrow.Rotation = isopen and 0 or 90
					DropDownHolder:TweenSize(UDim2.new(0, 352,0, (isopen and 153 or 0)),"Out","Sine",0.3,false)
					task.wait(0.3)
					if not isopen then
						DropDownHolder.Visible = false
					end
					showall()
				end

				Search:GetPropertyChangedSignal("Text"):Connect(function()
					if not isopen then return end
					if Search.Text == name then return end
					search(Search.Text)
				end)

				local issearching = false
				Search.Focused:Connect(function()
					if not isopen then opendd() end
					issearching = true
				end)

				Search.FocusLost:Connect(function()
					if Search.Text == "" then
						Search.Text = name
					end
					if reset then
						if issearching then return end
						Search.Text = name
					end
					if isopen then
						opendd()
					end
				end)

				Arrow.MouseButton1Click:Connect(function()
					if library.locked then return end
					opendd()
				end)

				OptionHolderL:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
					OptionHolder.CanvasSize = UDim2.new(0, 0, 0, OptionHolderL.AbsoluteContentSize.Y + 10)
				end)

				local current
				local funcs = {}

				funcs.AddOption = function(self,opname)
					local Option = Instance.new("TextButton")
					local BtnC = Instance.new("UICorner")

					Option.Name = "Option"
					Option.Parent = OptionHolder
					Option.BackgroundColor3 = theme.accentsecondary 
					Option.BorderSizePixel = 0
					Option.Position = UDim2.new(0.00997150969, 0, 0, 0)
					Option.Size = UDim2.new(0, 344, 0, 31)
					Option.AutoButtonColor = false
					Option.Font = Enum.Font.GothamMedium
					Option.Text = opname
					Option.TextColor3 = theme.textcolor
					Option.TextSize = 13.000

					BtnC.CornerRadius = UDim.new(0, 3)
					BtnC.Name = "BtnC"
					BtnC.Parent = Option

					Option.MouseButton1Click:Connect(function()
						callback(Option.Text)
						library.flags[flag] = Option.Text
						opendd()
						issearching = false
						if not reset then
							Search.Text = "Selected: "..Option.Text
							if current ~= nil then
								current.TextColor3 = Color3.fromRGB(225,225,225)
							end
							Option.TextColor3 = Color3.fromRGB(0, 101, 195)
							current = Option
						else
							Search.Text = name
						end
					end)
				end

				funcs.SetList = function(self,options)
					for i,v in next, OptionHolder:GetChildren() do
						if v:IsA("TextButton") and v.Name == "Option" then
							v:Destroy()
						end
					end
					for i,v in next, options do
						funcs:AddOption(v)
					end
				end

				funcs.RemoveOption = function(self,name)
					for i,v in next, OptionHolder:GetChildren() do
						if v:IsA("TextButton") and v.Name == "Option" then
							if v.Text == name then
								v:Destroy()
							end
						end
					end
				end

				funcs:SetList(options)
				return funcs
			end

			function Holder:PlrList(name,reset,addclient,callback)
				local callback = callback or function() end
				local reset = reset or false
				local addclient = addclient or false
				assert(name,"a name is required to create a dropdown")
				local flag = name

				local function CreatList()
					local plrs = {}
					for i,v in next, game.Players:GetPlayers() do
						if v.Name ~= game.Players.LocalPlayer.Name then
							table.insert(plrs,v.Name)
						end
					end
					if addclient then 
						table.insert(plrs,game.Players.LocalPlayer.Name)
					end
					return plrs
				end

				local DropDown = Instance.new("TextButton")
				local DropDownC = Instance.new("UICorner")
				local Search = Instance.new("TextBox")
				local SearchP = Instance.new("UIPadding")
				local Arrow = Instance.new("ImageButton")
				local DropDownHolder = Instance.new("Frame")
				local OptionHolder = Instance.new("ScrollingFrame")
				local OptionHolderL = Instance.new("UIListLayout")
				local DDHC = Instance.new("UICorner")

				DropDown.Name = "DropDown"
				DropDown.Parent = Section
				DropDown.BackgroundColor3 = theme.accent
				DropDown.BorderSizePixel = 0
				DropDown.ClipsDescendants = true
				DropDown.Position = UDim2.new(0.0204359666, 0, 0.0790190771, 0)
				DropDown.Size = UDim2.new(0, 352, 0, 33)
				DropDown.AutoButtonColor = false
				DropDown.Font = Enum.Font.GothamMedium
				DropDown.Text = name
				DropDown.TextColor3 = theme.textcolor
				DropDown.TextSize = 13.000
				DropDown.TextTransparency = 1

				DropDownC.CornerRadius = UDim.new(0, 3)
				DropDownC.Name = "DropDownC"
				DropDownC.Parent = DropDown

				Search.Name = "Search"
				Search.Parent = DropDown
				Search.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Search.BackgroundTransparency = 1.000
				Search.BorderColor3 = Color3.fromRGB(27, 42, 53)
				Search.BorderSizePixel = 0
				Search.Size = UDim2.new(0, 304, 0, 33)
				Search.Font = Enum.Font.GothamMedium
				Search.Text = name
				Search.TextColor3 = theme.textcolor
				Search.TextSize = 13.000
				Search.TextXAlignment = Enum.TextXAlignment.Left

				SearchP.Name = "SearchP"
				SearchP.Parent = Search
				SearchP.PaddingLeft = UDim.new(0, 6)

				Arrow.Name = "Arrow"
				Arrow.Parent = DropDown
				Arrow.BackgroundTransparency = 1.000
				Arrow.BorderSizePixel = 0
				Arrow.ClipsDescendants = true
				Arrow.Position = UDim2.new(1.00139761, -28, 0.303030312, -9)
				Arrow.Rotation = 90.000
				Arrow.Size = UDim2.new(0, 23, 0, 31)
				Arrow.ZIndex = 1
				Arrow.Image = "rbxassetid://5012539403"
				Arrow.SliceCenter = Rect.new(2, 2, 298, 298)
				Arrow.ImageColor3 = theme.textcolor

				DropDownHolder.Name = "DropDownHolder "..name
				DropDownHolder.Parent = Section
				DropDownHolder.BackgroundColor3 = Color3.fromRGB(36, 37, 41)
				DropDownHolder.BorderSizePixel = 0
				DropDownHolder.ClipsDescendants = true
				DropDownHolder.Position = UDim2.new(0.0204359666, 0, 0.398406386, 0)
				DropDownHolder.Size = UDim2.new(0, 352, 0, 0)
				DropDownHolder.Visible = false

				OptionHolder.Name = "OptionHolder"
				OptionHolder.Parent = DropDownHolder
				OptionHolder.Active = true
				OptionHolder.BackgroundColor3 = Color3.fromRGB(36, 37, 41)
				OptionHolder.BorderSizePixel = 0
				OptionHolder.Position = UDim2.new(0, 0, 0.0413798429, 0)
				OptionHolder.Size = UDim2.new(0, 351, 0, 146)
				OptionHolder.CanvasSize = UDim2.new(0, 0, 0, 0)
				OptionHolder.ScrollBarThickness = 0

				OptionHolderL.Name = "OptionHolderL"
				OptionHolderL.Parent = OptionHolder
				OptionHolderL.HorizontalAlignment = Enum.HorizontalAlignment.Center
				OptionHolderL.SortOrder = Enum.SortOrder.LayoutOrder
				OptionHolderL.Padding = UDim.new(0, 5)

				DDHC.CornerRadius = UDim.new(0, 3)
				DDHC.Name = "DDHC"
				DDHC.Parent = DropDownHolder

				Search:GetPropertyChangedSignal("Text"):connect(function()
					Search.TextXAlignment = Search.TextFits and Enum.TextXAlignment.Left or Enum.TextXAlignment.Right
				end)

				local function showall()
					for i,v in next, OptionHolder:GetChildren() do
						if v:IsA("TextButton") and v.Name == "Option" then 
							v.Visible = true
						end
					end
				end

				local function search(text)
					if text == "" then
						showall()
					end
					for i,v in next, OptionHolder:GetChildren() do
						if v:IsA("TextButton") and v.Name == "Option" then
							if v.Text:lower():match(text:lower()) then
								v.Visible = true
							else
								v.Visible = false
							end
						end
					end
				end

				local isopen = false
				local function opendd()
					isopen = not isopen
					if isopen then
						DropDownHolder.Visible = true
					end
					Arrow.Rotation = isopen and 0 or 90
					DropDownHolder:TweenSize(UDim2.new(0, 352,0, (isopen and 153 or 0)),"Out","Sine",0.3,false)
					task.wait(0.3)
					if not isopen then
						DropDownHolder.Visible = false
					end
				end

				Search:GetPropertyChangedSignal("Text"):Connect(function()
					if not isopen then return end
					if Search.Text == name then return end
					search(Search.Text)
				end)

				local issearching = false
				Search.Focused:Connect(function()
					if not isopen then opendd() end
					issearching = true
				end)

				Search.FocusLost:Connect(function()
					if Search.Text == "" then
						Search.Text = name
						issearching = false
					end
					if reset then
						if issearching then return end
						Search.Text = name
					end
				end)

				OptionHolderL:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
					OptionHolder.CanvasSize = UDim2.new(0, 0, 0, OptionHolderL.AbsoluteContentSize.Y + 10)
				end)

				local funcs = {}
				local current 
				funcs.AddOption = function(self,opname)
					local Option = Instance.new("TextButton")
					local BtnC = Instance.new("UICorner")

					Option.Name = "Option"
					Option.Parent = OptionHolder
					Option.BackgroundColor3 = theme.accentsecondary
					Option.BorderSizePixel = 0
					Option.Position = UDim2.new(0.00997150969, 0, 0, 0)
					Option.Size = UDim2.new(0, 344, 0, 31)
					Option.AutoButtonColor = false
					Option.Font = Enum.Font.GothamMedium
					Option.Text = opname
					Option.TextColor3 = theme.textcolor
					Option.TextSize = 13.000

					BtnC.CornerRadius = UDim.new(0, 3)
					BtnC.Name = "BtnC"
					BtnC.Parent = Option

					Option.MouseButton1Click:Connect(function()
						callback(Option.Text)
						library.flags[flag] = Option.Text
						opendd()
						issearching = false
						if not reset then
							Search.Text = "Selected: "..Option.Text
							if current ~= nil then
								current.TextColor3 = Color3.fromRGB(225,225,225)
							end
							Option.TextColor3 = Color3.fromRGB(0, 101, 195)
							current = Option
						else
							Search.Text = name
						end
					end)
				end

				funcs.SetList = function(self)
					for i,v in next, OptionHolder:GetChildren() do
						if v:IsA("TextButton") and v.Name == "Option" then
							v:Destroy()
						end
					end
					for i,v in next, CreatList() do
						funcs:AddOption(v)
					end
				end

				funcs.RemoveOption = function(self,name)
					for i,v in next, OptionHolder:GetChildren() do
						if v:IsA("TextButton") and v.Name == "Option" then
							if v.Text == name then
								v:Destroy()
							end
						end
					end
				end

				Arrow.MouseButton1Click:Connect(function()
					if library.locked then return end
					funcs:SetList()
					opendd()
				end)
				return funcs
			end

			function Holder:MultiDropDown(name,options,callback)
				local callback = callback or function() end
				local flag = name
				assert(name,"a name is required to create a dropdown")

				local DropDown = Instance.new("TextButton")
				local DropDownC = Instance.new("UICorner")
				local Search = Instance.new("TextBox")
				local SearchP = Instance.new("UIPadding")
				local Arrow = Instance.new("ImageButton")
				local DropDownHolder = Instance.new("Frame")
				local OptionHolder = Instance.new("ScrollingFrame")
				local OptionHolderL = Instance.new("UIListLayout")
				local DDHC = Instance.new("UICorner")

				DropDown.Name = "DropDown"
				DropDown.Parent = Section
				DropDown.BackgroundColor3 = theme.accent
				DropDown.BorderSizePixel = 0
				DropDown.ClipsDescendants = true
				DropDown.Position = UDim2.new(0.0204359666, 0, 0.0790190771, 0)
				DropDown.Size = UDim2.new(0, 352, 0, 33)
				DropDown.AutoButtonColor = false
				DropDown.Font = Enum.Font.GothamMedium
				DropDown.Text = name
				DropDown.TextColor3 = theme.textcolor
				DropDown.TextSize = 13.000
				DropDown.TextTransparency = 1

				DropDownC.CornerRadius = UDim.new(0, 3)
				DropDownC.Name = "DropDownC"
				DropDownC.Parent = DropDown

				Search.Name = "Search"
				Search.Parent = DropDown
				Search.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Search.BackgroundTransparency = 1.000
				Search.BorderColor3 = Color3.fromRGB(27, 42, 53)
				Search.BorderSizePixel = 0
				Search.Size = UDim2.new(0, 304, 0, 33)
				Search.Font = Enum.Font.GothamMedium
				Search.Text = name
				Search.TextColor3 = theme.textcolor
				Search.TextSize = 13.000
				Search.TextXAlignment = Enum.TextXAlignment.Left

				SearchP.Name = "SearchP"
				SearchP.Parent = Search
				SearchP.PaddingLeft = UDim.new(0, 6)

				Arrow.Name = "Arrow"
				Arrow.Parent = DropDown
				Arrow.BackgroundTransparency = 1.000
				Arrow.BorderSizePixel = 0
				Arrow.ClipsDescendants = true
				Arrow.Position = UDim2.new(1.00139761, -28, 0.303030312, -9)
				Arrow.Rotation = 90.000
				Arrow.Size = UDim2.new(0, 23, 0, 31)
				Arrow.ZIndex = 1
				Arrow.Image = "rbxassetid://5012539403"
				Arrow.SliceCenter = Rect.new(2, 2, 298, 298)
				Arrow.ImageColor3 = theme.textcolor

				DropDownHolder.Name = "DropDownHolder "..name
				DropDownHolder.Parent = Section
				DropDownHolder.BackgroundColor3 = Color3.fromRGB(36, 37, 41)
				DropDownHolder.BorderSizePixel = 0
				DropDownHolder.ClipsDescendants = true
				DropDownHolder.Position = UDim2.new(0.0204359666, 0, 0.398406386, 0)
				DropDownHolder.Size = UDim2.new(0, 352, 0, 0)
				DropDownHolder.Visible = false

				OptionHolder.Name = "OptionHolder"
				OptionHolder.Parent = DropDownHolder
				OptionHolder.Active = true
				OptionHolder.BackgroundColor3 = Color3.fromRGB(36, 37, 41)
				OptionHolder.BorderSizePixel = 0
				OptionHolder.Position = UDim2.new(0, 0, 0.0413798429, 0)
				OptionHolder.Size = UDim2.new(0, 351, 0, 146)
				OptionHolder.CanvasSize = UDim2.new(0, 0, 0, 0)
				OptionHolder.ScrollBarThickness = 0

				OptionHolderL.Name = "OptionHolderL"
				OptionHolderL.Parent = OptionHolder
				OptionHolderL.HorizontalAlignment = Enum.HorizontalAlignment.Center
				OptionHolderL.SortOrder = Enum.SortOrder.LayoutOrder
				OptionHolderL.Padding = UDim.new(0, 5)

				DDHC.CornerRadius = UDim.new(0, 3)
				DDHC.Name = "DDHC"
				DDHC.Parent = DropDownHolder

                local selected = {}
				local selectedtext
				local funcs = {}

				Search:GetPropertyChangedSignal("Text"):connect(function()
					Search.TextXAlignment = Search.TextFits and Enum.TextXAlignment.Left or Enum.TextXAlignment.Right
				end)

				local function showall()
					for i,v in next, OptionHolder:GetChildren() do
						if v:IsA("TextButton") and v.Name == "Option" then 
							v.Visible = true
						end
					end
				end
				
                local function search(text)
					if text == ""  then
						showall()
					end
					for i,v in next, OptionHolder:GetChildren() do
						if v:IsA("TextButton") and v.Name == "Option" then
							if v.Text:lower():match(text:lower()) then
								v.Visible = true
							else
								v.Visible = false
							end
						end
					end
				end

				local isopen = false
				local function opendd()
					isopen = not isopen
					if isopen then
						DropDownHolder.Visible = true
					end
					Arrow.Rotation = isopen and 0 or 90
					DropDownHolder:TweenSize(UDim2.new(0, 352,0, (isopen and 153 or 0)),"Out","Sine",0.3,false)
					task.wait(0.3)
					if not isopen then
						DropDownHolder.Visible = false
					end
				end
			
			    local IsSearching = false
                Search.Focused:Connect(function()
					if not isopen then opendd() end
					if Search.Text == name then return end
					IsSearching = true
                end)

				Search.FocusLost:Connect(function()
					if Search.Text == "" and #selected < 1 then
						Search.Text = name
					end
					if #selected > 0 then
						Search.Text = selectedtext
					end
				end)
				
                Search:GetPropertyChangedSignal("Text"):Connect(function()
					if not isopen then return end
					if Search.Text == name then return end
					if Search.Text == selectedtext then return end 
					if not IsSearching then return end
					search(Search.Text)
                end)

				Arrow.MouseButton1Click:Connect(function()
				    showall()
					opendd()
				end)

				OptionHolderL:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
					OptionHolder.CanvasSize = UDim2.new(0, 0, 0, OptionHolderL.AbsoluteContentSize.Y + 10)
				end)

				local current

				funcs.AddOption = function(self,text)
					local Option = Instance.new("TextButton")
					local BtnC = Instance.new("UICorner")

					Option.Name = "Option"
					Option.Parent = OptionHolder
					Option.BackgroundColor3 = theme.accentsecondary
					Option.BorderSizePixel = 0
					Option.Position = UDim2.new(0.00997150969, 0, 0, 0)
					Option.Size = UDim2.new(0, 344, 0, 31)
					Option.AutoButtonColor = false
					Option.Font = Enum.Font.GothamMedium
					Option.Text = text
					Option.TextColor3 = theme.textcolor
					Option.TextSize = 13.000

					BtnC.CornerRadius = UDim.new(0, 3)
					BtnC.Name = "BtnC"
					BtnC.Parent = Option

					Option.MouseButton1Click:Connect(function()
						if library.locked then return end
						if not table.find(selected,Option.Text) then
							table.insert(selected,Option.Text)
							Option.TextColor3 = Color3.fromRGB(0, 101, 195)
						elseif table.find(selected,Option.Text) then
							Option.TextColor3 = Color3.fromRGB(225,225,225)
							table.remove(selected,table.find(selected,Option.Text))
						end
						callback(selected)
						library.flags[flag] = selected
						if not selected[1] then
							Search.Text = name
							return
						end
    					Search.Text = "Selected: "
    					for i,v in next, selected do
    						if i == 1 then
    							Search.Text = Search.Text..v
    						else
    							Search.Text = Search.Text..", "..v
    						end
    					end
						if #selected > 0 then 
							selectedtext = Search.Text
						end
                        showall()
						IsSearching = false
					end)
				end

				funcs.SetList = function(self,options)
					for i,v in next, OptionHolder:GetChildren() do
						if v:IsA("TextButton") and v.Name == "Option" then
							v:Destroy()
						end
					end
					for i,v in next, options do
						funcs:AddOption(v)
					end
				end

				funcs.RemoveOption = function(self,name)
					for i,v in next, OptionHolder:GetChildren() do
						if v:IsA("TextButton") and v.Name == "Option" then
							if v.Text == name then
								v:Destroy()
							end
						end
					end
				end
				funcs:SetList(options)
				return funcs
			end

			function Holder:Separator()
				local SplitBack = Instance.new("Frame")
				local BtnC = Instance.new("UICorner")
				local SplitBar = Instance.new("TextButton")
				local BtnC_2 = Instance.new("UICorner")

				SplitBack.Name = "SplitBack"
				SplitBack.Parent = Section
				SplitBack.BackgroundColor3 = theme.accent
				SplitBack.BackgroundTransparency = 1.000
				SplitBack.BorderSizePixel = 0
				SplitBack.Position = UDim2.new(0.0204359666, 0, 0.405046493, 0)
				SplitBack.Size = UDim2.new(0, 352, 0, 17)

				BtnC.CornerRadius = UDim.new(0, 3)
				BtnC.Name = "BtnC"
				BtnC.Parent = SplitBack

				SplitBar.Name = "SplitBar"
				SplitBar.Parent = SplitBack
				SplitBar.BackgroundColor3 = Color3.fromRGB(36, 37, 40)
				SplitBar.BorderSizePixel = 0
				SplitBar.Position = UDim2.new(0, 0, 0.405047238, 0)
				SplitBar.Size = UDim2.new(0, 352, 0, 5)
				SplitBar.AutoButtonColor = false
				SplitBar.Font = Enum.Font.GothamMedium
				SplitBar.Text = ""
				SplitBar.TextColor3 = Color3.fromRGB(255, 255, 255)
				SplitBar.TextSize = 13.000

				BtnC_2.CornerRadius = UDim.new(0, 3)
				BtnC_2.Name = "BtnC"
				BtnC_2.Parent = SplitBar
			end

			function Holder:ColorPicker(name,default,callback)
				local callback = callback or function() end
				local flag = name
				local default = default or Color3.fromRGB(225,225,225)
				assert(name,"a name is required to create a color picker")

				local ColorPicker = Instance.new("TextButton")
				local ColorPickerC = Instance.new("UICorner")
				local SelectedColor = Instance.new("TextButton")
				local SelectedColorC = Instance.new("UICorner")

				ColorPicker.Name = "ColorPicker"
				ColorPicker.Parent = Section
				ColorPicker.BackgroundColor3 = theme.accent
				ColorPicker.BorderSizePixel = 0
				ColorPicker.Position = UDim2.new(0.0204359666, 0, 0.0790190771, 0)
				ColorPicker.Size = UDim2.new(0, 352, 0, 33)
				ColorPicker.AutoButtonColor = false
				ColorPicker.Font = Enum.Font.GothamMedium
				ColorPicker.Text = "  "..name
				ColorPicker.TextColor3 = theme.textcolor
				ColorPicker.TextSize = 13.000
				ColorPicker.TextXAlignment = Enum.TextXAlignment.Left

				ColorPickerC.CornerRadius = UDim.new(0, 3)
				ColorPickerC.Name = "ColorPickerC"
				ColorPickerC.Parent = ColorPicker

				SelectedColor.Name = "SelectedColor"
				SelectedColor.Parent = ColorPicker
				SelectedColor.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				SelectedColor.BorderSizePixel = 0
				SelectedColor.Position = UDim2.new(0.81645447, 0, 0.200302571, 0)
				SelectedColor.Size = UDim2.new(0, 54, 0, 18)
				SelectedColor.ZIndex = 3
				SelectedColor.AutoButtonColor = false
				SelectedColor.Font = Enum.Font.GothamMedium
				SelectedColor.Text = ""
				SelectedColor.TextColor3 = default
				SelectedColor.TextSize = 12.000

				SelectedColorC.CornerRadius = UDim.new(0, 4)
				SelectedColorC.Name = "SelectedColorC"
				SelectedColorC.Parent = SelectedColor

				--~ColorPickerFrame~--

				local ColorPickerFrame = Instance.new("Frame")
				local CPFC = Instance.new("UICorner")
				local SubmitBtn = Instance.new("TextButton")
				local ButtonUICorner = Instance.new("UICorner")
				local InputR = Instance.new("TextBox")
				local IGNORE = Instance.new("UICorner")
				local InputG = Instance.new("TextBox")
				local IGNORE_2 = Instance.new("UICorner")
				local InputB = Instance.new("TextBox")
				local IGNORE_3 = Instance.new("UICorner")
				local saturation = Instance.new("ImageLabel")
				local IGNORE_4 = Instance.new("UICorner")
				local saturationpicker = Instance.new("Frame")
				local IGNORE_5 = Instance.new("UICorner")
				local outline = Instance.new("Frame")
				local IGNORE_6 = Instance.new("UICorner")
				local huef = Instance.new("ImageLabel")
				local IGNORE_7 = Instance.new("UICorner")
				local huepicker = Instance.new("Frame")
				local Title = Instance.new("TextLabel")

				ColorPickerFrame.Name = "ColorPickerFrame"
				ColorPickerFrame.Parent = Main
				ColorPickerFrame.BackgroundColor3 = theme.main
				ColorPickerFrame.BorderColor3 = Color3.fromRGB(42, 42, 42)
				ColorPickerFrame.BorderSizePixel = 0
				ColorPickerFrame.Position = UDim2.new(1.01471806, 0, 0.23381938, 0)
				ColorPickerFrame.Size = UDim2.new(0, 208, 0, 197)
				ColorPickerFrame.Visible = false

				CPFC.CornerRadius = UDim.new(0, 5)
				CPFC.Name = "CPFC"
				CPFC.Parent = ColorPickerFrame

				SubmitBtn.Name = "SubmitBtn"
				SubmitBtn.Parent = ColorPickerFrame
				SubmitBtn.BackgroundColor3 = theme.accent
				SubmitBtn.BorderSizePixel = 0
				SubmitBtn.Position = UDim2.new(0.057692308, 0, 0.838497579, 0)
				SubmitBtn.Size = UDim2.new(0, 189, 0, 24)
				SubmitBtn.AutoButtonColor = false
				SubmitBtn.Font = Enum.Font.Gotham
				SubmitBtn.Text = "Submit"
				SubmitBtn.TextColor3 = theme.textcolor
				SubmitBtn.TextSize = 12.000

				ButtonUICorner.CornerRadius = UDim.new(0, 3)
				ButtonUICorner.Name = "ButtonUICorner"
				ButtonUICorner.Parent = SubmitBtn

				InputR.Name = "InputR"
				InputR.Parent = ColorPickerFrame
				InputR.BackgroundColor3 = theme.accent
				InputR.ClipsDescendants = true
				InputR.Position = UDim2.new(0.0192307699, 8, 0.852791846, -24)
				InputR.Size = UDim2.new(0, 58, 0, 16)
				InputR.ZIndex = 4
				InputR.Font = Enum.Font.GothamMedium
				InputR.PlaceholderText = "R"
				InputR.Text = ""
				InputR.TextColor3 = theme.textcolor
				InputR.TextSize = 11.000

				IGNORE.CornerRadius = UDim.new(0, 4)
				IGNORE.Name = "IGNORE"
				IGNORE.Parent = InputR

				InputG.Name = "InputG"
				InputG.Parent = ColorPickerFrame
				InputG.BackgroundColor3 = theme.accent
				InputG.ClipsDescendants = true
				InputG.Position = UDim2.new(0.0544230789, 66, 0.85307616, -24)
				InputG.Size = UDim2.new(0, 58, 0, 16)
				InputG.ZIndex = 4
				InputG.Font = Enum.Font.GothamMedium
				InputG.PlaceholderText = "G"
				InputG.Text = ""
				InputG.TextColor3 = theme.textcolor
				InputG.TextSize = 11.000

				IGNORE_2.CornerRadius = UDim.new(0, 4)
				IGNORE_2.Name = "IGNORE"
				IGNORE_2.Parent = InputG

				InputB.Name = "InputB"
				InputB.Parent = ColorPickerFrame
				InputB.BackgroundColor3 = theme.accent
				InputB.ClipsDescendants = true
				InputB.Position = UDim2.new(0.0913461521, 124, 0.852791905, -24)
				InputB.Size = UDim2.new(0, 58, 0, 16)
				InputB.ZIndex = 4
				InputB.Font = Enum.Font.GothamMedium
				InputB.PlaceholderText = "B"
				InputB.Text = ""
				InputB.TextColor3 = theme.textcolor
				InputB.TextSize = 11.000

				IGNORE_3.CornerRadius = UDim.new(0, 4)
				IGNORE_3.Name = "IGNORE"
				IGNORE_3.Parent = InputB

				saturation.Name = "saturation"
				saturation.Parent = ColorPickerFrame
				saturation.BackgroundColor3 = Color3.fromRGB(255, 0, 4)
				saturation.Position = UDim2.new(0, 12, 0, 29)
				saturation.Size = UDim2.new(0, 158, 0, 105)
				saturation.ZIndex = 2
				saturation.Image = "rbxassetid://8630797271"

				IGNORE_4.CornerRadius = UDim.new(0, 4)
				IGNORE_4.Name = "IGNORE"
				IGNORE_4.Parent = saturation

				saturationpicker.Name = "saturationpicker"
				saturationpicker.Parent = saturation
				saturationpicker.BackgroundColor3 = theme.textcolor
				saturationpicker.BorderColor3 = Color3.fromRGB(0, 0, 0)
				saturationpicker.Position = UDim2.new(0, 20, 0, 20)
				saturationpicker.Size = UDim2.new(0, 4, 0, 4)

				IGNORE_5.CornerRadius = UDim.new(0, 12)
				IGNORE_5.Name = "IGNORE"
				IGNORE_5.Parent = saturationpicker
				outline.BorderColor3 = Color3.fromRGB(225, 225, 225)

				outline.Name = "outline"
				outline.Parent = saturationpicker
				outline.BackgroundColor3 = theme.textcolor
				outline.Position = UDim2.new(0, -1, 0, -1)
				outline.Size = UDim2.new(0, 6, 0, 6)
				outline.ZIndex = 0

				IGNORE_6.CornerRadius = UDim.new(0, 12)
				IGNORE_6.Name = "IGNORE"
				IGNORE_6.Parent = outline

				huef.Name = "huef"
				huef.Parent = ColorPickerFrame
				huef.BackgroundColor3 = Color3.fromRGB(255, 0, 4)
				huef.BackgroundTransparency = 1.000
				huef.Position = UDim2.new(0.966346145, -24, 0.00137298123, 30)
				huef.Size = UDim2.new(0, 16, 0, 104)
				huef.Image = "rbxassetid://8630799159"
				huef.ScaleType = Enum.ScaleType.Crop

				IGNORE_7.CornerRadius = UDim.new(0, 4)
				IGNORE_7.Name = "IGNORE"
				IGNORE_7.Parent = huef

				huepicker.Name = "huepicker"
				huepicker.Parent = huef
				huepicker.BackgroundColor3 = theme.textcolor
				huepicker.Position = UDim2.new(0, 0, 0, 20)
				huepicker.Size = UDim2.new(1, 0, 0, 2)

				Title.Name = "Title"
				Title.Parent = ColorPickerFrame
				Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Title.BackgroundTransparency = 1.000
				Title.Position = UDim2.new(0, 0, 0.0253807101, 0)
				Title.Size = UDim2.new(0, 208, 0, 17)
				Title.Font = Enum.Font.GothamBold
				Title.Text = "   "..name
				Title.TextColor3 = theme.textcolor
				Title.TextSize = 14.000
				Title.TextXAlignment = Enum.TextXAlignment.Left

				local isopen = false
				local function openpicker()
					isopen = not isopen
					ColorPickerFrame.Visible = isopen and true or false
				end

				SelectedColor.MouseButton1Click:Connect(function()
					if library.locked then return end
					openpicker()
				end)

				SubmitBtn.MouseButton1Click:Connect(function()
					openpicker()
				end)

				local hue, sat, val = default:ToHSV()
				local slidingHue = false
				local slidingSaturation = false
				local hsv = Color3.fromHSV(hue, sat, val)

				local function updatehue(input)
					local sizeY = 1 - math.clamp((input.Position.Y - huef.AbsolutePosition.Y) / huef.AbsoluteSize.Y, 0, 1)
					local posY = math.clamp(((input.Position.Y - huef.AbsolutePosition.Y) / huef.AbsoluteSize.Y) * huef.AbsoluteSize.Y, 0, huef.AbsoluteSize.Y - 2)
					huepicker.Position = UDim2.new(0, 0, 0, posY)

					hue = sizeY
					hsv = Color3.fromHSV(sizeY, sat, val)

					InputR.Text = "R: "..math.clamp(math.floor(hsv.R * 255), 0, 255)
					InputG.Text = "G: "..math.clamp(math.floor(hsv.G * 255), 0, 255)
					InputB.Text = "B: "..math.clamp(math.floor(hsv.B * 255), 0, 255)

					saturation.BackgroundColor3 = hsv
					SelectedColor.BackgroundColor3 = hsv
					library.flags[flag] = Color3.fromRGB(hsv.r * 255, hsv.g * 255, hsv.b * 255)
					callback(Color3.fromRGB(hsv.r * 255, hsv.g * 255, hsv.b * 255))	
				end

				huef.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						slidingHue = true
						updatehue(input)
					end
				end)

				huef.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						slidingHue = false
					end
				end)

				game.UserInputService.InputChanged:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseMovement then
						if slidingHue then
							updatehue(input)
						end
					end
				end)

				local function updatesatval(input)
					local sizeX = math.clamp((input.Position.X - saturation.AbsolutePosition.X) / saturation.AbsoluteSize.X, 0, 1)
					local sizeY = 1 - math.clamp((input.Position.Y - saturation.AbsolutePosition.Y) / saturation.AbsoluteSize.Y, 0, 1)
					local posY = math.clamp(((input.Position.Y - saturation.AbsolutePosition.Y) / saturation.AbsoluteSize.Y) * saturation.AbsoluteSize.Y, 0, saturation.AbsoluteSize.Y - 4)
					local posX = math.clamp(((input.Position.X - saturation.AbsolutePosition.X) / saturation.AbsoluteSize.X) * saturation.AbsoluteSize.X, 0, saturation.AbsoluteSize.X - 4)

					saturationpicker.Position = UDim2.new(0, posX, 0, posY)

					sat = sizeX
					val = sizeY
					hsv = Color3.fromHSV(hue, sizeX, sizeY)

					InputR.Text = "R: "..math.clamp(math.floor(hsv.R * 255), 0, 255)
					InputG.Text = "G: "..math.clamp(math.floor(hsv.G * 255), 0, 255)
					InputB.Text = "B: "..math.clamp(math.floor(hsv.B * 255), 0, 255)

					SelectedColor.BackgroundColor3 = hsv

					library.flags[flag] = Color3.fromRGB(hsv.r * 255, hsv.g * 255, hsv.b * 255)
					callback(Color3.fromRGB(hsv.r * 255, hsv.g * 255, hsv.b * 255))	
				end

				saturation.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						slidingSaturation = true
						updatesatval(input)
					end
				end)

				saturation.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						slidingSaturation = false
					end
				end)

				game.UserInputService.InputChanged:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseMovement then
						if slidingSaturation then
							updatesatval(input)
						end
					end
				end)

				local function set(color)
					if type(color) == "table" then
						color = Color3.fromRGB(unpack(color))
					end

					hue, sat, val = color:ToHSV()
					hsv = Color3.fromHSV(hue, sat, val)

					SelectedColor.BackgroundColor3 = hsv
					saturation.BackgroundColor3 = hsv
					saturationpicker.Position = UDim2.new(0, (math.clamp(sat * saturation.AbsoluteSize.X, 0, saturation.AbsoluteSize.X - 4)), 0, (math.clamp((1 - val) * saturation.AbsoluteSize.Y, 0, saturation.AbsoluteSize.Y - 4)))
					huepicker.Position = UDim2.new(0, 0, 0, math.clamp((1 - hue) * saturation.AbsoluteSize.Y, 0, saturation.AbsoluteSize.Y - 4))

					InputR.Text = "R: "..math.clamp(math.floor(hsv.R * 255), 0, 255)
					InputG.Text = "G: "..math.clamp(math.floor(hsv.G * 255), 0, 255)
					InputB.Text = "B: "..math.clamp(math.floor(hsv.B * 255), 0, 255)
					library.flags[flag] = Color3.fromRGB(hsv.r * 255, hsv.g * 255, hsv.b * 255)
					callback(Color3.fromRGB(hsv.r * 255, hsv.g * 255, hsv.b * 255))
				end

				set(default)

				local funcs = {}

				funcs.SetColor = function(self,color)
					set(color)
				end
				return funcs
			end
			return Holder
		end
		return section
	end
	return tab
end
repeat task.wait() until game:IsLoaded()

local UI = library:Create("10585839014") -- Roblox ID for the image you uploaded
local Tab
local Section
local PLY = false
local GroupSelect = false
local gkey = math.random(-10000000, 10000000)
local cf = nil
---~Requirements~---

local Requirements = {
    Vars = {	
        OldPos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame,
        HRP = game.Players.LocalPlayer.Character.HumanoidRootPart,
        Char = game.Players.LocalPlayer.Character,
        PlrTorso = game.Players.LocalPlayer.Character.Torso,
        Head = game.Players.LocalPlayer.Character.Head,
        RootJoints = game.Players.LocalPlayer.Character.HumanoidRootPart.RootJoint,
        Mouse = game.Players.LocalPlayer:GetMouse(),
		boxSizeX = "",
		boxSizeY = "",
		boxType ="",
		sortBoxesButton="",
        UIS = game:GetService("UserInputService"),
        AxeClassesFolder = game:GetService("ReplicatedStorage").AxeClasses,
        OldPurchase = getsenv(game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("PropertyPurchasingGUI"):WaitForChild("PropertyPurchasingClient")).enterPurchaseMode,
        Loadsenv = getupvalue(getsenv(game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("LoadSaveGUI"):WaitForChild("LoadSaveClient")).saveSlot, 12),
        FloatOld = getsenv(game:GetService("Players").LocalPlayer.PlayerGui.Scripts.CharacterFloat).isInWater,
        WS = getsenv(game.Players.LocalPlayer.PlayerGui.ItemDraggingGUI.Dragger),
        DraggerOld = getsenv(game:GetService'Players'.LocalPlayer.PlayerGui.ItemDraggingGUI.Dragger).otherDraggable,
        DraggerOld2 = getsenv(game:GetService'Players'.LocalPlayer.PlayerGui.ItemDraggingGUI.Dragger).canDrag,
    },
    Tables = {
        characters = {},
		TeleportItemType = {"Tool","Gift","Loose Item","Wire"},
		BToolsT = {"Move", "Undo", "Identify", "Delete"},
        EmptyPlots = {},
		sortItems = {},
        AllItems = {},
        ShopItems = {"Rukiryaxe"},
        AutoBuyInfo = {},
        AvailableTrees = {},
        SelectedBluePrints = {},
        CandyTypes = {},
		ToSawmill = {},
		BluePrints = {},
		TreesIDs = {},
		AllIDS = {},
		PlayerTable16a = {},
		BaseNames = {},
		WoodList  = {"Oak", "Generic", "Cherry", "Birch", "Volcano", "GoldSwampy", "GreenSwampy", "Walnut", "Palm", "Fir", "Pine", "SnowGlow", "Frost", "Koa", "CaveCrawler", "LoneCave", "Spooky","SpookyNeon", "BlueSpruce"},  	
		ShopIds = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/ErnestlinBuild/scripts/main/Shoplist"))(),
        Perms = {"Visit","PlaceStructure","MoveStructure","Destroy","Drive","Sit","Interact","Grab","Save"},
        LandVec = {Vector3.new(-40,0,0),Vector3.new(-40,0,-40),Vector3.new(0,0,-40),Vector3.new(40,0,-40),Vector3.new(40,0,0),Vector3.new(40,0,40),Vector3.new(0,0,40),Vector3.new(-40,0,40),Vector3.new(-80,0,40),Vector3.new(-80,0,0),Vector3.new(-80,0,-40),Vector3.new(-80,0,-80),Vector3.new(-40,0,-80),Vector3.new(0,0,-80),Vector3.new(40,0,-80),Vector3.new(80,0,-80), Vector3.new(80,0,-40),Vector3.new(80,0,0),Vector3.new(80,0,40),Vector3.new(80,0,80),Vector3.new(40,0,80),Vector3.new(0,0,80),Vector3.new(-40,0,80),Vector3.new(-80,0,80)},
        WaypointsPositions = {["The Den"] = CFrame.new(323, 49, 1930), ["Lighthouse"] = CFrame.new(1464.8, 356.3, 3257.2), ["Safari"] = CFrame.new(111.853, 11.0005, -998.805), ["Bridge"] = CFrame.new(112.308, 11.0005, -782.358), ["Bob's Shack"] = CFrame.new(260, 8, -2542), ["EndTimes Cave"] = CFrame.new(113, -214, -951), ["The Swamp"] = CFrame.new(-1209, 132, -801), ["The Cabin"] = CFrame.new(1244, 66, 2306), ["Volcano"] = CFrame.new(-1585, 625, 1140), ["Boxed Cars"] = CFrame.new(509, 5.2, -1463), ["Tiaga Peak"] = CFrame.new(1560, 410, 3274), ["Land Store"] = CFrame.new(258, 5, -99), ["Link's Logic"] = CFrame.new(4605, 3, -727), ["Palm Island"] = CFrame.new(2549, -5, -42), ["Palm Island 2"] = CFrame.new(1941.58, -5.9, -1494.32), ["Fine Art Shop"] = CFrame.new(5207, -166, 719), ["SnowGlow Biome"] = CFrame.new(-1086.85, -5.89978, -945.316), ["Cave"] = CFrame.new(3581, -179, 430), ["Shrine Of Sight"] = CFrame.new(-1600, 195, 919), ["Fancy Furnishings"] = CFrame.new(491, 13, -1720), ["Docks"] = CFrame.new(1114, 3.2, -197), ["Strange Man"] = CFrame.new(1061, 20, 1131), ["Wood Dropoff"] = CFrame.new(323.406, -2.8, 134.734), ["Snow Biome"] = CFrame.new(889.955, 59.7999, 1195.55), ["Wood RUs"] = CFrame.new(265, 5, 57), ["Green Box"] = CFrame.new(-1668.05, 351.174, 1475.39), ["Spawn"] = CFrame.new(172, 2, 74), ["Cherry Meadow"] = CFrame.new(220.9, 59.8, 1305.8), ["Bird Cave"] = CFrame.new(4813.1, 33.5, -978.8),},
        UIVars = {CST, AD, AN, AWL, ABL, GSTB, ABB},
    },
    Config = {
        Walkspeed = 16,
        JumpPower = 50,
		WoodType = "",
        InfJump = false,
		SprintSpeed = 50,
		standingWoodz = false, 
        SprintKey = "LeftShift",
        FlyKey = "F",
        FlySpeed = 200,
        NoClipKey = "N",
        TeleportKey = "G",
        VehiclePitch = 0.5,
        DragMod  = false,
        AntiAFK = false,
        AlwaysDay = false,
        AlwaysNight = false,
        NoFog = false,
        Spook = false,
        Float = true,
        SolidWater = false,
        RemoveWater = false,
        FastLoad = false,
        MaxRange = 50,
		ChopColor = Color3.fromRGB(0,0,0),
		VehicleSpeed = 1,
		HideUI = "RightShift",
		UIMode = true, 
		TeleportItemsin = false,
		Teleportplksin = false,
		AutoSaveConfig = false,
		FastCheckout = false,	
		SingleSelect = false,
		AlwaysDay = false,
		Autofill = false
    },
    Booleans = {
        isFlying = false,
        isClipping = false,	
        Flying  = false,
        ClaimShopItems = false,
		AbortFiler = false,
        SpamFireWorks = false,
        PlateFound = false,
        DoorFound = false,
        CarSpawner = false,
        AbortAutoBuy = false,
        IsBuying = false,
        AbortDupeInventory = false,
        LoopDupeInventory = false,
        TreeCutDown = false,
        IsChopping = false,
        AbortGetTree = false,
        PickedUpSpawnedAxe = false,
        LogAutoChopped = false,
        LogSawmilled = false,
        AbortPaint = false,
        ExcludeRareCandy = false,
        ClaimTrees = false,
        ClearShopItems = false,
        DestroyPads = false,
		LoopAutoBuy = false,
		LoopGetTree = false,
		UnitCutter = false,
		OwnerShip = false,
		AutoFarm = false,
    },
    Strings = {
        CandyType = "BagOfCandy",
        CandyAction = "Open Boxed Candy",
		SelectedTree = nil,
		target = nil,
        HighestSawmillPrice = 0,
        SelectedPaintColor = nil,
        AutoCutTarget = nil,
		Endselection = nil,
        BestSawmill = nil,
        RequiredWood = 1,
        Count = 0,
        Count2 = 0,
		WoodPlayer = nil,
        AxeDupeAmount = 1,
        Temp = nil,
		Wood  = nil,
        TModel = nil,
        Hum_Clone = nil,
        AntiBLClone = nil,
        FlingInstance = nil,
        FlingInstance2 = nil,
        LightInstance = nil,
        AnnoyTarget = nil,
        AnnoyAction = nil,
        SelectedTool = nil,
        BPOldPos = nil,	
        SelectedTreeToGet = {},
        ThrowPos = nil,
        SelectedCarColor = nil,
        PaintPart = nil,
        Range = nil,
        AutoBuyItem = {},
        GetTreeAmount = 1,
        AxeRotation = 0,
        AutoBuyAmount = 1,
        SlotNumber = 1,
        ClickedPart = nil,
		clickeditm = nil,
	    clickedplk = nil,
		Time = 0,
		ItemToBuy = nil,
		StoreCounter = nil,
		TreeToGet = nil,
		TreeToJointCut = nil,
		PLY = nil,
		TreesToFarm = {},
		DupeSlot = 1,
    },
    Connections = {
		GroupSelect = nil,
        InfJump = nil,
        NoClip = nil,
        Idling = nil,
        ToolAdded = nil,
        AxeFling = nil,
        RukirySpawned = nil,
        WLPlayerAdded = nil,
        BLPlayerAdded = nil,
        SelectPads = nil,
		SelectItem = nil,	
        WaitingForCar = nil,
        BluePrintAdded = nil,
        Ingredients = nil,
        TreeAdded = nil,
        AutoCut = nil,
        AutoCutTreeAdded = nil,
        PlankAdded = nil,
        BlueprintFilled = nil,
        ClickToSelectBP = nil,
		ClickToGetUnits = nil,
		PlankReAdded = nil,
		UnitCutterClick = nil,
		ClickToSellC = nil,
		getItems = nil,
		boxSortPosition = nil,
		placeBoxSort = nil,
		placeBoxSort = nil,
		AutoSawmillC = nil,
		TJC = nil, 
    },
    Funcs = {},
}

Requirements.Funcs.Config = function()

	if not isfile("ErnestlinV2Config.txt") then
		writefile("ErnestlinV2Config.txt", game:GetService("HttpService"):JSONEncode(Requirements.Config))
	else
		Requirements.Config = game:GetService("HttpService"):JSONDecode(readfile("ErnestlinV2Config.txt"))
	end	
end
Requirements.Funcs.Config()

Requirements.Funcs.Teleport = function(Pos)
    repeat task.wait() until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if game.Players.LocalPlayer.Character.Humanoid.SeatPart and game.Players.LocalPlayer.Character.Humanoid.SeatPart.Name == "DriveSeat" then
        if typeof(Pos) == "Vector3" then
            Pos = CFrame.new(Pos)
        end
        game.Players.LocalPlayer.Character.Humanoid.SeatPart.Parent:PivotTo(Pos)
    else
        if typeof(Pos) == "CFrame" then
            game:GetService"Players".LocalPlayer.Character:PivotTo(Pos)
        elseif typeof(Pos) == "Vector3" then
            game:GetService"Players".LocalPlayer.Character:MoveTo(Pos)
        end
    end
end
Requirements.Funcs.CloneTP = function(Val,Pos)
    if Val == true then
        task.spawn(function()
            game.Players.LocalPlayer.Character.Archivable = true
            Requirements.Strings.TModel = Instance.new("Model")
            Requirements.Strings.Hum_Clone = game.Players.LocalPlayer.Character.HumanoidRootPart:Clone()
            Requirements.Strings.TModel.Parent = game:GetService("Workspace")
            Requirements.Strings.Temp = game.Players.LocalPlayer.Character:Clone()
            Requirements.Strings.Temp.Parent = game:GetService("Workspace")
            Requirements.Strings.Temp.Humanoid.DisplayName = " "
            game:GetService("Workspace").CurrentCamera.CameraSubject = Requirements.Strings.Temp.Head
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Pos
            wait(.1)
            Requirements.Vars.HRP.Parent = Requirements.Strings.TModel
            Requirements.Strings.Hum_Clone.Parent = game.Players.LocalPlayer.Character
            game:GetService("Workspace").CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Head
            Requirements.Strings.Temp:Destroy()
        end)
        else
        if Val == false then
            Requirements.Vars.HRP.Parent = game.Players.LocalPlayer.Character
            Requirements.Strings.Hum_Clone:Destroy()
            Requirements.Strings.TModel:Destroy()
        end
    end
end
Requirements.Funcs.TeleportItem = function(Model,Amount,Pos)
    for i = 1,Amount do
        game.ReplicatedStorage.Interaction.ClientIsDragging:FireServer(Model)
        Model:PivotTo(Pos)
        task.wait()
    end
end
Requirements.Funcs.PlrTransparency = function(Value)
    for i,v in next, game.Players.LocalPlayer.Character:getChildren() do
        if v:IsA("Part") and v.Name ~= "HumanoidRootPart" then
            v.Transparency = Value
        end
    end
end

Requirements.Funcs.SetSlotTo = function(v)
    if Requirements.Vars.Loadsenv and typeof(Requirements.Vars.Loadsenv) == "number" then
        game:GetService("Players").LocalPlayer.CurrentSaveSlot.Set:Invoke(v, Requirements.Vars.Loadsenv)
    end
end

Requirements.Funcs.GetPlot = function(Plr)
    for i,v in next, game:GetService("Workspace").Properties:GetChildren() do
        if v:FindFirstChild("Owner") and tostring(v.Owner.Value) == Plr then
            return v
        end
    end
end

Requirements.Funcs.GetPlots = function()
    Requirements.Tables.EmptyPlots = {}
    for i,v in next,game:GetService("Workspace").Properties:GetChildren() do
        if v:FindFirstChild("Owner") and v.Owner.Value == nil then
            table.insert(Requirements.Tables.EmptyPlots,v)
        end
    end
    return Requirements.Tables.EmptyPlots[#Requirements.Tables.EmptyPlots]
end

Requirements.Funcs.SetPerms = function(Value)
    for i,v in pairs(game:GetService("Players"):GetChildren()) do
        if v.Name ~= game.Players.LocalPlayer.Name then
            for i2,v2 in next, Requirements.Tables.Perms do
                game:GetService("ReplicatedStorage").Interaction.UpdateUserSettings:FireServer("UserPermission",v.UserId,v2,Value)
            end
        end
    end
end

Requirements.Funcs.GetPing = function()
    Requirements.Strings.Time = tick()
    game:GetService"ReplicatedStorage".TestPing:InvokeServer()
    return ((tick() - Requirements.Strings.Time) / 2) + 0.5
end

Requirements.Funcs.CheckOwnerShip = function(Part)
    Requirements.Booleans.OwnerShip = isnetworkowner or is_network_owner
    if Requirements.Booleans.OwnerShip(Part) then
        return true
    end
    return false
end

Requirements.Funcs.GetTotalPrice = function(Items,Amount)
    Requirements.Strings.Price = 0
    if typeof(Items) ~= "table" then
        Items = {Items}
    end
    for i,v in next, Items do
		Requirements.Strings.Price = Requirements.Strings.Price + game:GetService"ReplicatedStorage".ClientItemInfo[v]:FindFirstChild("Price").Value * Amount
    end
    return Requirements.Strings.Price
end

Requirements.Funcs.GetShopItems = function() -- does not use the correct item names
    for i,v in next,game:GetService("Workspace").Stores:GetChildren() do
        if v.Name == "ShopItems" then
            for i,v in next,v:GetChildren() do
                if v.Type.Value ~= "Blueprint" then
                    if not table.find(Requirements.Tables.ShopItems,v.BoxItemName.Value) then
                        table.insert(Requirements.Tables.ShopItems,v.BoxItemName.Value)
                    end
                end
            end
        end
    end
	table.sort(Requirements.Tables.ShopItems)
    return Requirements.Tables.ShopItems
end

Requirements.Funcs.GetBlueprints = function()
	Requirements.Tables.BluePrints = {}
	for i,v in next, game:GetService("ReplicatedStorage").ClientItemInfo:GetChildren() do
		if v:FindFirstChild"Type" and v.Type.Value == "Structure" or v.Type.Value == "Furniture" then
			if v:FindFirstChild"WoodCost" then
				if not game:GetService("Players").LocalPlayer.PlayerBlueprints.Blueprints:FindFirstChild(v.Name) then
					table.insert(Requirements.Tables.BluePrints, v.Name)
				end
			end
		end
	end
	return Requirements.Tables.BluePrints
end

Requirements.Funcs.FindLogs = function()
    for i,v in pairs(game:GetService("Workspace").LogModels:GetChildren()) do
        if v:FindFirstChild("Owner") and tostring(v.Owner.Value) == game.Players.LocalPlayer.Name then
            return true 
        end
    end
    return false
end

Requirements.Funcs.FindPlanks = function()
    for i,v in next, game:GetService("Workspace").PlayerModels:GetChildren() do
        if v:FindFirstChild("Owner") and v.Owner.Value == game.Players.LocalPlayer then
            if v:FindFirstChild("TreeClass") then
                return true 
            end
        end
    end
    return false
end

Requirements.Funcs.GetCandyTypes = function()
    for i,v in next,game:GetService("ReplicatedStorage").ClientItemInfo:GetChildren() do
        if v.Name:sub(1,10) == "BagOfCandy" then
            table.insert(Requirements.Tables.CandyTypes,v.Name)
        end
    end
    return Requirements.Tables.CandyTypes
end

Requirements.Funcs.GodMode = function()
    Requirements.Vars.RootJoints = game.Players.LocalPlayer.Character.HumanoidRootPart.RootJoint
    Requirements.Vars.RootJoints:Clone().Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
    Requirements.Vars.RootJoints:Destroy()
end

Requirements.Funcs.GetAxeInfo = function(info,Tree)
    local BestTool,ToolDamage = nil,0
    for i,v in next, game:GetService("Players").LocalPlayer.Backpack:GetChildren() do
        if v.Name ~= "BlueprintTool" then
            if require(game.ReplicatedStorage.AxeClasses:FindFirstChild("AxeClass_"..v.ToolName.Value)).new().Damage > ToolDamage then
                BestTool = v
                ToolDamage = require(game.ReplicatedStorage.AxeClasses:FindFirstChild("AxeClass_"..v.ToolName.Value)).new().Damage
            if require(game.ReplicatedStorage.AxeClasses:FindFirstChild("AxeClass_"..v.ToolName.Value)).new().SpecialTrees and require(game.ReplicatedStorage.AxeClasses:FindFirstChild("AxeClass_"..v.ToolName.Value)).new().SpecialTrees[Tree] then
                    BestTool = v
                    ToolDamage = require(game.ReplicatedStorage.AxeClasses:FindFirstChild("AxeClass_"..v.ToolName.Value)).new().SpecialTrees[Tree].Damage
                    break
                end
            end
        end
    end
    return info == "Tool" and BestTool or info == "Damage" and ToolDamage
end

Requirements.Funcs.ChopTree = function(CutEventRemote, ID, Height,Tree)
    game:GetService("ReplicatedStorage").Interaction.RemoteProxy:FireServer(CutEventRemote, {["tool"] = Requirements.Funcs.GetAxeInfo("Tool",Tree), ["faceVector"] = Vector3.new(1, 0, 0), ["height"] = Height, ["sectionId"] = ID, ["hitPoints"] = Requirements.Funcs.GetAxeInfo("Damage",Tree), ["cooldown"] = 0.25837870788574, ["cuttingClass"] = "Axe"})
end

Requirements.Funcs.FindBestSawmill = function()
    Requirements.Strings.HighestSawmillPrice = 0
    Requirements.Strings.BestSawmill = nil
    for i,v in next, game:GetService("Workspace").PlayerModels:GetChildren() do
        if v:FindFirstChild("Owner") and v.Owner.Value == game.Players.LocalPlayer then
            if v:FindFirstChild("ItemName") and v.ItemName.Value:sub(1,7) == "Sawmill" then
                if game:GetService("ReplicatedStorage").ClientItemInfo:FindFirstChild(v.ItemName.Value).Price.Value > Requirements.Strings.HighestSawmillPrice then
                   Requirements.Strings.HighestSawmillPrice = game:GetService("ReplicatedStorage").ClientItemInfo:FindFirstChild(v.ItemName.Value).Price.Value
                    Requirements.Strings.BestSawmill = v
                end
            end
        end
    end
    return Requirements.Strings.BestSawmill
end

Requirements.Funcs.CalcUnits = function(Model)
    local Units = 0
    if Model:IsA'Model' and Model:FindFirstChild'WoodSection' then
        for i,v in next, Model:GetChildren() do
            if v:IsA'BasePart' and v.Name == 'WoodSection' then
                Units = Units + v.Size.X * v.Size.Y * v.Size.Z
            end
        end
    end
    return math.floor(Units * 100) / 100
end

Requirements.Funcs.FindVehicle = function()
    for i,v in next, game:GetService"Workspace".PlayerModels:GetChildren() do
        if v:FindFirstChild"Owner" and v.Owner.Value == game.Players.LocalPlayer then
            if v:FindFirstChild"Type" and v.Type.Value == "Vehicle" then
                if v:FindFirstChild"DriveSeat" and v:FindFirstChild"Seat" then
                    return v
                end
            end
        end
    end
    return false
end

Requirements.Funcs.TeleportRockBridge = function(Pos)
	Requirements.Vars.OldPos = game:GetService"Players".LocalPlayer.Character.HumanoidRootPart.CFrame
    for i,v in next, game:GetService("Workspace")["Region_Mountainside"].SlabRegen.Slab:GetChildren() do
        if v:IsA"Part" then
            for i = 1,30 do
                game:GetService("ReplicatedStorage").Interaction.ClientIsDragging:FireServer(v)
                v.CFrame = Pos
                task.wait()
            end
        end
    end
end

Requirements.Funcs.GameMenuTheme = function(BGColor, TxtColor) 
    for i,v in next, game:GetService("Players").LocalPlayer.PlayerGui:GetChildren() do
        if v.Name ~= "Chat" and v.Name ~= "TargetGui" then
            for i,v in next, v:GetDescendants() do
                if not v:FindFirstChild"UICorner" then
                    Instance.new("UICorner",v)
                end
                if v.Name == "DropShadow" then
                    v:Destroy()
                end
                if v:IsA("TextButton") or v:IsA("Frame") or v:IsA("ScrollingFrame") then
                    v.BackgroundColor3 = BGColor
                end
                if v:IsA("TextLabel") or v:IsA("TextButton") or v:IsA("TextBox") then
                    v.TextColor3 = TxtColor
                    v.BackgroundColor3 = BGColor
                    v.Font = Enum.Font.GothamMedium
                end
            end
        end
    end
end
Requirements.Funcs.GameMenuTheme(Color3.fromRGB(225, 225, 225), Color3.fromRGB(0, 0, 0))
---~Player~---
Requirements.Funcs.WalkSpeed = function(Speed)
    setupvalue(Requirements.Vars.WS.rotate, 4, Speed)
    Requirements.Vars.WS.rotate()
end

Requirements.Funcs.ShiftToSprint = function()
    Requirements.Vars.UIS.InputBegan:Connect(function(Input,Processed)
        if Input.KeyCode == Enum.KeyCode[Requirements.Config.SprintKey] then
            game.Workspace.CurrentCamera.FieldOfView = 90
            Requirements.Funcs.WalkSpeed(Requirements.Config.SprintSpeed)
        end
    end)
    
    Requirements.Vars.UIS.InputEnded:Connect(function(Input,Processed)
    	if Input.KeyCode == Enum.KeyCode[Requirements.Config.SprintKey] then
    	    game.Workspace.CurrentCamera.FieldOfView = 70
    	    Requirements.Funcs.WalkSpeed(Requirements.Config.Walkspeed)
        end
    end)
end
Requirements.Funcs.ShiftToSprint()

Requirements.Funcs.JumpPower = function(Power)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = Power
end

Requirements.Funcs.InfJump = function(Value)
    if not Value then Requirements.Connections.InfJump:Disconnect() return end
    Requirements.Connections.InfJump = game:GetService("UserInputService").JumpRequest:Connect(function()
	    game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end)
end
Requirements.Funcs.PlayerFly = function(Value) -- Yes ik this is skidded before some retard asks 
    repeat wait() until game.Players.LocalPlayer and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild('Head') and game.Players.LocalPlayer.Character:FindFirstChild('Humanoid')
    local Steer = {f = 0, b = 0, l = 0, r = 0}
    local BackSteer = {f = 0, b = 0, l = 0, r = 0}
    local MaxSpeed = 500
    if not game.Players.LocalPlayer.Character.Humanoid.SeatPart then
	    game.Players.LocalPlayer.Character.Humanoid.PlatformStand = true
	 end
	if game.Players.LocalPlayer.Character.Humanoid.SeatPart then
	    CarFly = game.Players.LocalPlayer.Character.Humanoid.SeatPart
	   local FlyWeldone = Instance.new("Weld",game.Players.LocalPlayer.Character.HumanoidRootPart)
	   local FlyWeldtwo = Instance.new("Weld",game.Players.LocalPlayer.Character.Humanoid.SeatPart)
	   FlyWeldone.Part0 = game.Players.LocalPlayer.Character.HumanoidRootPart
	   FlyWeldone.Part1 = game.Players.LocalPlayer.Character.Humanoid.SeatPart
	   FlyWeldtwo.Part0 = game.Players.LocalPlayer.Character.HumanoidRootPart
	   FlyWeldtwo.Part1 = game.Players.LocalPlayer.Character.Humanoid.SeatPart
    end
    function Fly()
        local Gyro = Instance.new('BodyGyro', game.Players.LocalPlayer.Character.HumanoidRootPart)
        Gyro.P = 9e4
        Gyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
        Gyro.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        local Velocity = Instance.new('BodyVelocity', game.Players.LocalPlayer.Character.HumanoidRootPart)
        Velocity.Velocity = Vector3.new(0,0.1,0)
        Velocity.maxForce = Vector3.new(9e9, 9e9, 9e9)
        repeat wait()
            local FlySpeed = Requirements.Config.FlySpeed
            local SteerSpeed = 50
            if Steer.l + Steer.r ~= 0 or Steer.f + Steer.b ~= 0 then
                SteerSpeed = FlySpeed
                if SteerSpeed > MaxSpeed then
                    SteerSpeed = MaxSpeed
                end
            elseif not (Steer.l + Steer.r ~= 0 or Steer.f + Steer.b ~= 0) and speed ~= 0 then
                SteerSpeed = SteerSpeed-50
                if SteerSpeed < 0 then
                    FlySpeed = 0    
                end
            end
            if (Steer.l + Steer.r) ~= 0 or (Steer.f + Steer.b) ~= 0 then
                Velocity.Velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (Steer.f+Steer.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(Steer.l+Steer.r,(Steer.f+Steer.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p)) * SteerSpeed
                BackSteer = {f = Steer.f ,b = Steer.b ,l = Steer.l, r = Steer.r}
            elseif (Steer.l + Steer.r == 0 or Steer.f + Steer.b == 0) and SteerSpeed ~= 0 then
                Velocity.Velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (BackSteer.f+BackSteer.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(BackSteer.l+BackSteer.r,(BackSteer.f+BackSteer.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p)) * SteerSpeed
            else
                Velocity.Velocity = Vector3.new(0,0.1,0)
            end
            Gyro.CFrame = game.Workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((Steer.f+Steer.b)*50*SteerSpeed/MaxSpeed),0,0)
        until not Requirements.Strings.isFlying
        local SteerSpeed = 0
        local Steer = {F = 0,B = 0,L = 0,R = 0}
        local BackSteer = {F = 0,B = 0,L = 0,R = 0}
        Gyro:Destroy()
        Velocity:Destroy()
        pcall(function()
            for _,v in next,game.Players.LocalPlayer.Character.Humanoid.SeatPart:GetChildren()do
                if v.Name=='Weld'then 
                    v:Destroy();
                end;
            end;
            for i,v in next,game.Players.LocalPlayer.Character.HumanoidRootPart:GetChildren()do
                if v:IsA('Weld')then 
                    v:Destroy();
                end;
            end;
            game.Player.LocalPlayer.CharacterHumanoidRootPart.CFrame = CFrame.new(CarFly.CFrame.p)
        end);
        game.Players.LocalPlayer.Character.Humanoid.PlatformStand = false
    end

    Requirements.Vars.Mouse.KeyDown:Connect(function(Key)
        if Key:lower() == 'w' then
            isWDown = true
            Steer.f = 1
        elseif Key:lower() == 'a' then
            isADown = true
            Steer.l = -1
        elseif Key:lower() == 's' then
            isSDown = true
            Steer.b = -1
        elseif Key:lower() == 'd' then
            isSDown = true
            Steer.r = 1
        end
    end)
    Requirements.Vars.Mouse.KeyUp:Connect(function(Key)
        if Key:lower() == 'w' then
            isWDown = false
            Steer.f = 0
        elseif Key:lower() == 'a' then
            isADown = false
            Steer.l = 0
        elseif Key:lower() == 's' then
            isSDown = false
            Steer.b = 0
        elseif Key:lower() == 'd' then
            isDDown = false
            Steer.r = 0
        end
    end)

    if not Value then
        if Requirements.Config.Float then Requirements.Config.Float = true end
        Requirements.Strings.isFlying = false
        game.Players.LocalPlayer.Character.Humanoid.PlatformStand = false
    elseif Value then
        if not Requirements.Config.Float then Requirements.Config.Float = false end
        Requirements.Strings.isFlying = true
        Fly()
    end
end

Requirements.Funcs.NoClip = function(Value)
    if not Value then Requirements.Connections.NoClip:Disconnect() return end
    Requirements.Connections.NoClip = game:GetService("RunService").Stepped:connect(function()
        for i,v in next, game.Players.LocalPlayer.Character:GetChildren() do
            if v:IsA("BasePart") then
                if Value then
                    v.CanCollide = false
                end
            end
        end
    end)
end

Requirements.Funcs.Invisable = function(Value)
    if Value then
        Requirements.Funcs.CloneTP(true,CFrame.new(4813.1, 33.5, -978.8))
        Requirements.Funcs.PlrTransparency(0.5)
        else
        Requirements.Funcs.CloneTP(false)
        Requirements.Funcs.PlrTransparency(0)
    end
end

Requirements.Funcs.HardDrag = function()
    Requirements.Connections.DraggerSpawned = game.Workspace.ChildAdded:Connect(function(v)
        if v:IsA("Part") and v:WaitForChild("BodyPosition") and v:WaitForChild("BodyGyro") then
            v.BrickColor = Requirements.Config.DragMod and BrickColor.new("Pink") or BrickColor.new("Deep blue")
            v:WaitForChild("BodyPosition").P = Requirements.Config.DragMod and 100500 or 10000
            v:WaitForChild("BodyPosition").D = Requirements.Config.DragMod and 1040 or 800
            v:WaitForChild("BodyPosition").MaxForce = Requirements.Config.DragMod and Vector3.new(90000,90000,90000) * math.huge or Vector3.new(1, 1, 1) * 17000
            v:WaitForChild("BodyGyro").P = Requirements.Config.DragMod and 1400 or 1200
            v:WaitForChild("BodyGyro").D = Requirements.Config.DragMod and 1040 or 140
            v:WaitForChild("BodyGyro").MaxTorque = Requirements.Config.DragMod and Vector3.new(9000,9000,9000) * math.huge or Vector3.new(1,1,1) * 200
        end
    end)
end
--Requirements.Funcs.HardDrag()
Requirements.Funcs.AntiAFK = function(Value)
    if not Value then Requirements.Connections.Idling:Disconnect() return end
    Requirements.Connections.Idling = game:GetService("Players").LocalPlayer.Idled:connect(function()
        game:GetService("VirtualInputManager"):Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        game:GetService("VirtualInputManager"):Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    end)
end
------------------------------------
------------------------------------
 Requirements.Funcs.BTools = function()
    if not game.Players.LocalPlayer.Backpack:FindFirstChild("HopperBin") then
        for i = 1,4 do
            Instance.new('HopperBin', game:GetService'Players'.LocalPlayer.Backpack).BinType = i
        end
        else
        library:Notify("Error!","You already have BTools")
    end
end
Requirements.Funcs.SafeSuicide = function()
    game.Players.LocalPlayer.Character.Head:Remove()
end

Requirements.Funcs.TeleportToPlayer = function(PlrName) -- we dont talk abt this XD
    for i,v in next, game.Players:GetChildren() do
        if v.Name == PlrName then
            Requirements.Funcs.Teleport(v.Character.HumanoidRootPart.CFrame + Vector3.new(0,5,0))
        end
    end
end
Requirements.Funcs.TeleportToPlayersBase = function(PlrName)
    if game.Players[PlrName].OwnsProperty.Value == false then return library:Notify("Error!","Player does not own land") end
    for i,v in next, game:GetService("Workspace").Properties:GetChildren() do
        if v:FindFirstChild("Owner") and tostring(v.Owner.Value) == PlrName then
            Requirements.Funcs.Teleport(v:FindFirstChild("OriginSquare").CFrame + Vector3.new(0,5,0))
        end
    end
end
---~Game~---

Requirements.Funcs.AnnoyPlayer = function(Target, Action) -- shit barley works
    if Target == nil or Action == nil then
        return library:Notify("Error!", "You need to select a target and action to proceed")
    end
    if Target == game:GetService"Players".LocalPlayer.Name and Action ~= "Stop Spectating" then
        return library:Notify("Error!", "You can not perform this action on yourself")
    end
    if not game:GetService"Players":FindFirstChild(Target) then
        return library:Notify("Error!", "Failed to find selected player")
    end
    Requirements.Vars.OldPos = game:GetService"Players".LocalPlayer.Character.HumanoidRootPart.CFrame
    if Action == "Bring" or Action == "Kill" then
        if not game.Players.LocalPlayer.Character.Humanoid.SeatPart then
            if not Requirements.Funcs.FindVehicle() then
                return library:Notify("Error!", "You need to own a vehicle to use this feature")
            else
                game:GetService"Players".LocalPlayer.Character.HumanoidRootPart.CFrame = Requirements.Funcs.FindVehicle().DriveSeat.CFrame + Vector3.new(3,0,0)
                task.wait(1)
            end
        end
        game:GetService("ReplicatedStorage").Interaction.UpdateUserSettings:FireServer("UserPermission",game.Players[Target].UserId,"Sit",true)
        game:GetService("ReplicatedStorage").Interaction.UpdateUserSettings:FireServer("UserPermission",game.Players[Target].UserId,"Drive",true)
        repeat
            game.Players.LocalPlayer.Character.Humanoid.SeatPart.Parent:SetPrimaryPartCFrame(game.Players[Target].Character.HumanoidRootPart.CFrame*CFrame.Angles(0,0,math.rad(-90)))
            task.wait(.05)
        until game.Players[Target].Character.Humanoid.Sit == true or not game:GetService"Players":FindFirstChild(Target)
        for i = 1,25 do
            game.Players.LocalPlayer.Character.Humanoid.SeatPart.Parent:SetPrimaryPartCFrame(Action == "Kill" and CFrame.new(113, -214, -951) or Requirements.Vars.OldPos)
            task.wait()
        end
    elseif Action == "Spectate" then
        game.Workspace.Camera.CameraSubject = game.Players[Target].Character.Head
    elseif Action == "Stop Spectating" then
        game.Workspace.Camera.CameraSubject = game.Players.LocalPlayer.Character.Head
    elseif Action == "Follow" then
        repeat
            Requirements.Funcs.Teleport(CFrame.new(game:GetService"Players":FindFirstChild(Target).Character.HumanoidRootPart.CFrame.p))
            task.wait()
        until not game.Players[Target] or Requirements.Strings.AnnoyAction == "Unfollow"
		Requirements.Funcs.Teleport(Requirements.Vars.OldPos)
	elseif Action == "Rock Bridge" then
		for i = 1,100 do 
			Requirements.Funcs.TeleportRockBridge(game.Players[Target].Character.HumanoidRootPart.CFrame + Vector3.new(0,3,0))
			task.wait()
		end
    end
end

Requirements.Funcs.TomahawkAxeFling = function(Value)
    if not Value then Requirements.Connections.ToolAdded:Disconnect() Requirements.Connections.AxeFling:Disconnect() return end
    Requirements.Connections.ToolAdded = game.Workspace.PlayerModels.ChildAdded:Connect(function(v)
        if v:WaitForChild("Owner") and v.Owner.Value == game.Players.LocalPlayer then
            if v:WaitForChild("Main") and v:WaitForChild("ToolName") then
                Requirements.Strings.SelectedTool = v
                local BodyAngularVelocityAdded = Instance.new("BodyAngularVelocity",v.Main)
                local BodyPos = Instance.new("BodyPosition",v.Main)
                BodyPos.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
                BodyPos.Position = Requirements.Strings.ThrowPos
                BodyPos.P = 1000000
                BodyAngularVelocityAdded.P = 9e9
                BodyAngularVelocityAdded.MaxTorque = Vector3.new(0,9999999,0)
                BodyAngularVelocityAdded.AngularVelocity = Vector3.new(0,9999999,0)
                BodyAngularVelocityAdded.P = 9999999
                repeat
                    if not Requirements.Strings.SelectedTool:FindFirstChild("Main") then break end
                    game.ReplicatedStorage.Interaction.ClientIsDragging:FireServer(Requirements.Strings.SelectedTool)
                    v.Main.CFrame = CFrame.new(Requirements.Strings.ThrowPos) * CFrame.Angles(math.rad(20*Requirements.Strings.AxeRotation),0,0)
                    Requirements.Strings.AxeRotation = Requirements.Strings.AxeRotation + 1
                    task.wait(0.5)
                until (game.Players.LocalPlayer.Character.Head.CFrame.p - Requirements.Strings.SelectedTool:WaitForChild("Main").CFrame.p).Magnitude >= 15 or Requirements.Strings.AxeRotation >= 40
                game:GetService("ReplicatedStorage").Interaction.ClientInteracted:FireServer(Requirements.Strings.SelectedTool,"Pick up tool")
				game:GetService"Players".LocalPlayer.Character:WaitForChild"Tool"
				game.Players.LocalPlayer.Character.Humanoid:UnequipTools()
                Requirements.Booleans.SelectedTool = nil
            end
        end
    end)
    
    Requirements.Connections.AxeFling = Requirements.Vars.Mouse.Button1Up:Connect(function()
        if not game.Players.LocalPlayer.Backpack:FindFirstChild("Tool") then
            return library:Notify("Error!","Failed to find a tool")
        end
        Requirements.Strings.AxeRotation = 0
        Requirements.Strings.ThrowPos = Requirements.Vars.Mouse.Hit.p
        game:GetService("ReplicatedStorage").Interaction.ClientInteracted:FireServer(game.Players.LocalPlayer.Backpack:FindFirstChild("Tool"),"Drop tool",game.Players.LocalPlayer.Character["Right Arm"].CFrame - Vector3.new(5,0,0))
    end)
end

Requirements.Funcs.VehiclePitch = function()
    game.Players.LocalPlayer.Character.Humanoid:GetPropertyChangedSignal("SeatPart"):Connect(function(v)
        if game.Players.LocalPlayer.Character.Humanoid.SeatPart ~= nil then
            if game.Players.LocalPlayer.Character.Humanoid.SeatPart.Parent:FindFirstChild("Configuration") then
                repeat
                    game.Players.LocalPlayer.Character.Humanoid.SeatPart.Parent.RunSounds:FireServer("Set Pitch",Requirements.Config.VehiclePitch)
                    task.wait()
                until game.Players.LocalPlayer.Character.Humanoid.SeatPart == nil
            end
        end
    end)
end
Requirements.Funcs.VehiclePitch()

Requirements.Funcs.ClearShopItems = function()
    while Requirements.Booleans.ClearShopItems do
        for i,v in next, game:GetService("Workspace").Stores:GetChildren() do
            if v:IsA"Model" and v.Name == "ShopItems" then
                for i,v in next, v:GetChildren() do
                    if v:FindFirstChild"Owner" and v.Owner.Value == nil then
                        v.Main.CanCollide = false
                    end
                end
            end
        end
        task.wait()
    end
end

Requirements.Funcs.ClaimAllTrees = function()
    Requirements.Vars.OldPos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
    for i,v in next, game:GetService("Workspace"):GetChildren() do
        if v.Name == "TreeRegion" then
            for i,v in next, v:GetChildren() do
                if v:FindFirstChild("Owner") and v.Owner.Value == nil then
                    Requirements.Funcs.Teleport(v:FindFirstChild("WoodSection").CFrame)
                    repeat
                        if not Requirements.Booleans.ClaimTrees then
                            return Requirements.Funcs.Teleport(Requirements.Vars.OldPos)
                        end
                        game:GetService("ReplicatedStorage").Interaction.ClientIsDragging:FireServer(v)
                        task.wait()
                    until v.Owner.Value ~= nil
                end
            end
        end
    end
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Requirements.Vars.OldPos
end

Requirements.Funcs.TriggerAllPressurePlates = function()
    Requirements.Booleans.PlateFound = false
    Requirements.Vars.OldPos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
    for i,v in next, game:GetService("Workspace").PlayerModels:GetChildren() do
        if v:FindFirstChild("Type") and tostring(v.Type.Parent) == "PressurePlate" then
        Requirements.Booleans.PlateFound = true
        repeat
            Requirements.Funcs.Teleport(CFrame.new(v.Plate.CFrame.p))
            task.wait()
            until v.Output.BrickColor.Name == "Electric blue"
        end
    end
    Requirements.Funcs.Teleport(Requirements.Vars.OldPos)
    if Requirements.Booleans.PlateFound then
        library:Notify("Ernestlin","Triggered all pressure plate(s)")
        else
        library:Notify("Error!","No pressure plate's found!")
    end
end

Requirements.Funcs.SitInAnyVehicle = function()
    if game:GetService("Players").LocalPlayer.PlayerScripts.SitPermissions.Disabled == true then return library:Notify("Error!","Vehicle sit permissions are already disabled") end
    game:GetService("Players").LocalPlayer.PlayerScripts.SitPermissions.Disabled = true
    library:Notify("Ernestlin","Disabled vehicle sit permissions")
end

Requirements.Funcs.CandyOptions = function(Input,Type,Exclude)
    for i,v in next, game:GetService("Workspace").PlayerModels:GetChildren() do
        if v:FindFirstChild("Owner") and v.Owner.Value == game.Players.LocalPlayer then
            if v:FindFirstChild("PurchasedBoxItemName") or v:FindFirstChild("ItemName") then
                if Input == "Open Boxed Candy" and v:FindFirstChild("PurchasedBoxItemName") and v.PurchasedBoxItemName.Value == Type then
                    repeat game:GetService("ReplicatedStorage").Interaction.ClientInteracted:FireServer(v,"Open box") task.wait() until v.Parent == nil
                elseif Input == "Open Candy Bags" and v:FindFirstChild("ItemName") and v.ItemName.Value == Type then
                    repeat
                        game:GetService("ReplicatedStorage").Interaction.RemoteProxy:FireServer(v.ButtonRemote_Main)
                        task.wait()
                    until v.Parent == nil
                elseif Input == "Eat All Candy" and v:FindFirstChild("ItemName") and v.ItemName.Value == "Candy" then
                    repeat
                        if Exclude then
                            if v.Main.BrickColor ~= BrickColor.new("Hot pink") and v.Main.BrickColor ~= BrickColor.new("Cyan") then
                                game:GetService("ReplicatedStorage").Interaction.RemoteProxy:FireServer(v.ButtonRemote_Main)
                            end
                        else
                            game:GetService("ReplicatedStorage").Interaction.RemoteProxy:FireServer(v.ButtonRemote_Main)
                        end
                        task.wait()
                    until v.Parent == nil
                end
            end
        end
    end
end

---~Enviroment~---

game.Lighting.Changed:Connect(function()
    if Requirements.Config.AlwaysDay then
        game.Lighting.TimeOfDay = "12:00:00"
		if game:GetService"Lighting":FindFirstChild"SunPos" then
        	game.Lighting.SunPos.Value = 1
		end
    end
    if Requirements.Config.AlwaysNight then
        game.Lighting.TimeOfDay = "24:00:00"
		if game:GetService"Lighting":FindFirstChild"SunPos" then
        	game.Lighting.SunPos.Value = -1
		end
    end
    if Requirements.Config.NoFog then
        game.Lighting.FogEnd = 100000
        game.Lighting.ColorCorrection.TintColor = Color3.fromRGB(255, 255, 255)
        game.Lighting.FogColor = Color3.fromRGB(255, 255, 255)
        game.Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
    end
    if Requirements.Config.Spook then
        game.Lighting.Spook.Value = true
        else
        game.Lighting.Spook.Value = false
    end
end)

Requirements.Funcs.BetterGraphics = function()
    for i,v in next, game:GetService("Lighting"):GetChildren() do
        if v.Name ~= "Spook" then
            v:Destroy()
        end
    end
    if game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("UnderwaterOverlay") then
        game:GetService("Players").LocalPlayer.PlayerGui.UnderwaterOverlay:Destroy()
    end
    for i,v in next, game.Workspace:GetDescendants() do
        if v:IsA("Part") and v.Name == "Water" then
            game.Workspace.Terrain:FillBlock(v.CFrame, v.Size, Enum.Material.Water)
            v:Destroy()
        end
        if v:IsA("Part") and v.Name == "LeafPart" then
            v.Transparency = 0.5
        end
    end
    local Blur = Instance.new("BlurEffect",game.Lighting)
    local CC = Instance.new("ColorCorrectionEffect",game.Lighting)
    local SR = Instance.new("SunRaysEffect",game.Lighting)
    SR.Intensity = 0.2
    SR.Spread = 1
    CC.Brightness = 0.03
    CC.Contrast = 0.3
    CC.Saturation = 0.01
    CC.TintColor = Color3.fromRGB(244,244,244)
    Blur.Size = 3
    
    Workspace.DescendantAdded:Connect(function(v)
        if v:IsA("Part") and v.Name == "LeafPart" then
            v.Transparency = 0.8    
        end    
    end)
    
    game.Lighting.GlobalShadows = true
    game.Lighting.GeographicLatitude = 350
    game.Lighting.ExposureCompensation = 0.03
end

Requirements.Funcs.WaterOption = function(Value,Option)
    for i,v in next, game:GetService("Workspace").Water:GetChildren() do
        if v.Name == "Water" and v:IsA"Part" then
            if Option == "Walk" then
                v.CanCollide = Value
                game:GetService("Workspace").Bridge.VerticalLiftBridge.WaterModel.Water.CanCollide = Value
            elseif Option == "Remove" then
                v.Transparency = Value and 1 or 0
                game:GetService("Workspace").Bridge.VerticalLiftBridge.WaterModel.Water.Transparency = Value and 1 or 0
            end
        end
    end
end

function WaterFloat()
    getsenv(game:GetService("Players").LocalPlayer.PlayerGui.Scripts.CharacterFloat).isInWater = function(...)
        if not Requirements.Config.Float then
            return 1
            else
            return Requirements.Vars.FloatOld(...)
        end
    end
end
WaterFloat()

Requirements.Funcs.Bridge = function(Value)
    for i,v in next, game:GetService("Workspace").Bridge.VerticalLiftBridge.Lift:GetChildren() do
        v.CFrame = Value and v.CFrame - Vector3.new(0,26,0) or v.CFrame + Vector3.new(0,26,0)
    end
    for i,v in next, game:GetService("Workspace").Bridge.VerticalLiftBridge.Weight:GetChildren() do
        v.CFrame = Value and v.CFrame + Vector3.new(0,26,0) or v.CFrame - Vector3.new(0,26,0)
    end
end

Requirements.Funcs.DestroyGreenBox = function()
	Requirements.Vars.OldPos = game:GetService"Players".LocalPlayer.Character.HumanoidRootPart.CFrame
	for i,v in next, game:GetService("Workspace")["Region_Volcano"]:GetChildren() do
		if v.Name == "VolcanoWin" then
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
			game.ReplicatedStorage.Interaction.ClientIsDragging:FireServer(v)
			v.BodyPosition:Destroy()
			v.BodyAngularVelocity:Destroy()
		end
	end
	task.wait(1)
	game:GetService"Players".LocalPlayer.Character.HumanoidRootPart.CFrame = Requirements.Vars.OldPos
end

---~Slot~---

Requirements.Funcs.LoadSlot = function(SlotNum)
    if game.Players.LocalPlayer.CurrentlySavingOrLoading.Value == true then return library:Notify("Error!","Load in process") end
    if not game:GetService("ReplicatedStorage").LoadSaveRequests.ClientMayLoad:InvokeServer(game.Players.LocalPlayer) then
        library:Notify("Error!","Load on coolDown please wait")
        repeat task.wait() until game:GetService("ReplicatedStorage").LoadSaveRequests.ClientMayLoad:InvokeServer(game.Players.LocalPlayer)
    end
    if game.Players.LocalPlayer.CurrentSaveSlot.Value ~= -1 then
        game:GetService("ReplicatedStorage").LoadSaveRequests.RequestSave:InvokeServer(SlotNum, game.Players.LocalPlayer)
        Requirements.Funcs.SetSlotTo(-1)
    end
    library:Notify("Ernestlin","Loading slot "..SlotNum)
    game:GetService("ReplicatedStorage").LoadSaveRequests.RequestLoad:InvokeServer(SlotNum,game.Players.LocalPlayer)
    repeat task.wait() until game.Players.LocalPlayer.CurrentlySavingOrLoading.Value ~= true
    if game.Players.LocalPlayer.OwnsProperty.Value == true then
        Requirements.Funcs.SetSlotTo(SlotNum)
        return library:Notify("Ernestlin","Slot "..SlotNum.." loaded successfully")
    end
    library:Notify("Ernestlin","Slot deloaded successfully")
end

Requirements.Funcs.FastLoad = function()
	--Removed due to base wiping if using another gui
end

Requirements.Funcs.FreeLand = function()
    if game.Players.LocalPlayer.OwnsProperty.Value == true then library:Notify("Error","You already own land") return end
    library:Notify("Ernestlin","Claim the closest plot ?",true,function(Value)
        if Value then
            local ToClaim,Dis = nil,9e9
            for i,v in next, game:GetService("Workspace").Properties:GetChildren() do
                if v:FindFirstChild("Owner") and v.Owner.Value == nil then
                    local Distance = (game.Players.LocalPlayer.Character.Torso.CFrame.p - v.OriginSquare.CFrame.p).Magnitude
                    if Dis > Distance then
                        ToClaim,Dis = v,Distance
                    end
                end
            end
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = ToClaim.OriginSquare.CFrame + Vector3.new(0,2,0)
            game:GetService("ReplicatedStorage").PropertyPurchasing.ClientPurchasedProperty:FireServer(ToClaim,ToClaim.OriginSquare.Position)
        end
    end)
end

Requirements.Funcs.MaxLand = function()
    if game:GetService("Players").LocalPlayer.OwnsProperty.Value ~= true then 
        library:Notify("Error!","You do not own a plot would you like to get some free land",true,function(Value)
            if Value then Requirements.Funcs.FreeLand() end
        end)
    end
    if #Requirements.Funcs.GetPlot(game.Players.LocalPlayer.Name):GetChildren() >= 26 then return library:Notify("Error!","You already have max land") end
    for i,v in next, Requirements.Tables.LandVec do
        game.ReplicatedStorage.PropertyPurchasing.ClientExpandedProperty:FireServer(Requirements.Funcs.GetPlot(game.Players.LocalPlayer.Name),CFrame.new(Requirements.Funcs.GetPlot(game.Players.LocalPlayer.Name).OriginSquare.Position + v))
    end
end

Requirements.Funcs.SellSign = function()
    for i,v in next,game:GetService("Workspace").PlayerModels:GetChildren() do
        if v:FindFirstChild("Owner") and v.Owner.Value == game.Players.LocalPlayer then
            if v:FindFirstChild("Type") or v:FindFirstChild("ItemName") then
                if tostring(v.ItemName.Value) == "PropertySoldSign" or tostring(v.Type.Value) == "PropertySoldSign" then
                    Requirements.Funcs.Teleport(v:FindFirstChild("Main").CFrame + Vector3.new(3,2,0))
                    game:GetService("ReplicatedStorage").Interaction.ClientInteracted:FireServer(v,"Take down sold sign")
                    for i = 1,80 do
			            game:GetService("ReplicatedStorage").Interaction.ClientIsDragging:FireServer(v)
                        v.Main.CFrame = CFrame.new(314.54, -0.5, 86.823)
                        task.wait()
                    end
                end
            end
        end
    end
end

Requirements.Funcs.AutoWhiteList = function(Value) -- not usefull anymore 
    if not Value then Requirements.Connections.WLPlayerAdded:Disconnect() return end
        if Requirements.Config.AutoBL then Requirements.Tables.UIVars.ABL:Set(false) end
        Requirements.Funcs.SetPerms(true)
        Requirements.Connections.WLPlayerAdded = game.Players.ChildAdded:Connect(function(n)
        if n.Name ~= game.Players.LocalPlayer.Name then
            Requirements.Funcs.SetPerms(true)
        end
    end)
end

Requirements.Funcs.AutoBlacklist = function(Value)-- not usefull anymore 
    if not Value then Requirements.Connections.BLPlayerAdded:Disconnect() return end
    if Requirements.Config.AutoWL then Requirements.Tables.UIVars.AWL:Set(false) end
    Requirements.Funcs.SetPerms(false)
    Requirements.Connections.BLPlayerAdded = game.Players.ChildAdded:Connect(function(n)
        if n.Name ~= game.Players.LocalPlayer.Name then
            Requirements.Funcs.SetPerms(false)
        end
    end)
end

Requirements.Funcs.DestroyBLWalls = function()
    for i,v in pairs(game:GetService("Workspace").Effects:GetChildren()) do
        if v.Name == "BlacklistWall" then
            v:Destroy()
        end
    end
end

Requirements.Funcs.AntiBL = function()
    Requirements.Funcs.DestroyBLWalls()
    game:GetService("Workspace").Effects.ChildAdded:Connect(function(v)
        if v.Name == "BlacklistWall" then
            Requirements.Funcs.DestroyBLWalls()
        end
    end)
    Requirements.Vars.Char = game.Players.LocalPlayer.Character
    Requirements.Vars.PlrTorso = game.Players.LocalPlayer.Character.Torso
    Requirements.Strings.AntiBLClone = Requirements.Vars.PlrTorso:Clone()
    Requirements.Vars.Char.HumanoidRootPart:Destroy()
    Requirements.Vars.PlrTorso.Name = "HumanoidRootPart"
	Requirements.Vars.PlrTorso.Transparency = 1
    Requirements.Strings.AntiBLClone.Parent = Requirements.Vars.Char
	Requirements.Strings.AntiBLClone.Transparency = 0
end

Requirements.Funcs.TransferPower = function(Slot)
	--Removed as i want to keep the method private 
end

Requirements.Funcs.VehicleSpeed = function(Value)
    for i,v in next,game:GetService("Workspace").PlayerModels:GetChildren() do
        if v:FindFirstChild("Owner") and tostring(v.Owner.Value) == game.Players.LocalPlayer.Name then
            if v:FindFirstChild("Type") and tostring(v.Type.Value) == "Vehicle" then
                if v:FindFirstChild("Configuration") then
                    v.Configuration.MaxSpeed.Value = Value
                end
            end
        end
    end
end

Requirements.Funcs.FlipVehicle = function()
    if game.Players.LocalPlayer.Character.Humanoid.SeatPart == nil or game.Players.LocalPlayer.Character.Humanoid.SeatPart.Name ~= "DriveSeat" then
        return library:Notify("Error!","Sit in the drivers seat of the vehicle you want to flip")
    end
    game.Players.LocalPlayer.Character.Humanoid.SeatPart.Parent:SetPrimaryPartCFrame(game.Players.LocalPlayer.Character.Humanoid.SeatPart.Parent.PrimaryPart.CFrame*CFrame.Angles(math.rad(-180),0,0) + Vector3.new(0,5,0))
end

Requirements.Funcs.SelectSpawnPads = function(Value)
    if not Value then Requirements.Connections.SelectPads:Disconnect() return end
    Requirements.Connections.SelectPads = Requirements.Vars.Mouse.Button1Up:Connect(function()
        Requirements.Strings.ClickedPart = Requirements.Vars.Mouse.Target
        if Requirements.Strings.ClickedPart.Parent:FindFirstChild("Type") and Requirements.Strings.ClickedPart.Parent.Type.Value == "Vehicle Spot" then
			if Requirements.Strings.SelectedCarColor == nil then return print("Select a car color") end
            if not Requirements.Strings.ClickedPart:FindFirstChild("SelectionBox") then
                local CarSelection = Instance.new("SelectionBox",Requirements.Strings.ClickedPart)
                CarSelection.Adornee = Requirements.Strings.ClickedPart
				local CarColor = Instance.new("StringValue", Requirements.Strings.ClickedPart.Parent)
				CarColor.Value = Requirements.Strings.SelectedCarColor
				CarColor.Name = "CarColor"
                else
                Requirements.Strings.ClickedPart.SelectionBox:Destroy()
				Requirements.Strings.ClickedPart.Parent.CarColor:Destroy()
            end
        end
    end)
end

Requirements.Funcs.StartCarSpawner = function(DestroyPads)
    Requirements.Strings.PadSelected = false
    Requirements.Connections.WaitingForCar = game:GetService("Workspace").PlayerModels.ChildAdded:Connect(function(v)
        if v:WaitForChild("Type").Value == "Vehicle" then
    	    if v:WaitForChild("PaintParts") then
                Requirements.Strings.PaintPart = v.PaintParts.Part
            end
        end
    end)
    
    for i,v in next,game:GetService("Workspace").PlayerModels:GetChildren() do
        if not Requirements.Booleans.CarSpawner then break end
        if v:FindFirstChild("Type") and v.Type.Value == "Vehicle Spot" then
            if v.Main:FindFirstChild("SelectionBox") then
                Requirements.Strings.PadSelected = true
                repeat
                    if not Requirements.Booleans.CarSpawner then break end
                    game:GetService("ReplicatedStorage").Interaction.RemoteProxy:FireServer(v.ButtonRemote_SpawnButton)
                    task.wait(1)
                until Requirements.Strings.PaintPart.BrickColor.Name == v:FindFirstChild"CarColor".Value
                v.Main:FindFirstChild("SelectionBox"):Destroy()
				v:FindFirstChild"CarColor":Destroy()
                if DestroyPads and not Requirements.Booleans.CarSpawner then
                    Requirements.DestroyStructure:FireServer(v)
                end
            end
        end
    end
    Requirements.Connections.WaitingForCar:Disconnect()
    if Requirements.Booleans.CarSpawner and Requirements.Strings.PadSelected then
        library:Notify("Car Spawner","Finished car spawner")
    elseif not Requirements.Booleans.CarSpawner and Requirements.Strings.PadSelected then
        library:Notify("Car Spawner","Aborted")
    else
        library:Notify("Error!","No spawn pads selected")
    end
    Requirements.Tables.UIVars.CST:Set(false)
end

---~AutoBuy~---

Requirements.Funcs.FindItem = function(Item)
    Requirements.Strings.ItemFound = nil
    while task.wait() do
        if Requirements.Strings.ItemFound ~= nil then break end
        for i,v in next, game:GetService"Workspace".Stores:GetChildren() do
            if v:IsA"Model" and v.Name == "ShopItems" then
                for i,v in next, v:GetChildren() do
                    if v:FindFirstChild"Owner" and v.Owner.Value == nil then
                        if v:FindFirstChild"BoxItemName" and tostring(v.BoxItemName.Value) == Item then
                            Requirements.Strings.ItemFound = v
                            break
                        end
                    end
                    if Requirements.Strings.ItemFound ~= nil then break end
                end
            end
        end
    end
    return Requirements.Strings.ItemFound
end

Requirements.Funcs.GetClosestCounter = function()
    local Counter,Distance = nil,9e9
    for i,v in next, game:GetService"Workspace".Stores:GetChildren() do
        if v:IsA"Model" and v.Name ~= "ShopItems" then
            for i,v in next, v:GetChildren() do
                if v.Name == "Counter" then
                    local Dis = (game:GetService"Players".LocalPlayer.Character.Head.CFrame.p - v.CFrame.p).Magnitude
                    if Distance > Dis then
                        Counter,Distance = v,Dis
                    end
                end
            end
        end
    end
    return Counter
end

Requirements.Funcs.AutoBuy = function(Items,Amount,Loop,OpenBox,RukiryAxe)
	if Requirements.Booleans.IsBuying then return library:Notify("Error!", "AutoBuy in process") end
    if RukiryAxe then 
        OpenBox = true
        Amount = 1
        Items = {"LightBulb","BagOfSand","CanOfWorms"}
    end
    if typeof(Items) ~= "table" then
        Items = {Items}
    end
	if #Items < 1 then
		return library:Notify("Error!", "No item(s) selected")
	end
    if game:GetService"Players".LocalPlayer.leaderstats.Money.Value < Requirements.Funcs.GetTotalPrice(Items,Amount) then
        return library:Notify("Error!", "You do not have the efficient funds to purchase the selected item(s)")
    end
	Requirements.Booleans.IsBuying = true
	Requirements.Booleans.AbortAutoBuy = false
    Requirements.Connections.RukiryAxeSpawned = RukiryAxe and game:GetService("Workspace").PlayerModels.ChildAdded:Connect(function(v)
        if v:WaitForChild"Owner" and v.Owner.Value == nil then
            if v:WaitForChild"ToolName" and v.ToolName.Value == "Rukiryaxe" or v.ToolName.Value == "EndTimesAxe" then
                Requirements.Funcs.Teleport(v:WaitForChild("Main").CFrame)
                repeat
                    game:GetService("ReplicatedStorage").Interaction.ClientIsDragging:FireServer(v)
                    game:GetService("ReplicatedStorage").Interaction.ClientInteracted:FireServer(v,"Pick up tool")
                    task.wait()
                until game.Players.LocalPlayer.Character:FindFirstChild"Tool"
            end
        end
    end)
    Requirements.Connections.Ingredients = RukiryAxe and game:GetService("Workspace").PlayerModels.ChildAdded:Connect(function(v)
        if v:WaitForChild("Owner") and v.Owner.Value == game.Players.LocalPlayer then
            if v:WaitForChild('ItemName') then
                if v.ItemName.Value == "BagOfSand" then
                    Requirements.Funcs.TeleportItem(v,30,CFrame.new(319,43,1914))
                elseif v.ItemName.Value == "CanOfWorms" then
                    Requirements.Funcs.TeleportItem(v,30,CFrame.new(317,43,1918))
                elseif v.ItemName.Value == "LightBulb" then
                    Requirements.Funcs.TeleportItem(v,30,CFrame.new(322.308, 43.2842, 1916.4))
                end
            end
        end
    end)
    for i,v in next, Items do
		if Requirements.Booleans.AbortAutoBuy then break end
        if game:GetService("Players").LocalPlayer.PlayerBlueprints.Blueprints:FindFirstChild(v) then break end
        for i = 1,Amount do
			if Requirements.Booleans.AbortAutoBuy then break end
            Requirements.Strings.ItemToBuy = Requirements.Funcs.FindItem(v)
            if (game:GetService"Players".LocalPlayer.Character.HumanoidRootPart.CFrame.p - Requirements.Strings.ItemToBuy:FindFirstChild"Main".CFrame.p).Magnitude > 25 then
				Requirements.Funcs.Teleport(Requirements.Strings.ItemToBuy:FindFirstChild("Main").CFrame + Vector3.new(5,0,5))
            end
		    if not Requirements.Funcs.CheckOwnerShip(Requirements.Strings.ItemToBuy["Main"]) then
		        repeat
					if Requirements.Booleans.AbortAutoBuy then break end
		            game.ReplicatedStorage.Interaction.ClientIsDragging:FireServer(Requirements.Strings.ItemToBuy)
		            task.wait()
		        until Requirements.Funcs.CheckOwnerShip(Requirements.Strings.ItemToBuy["Main"])
		    end
		    Requirements.Strings.StoreCounter = Requirements.Funcs.GetClosestCounter()
		    for i = 1,25 do
		        game.ReplicatedStorage.Interaction.ClientIsDragging:FireServer(Requirements.Strings.ItemToBuy)
		        Requirements.Strings.ItemToBuy:PivotTo(Requirements.Strings.StoreCounter.CFrame + Vector3.new(0,Requirements.Strings.StoreCounter.Size.Y * Requirements.Strings.ItemToBuy.Main.Size.Y/2,0))
		        task.wait()
		    end
		    --Requirements.Funcs.Teleport(Requirements.Strings.StoreCounter.CFrame + Vector3.new(5,0,5))
		    repeat
				if Requirements.Booleans.AbortAutoBuy then break end
		        game.ReplicatedStorage.Interaction.ClientIsDragging:FireServer(Requirements.Strings.ItemToBuy)
                task.spawn(function()
					game.ReplicatedStorage.NPCDialog.PlayerChatted:InvokeServer({ID = Requirements.Tables.ShopIds[Requirements.Strings.StoreCounter.Parent.Name]},"ConfirmPurchase")
                end)
			    task.wait()
		    until Requirements.Strings.ItemToBuy.Parent.Name ~= "ShopItems"
		    if not OpenBox or not RukiryAxe and Requirements.Strings.ItemToBuy:WaitForChild"Type".Value ~= "Blueprint" or game:GetService("Players").LocalPlayer.PlayerBlueprints.Blueprints:FindFirstChild(Requirements.Strings.ItemToBuy:WaitForChild"Type".Value) then
    		    for i = 1,25 do
    		        game.ReplicatedStorage.Interaction.ClientIsDragging:FireServer(Requirements.Strings.ItemToBuy)
    		        Requirements.Strings.ItemToBuy:PivotTo(Requirements.Vars.OldPos + Vector3.new(5,1,0))
    		        task.wait()
    		    end
            else
                repeat
                    game:GetService("ReplicatedStorage").Interaction.ClientInteracted:FireServer(Requirements.Strings.ItemToBuy,"Open box")
                    task.wait(1)
                until Requirements.Strings.ItemToBuy.Parent == nil
		    end
            task.wait()
        end
    end
    if RukiryAxe then
        repeat task.wait() until game.Players.LocalPlayer.Character:FindFirstChild("Tool")
        task.wait()
        game.Players.LocalPlayer.Character.Humanoid:UnequipTools()
    end
    if RukiryAxe then Requirements.Connections.Ingredients:Disconnect() Requirements.Connections.RukiryAxeSpawned:Disconnect() end
    if RukiryAxe and Requirements.Strings.AutoBuyAmount ~= 1 then Requirements.Strings.AutoBuyAmount = Requirements.Strings.AutoBuyAmount - 1  Requirements.Funcs.AutoBuy(Items,Requirements.Strings.AutoBuyAmount.AutoBuyAmount,Loop,OpenBox,RukiryAxe) end
    if Loop and not RukiryAxe then return Requirements.Funcs.AutoBuy(Items,Amount,Loop,OpenBox) end
	Requirements.Booleans.IsBuying = false
    Requirements.Funcs.Teleport(Requirements.Vars.OldPos)
end

Requirements.Funcs.FastCheckout = function(Value)
	setconstant(getsenv(game:GetService"Players".LocalPlayer.PlayerGui.ChatGUI.NPCChattingClient).advanceChat,19,Value)
end

Requirements.Funcs.MiscBuy = function(ID, Amount, Item)
	if game:GetService("Players").LocalPlayer.leaderstats.Money.Value >= tonumber(Amount) then
		game:GetService("ReplicatedStorage").NPCDialog.PlayerChatted:InvokeServer({["ID"] = ID},"ConfirmPurchase")
	else
		library:Notify("Error!","You dont have the efficient funds to purchase the "..Item)
	end
end

---~Wood~---

Requirements.Funcs.GetAllTreeTypes = function(Type)
    Requirements.Tables.AvailableTrees = {}
    for i,v in next, game.Workspace:GetChildren() do
        if v.Name == "TreeRegion" then
            for i,v in next, v:GetChildren() do
                if v:FindFirstChild("Owner") and v.Owner.Value == nil then
                    if v:FindFirstChild("TreeClass") and v.TreeClass.Value == Type then
                        table.insert(Requirements.Tables.AvailableTrees,v)
                    end
                end
            end
        end
    end
    return Requirements.Tables.AvailableTrees
end

Requirements.Funcs.FindBigTree = function(Type)
    Requirements.Strings.Count = 0
    Requirements.Strings.Count2 = 0
    Requirements.Strings.SelectedTree = nil
    for i,v in next, Requirements.Funcs.GetAllTreeTypes(Type) do
        Requirements.Strings.Count = 0
        for i,v in next, v:GetChildren() do
            if v.Name == "WoodSection" then
                Requirements.Strings.Count = Requirements.Strings.Count + 1
            end
            if Requirements.Strings.Count > Requirements.Strings.Count2 then
                Requirements.Strings.SelectedTree = v
                Requirements.Strings.Count2 = Requirements.Strings.Count
            end
        end
    end
    if Requirements.Strings.SelectedTree ~= nil then
        return Requirements.Strings.SelectedTree.Parent
    end
    return false
end

Requirements.Funcs.GetTreesLowID = function(Type)
    if not Requirements.Funcs.FindBigTree(Type) then return false end
    for i,v in next, Requirements.Funcs.FindBigTree(Type):GetChildren() do
        if v.Name == "WoodSection" then
            if v.ID.Value == 1 then
                return v
            end
        end
    end
end

Requirements.Funcs.GetAllIDs = function(Tree)
    Requirements.Tables.TreesIDs = {}
    for i,v in next, Tree:GetChildren() do
        if v.Name == "WoodSection" then
            if v:FindFirstChild"ID" and v.ID.Value ~= 1 then
                table.insert(Requirements.Tables.TreesIDs,v.ID.Value)
            end
        end
    end
    for i,v in next, Tree:GetChildren() do
        if v.Name == "InnerWood" then
            if table.find(Requirements.Tables.TreesIDs, v.ID.Value) then
                table.remove(Requirements.Tables.TreesIDs,table.find(Requirements.Tables.TreesIDs, v.ID.Value))
            end
        end
    end
    table.sort(Requirements.Tables.TreesIDs)
    return Requirements.Tables.TreesIDs
end

Requirements.Funcs.GetTree = function(Trees, Amount, Loop)
	if Requirements.Booleans.IsChopping then
		return library:Notify("Error!","Get tree in process")
	end
	if game.Players.LocalPlayer.Character:FindFirstChild("Tool") then
		game.Players.LocalPlayer.Character.Humanoid:UnequipTools()
	end
	if not game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Tool") or game.Players.LocalPlayer.Character:FindFirstChild("Tool") then
		return library:Notify("Error!", "You need a tool to use this feature")
	end
    if typeof(Trees) ~= "table" then
        Trees = {Trees}
    end
	if #Trees < 1 then
		return library:Notify("Error!", "No tree(s) selected")
	end
	Requirements.Booleans.IsChopping = true
	Requirements.Booleans.AbortGetTree = false
    if table.find(Trees,"LoneCave") then
        if not Requirements.Funcs.GetTreesLowID("LoneCave") or Requirements.Funcs.GetAxeInfo("Tool","LoneCave").ToolName.Value ~= "EndTimesAxe" then
            table.remove(Trees,table.find(Trees,"LoneCave"))
            library:Notify("Notice", "LoneCave tree not found")
			if not #Trees == 0 then return end 
        end
    end
    Requirements.Connections.TreeAdded = game:GetService("Workspace").LogModels.ChildAdded:Connect(function(v)
        if v:WaitForChild"Owner" and v.Owner.Value == game.Players.LocalPlayer then
            for i = 1,40 do
                game:GetService("ReplicatedStorage").Interaction.ClientIsDragging:FireServer(v)
                v:PivotTo(Requirements.Vars.OldPos)
                task.wait()
            end
           	Requirements.Booleans.TreeCutDown = true
        end
    end)
    for i,v in next,Trees do
		if Requirements.Booleans.AbortGetTree then break end
        for i2 = 1,Amount do
			if Requirements.Booleans.AbortGetTree then break end
            Requirements.Strings.TreeToGet = Requirements.Funcs.GetTreesLowID(v)
			if Requirements.Strings.TreeToGet == false then break end
            if v == "LoneCave" then
				Requirements.Funcs.GodMode()
            end
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Requirements.Strings.TreeToGet.CFrame.p) + Vector3.new(0,0,5)
            repeat
				if Requirements.Booleans.AbortGetTree then break end
                if game:GetService"Players".LocalPlayer.Backpack:FindFirstChild"Tool" then
                    Requirements.Funcs.ChopTree(Requirements.Strings.TreeToGet.Parent.CutEvent,1,0.32,v)
                end
                game:GetService('RunService').Heartbeat:wait()
            until Requirements.Booleans.TreeCutDown
            Requirements.Booleans.TreeCutDown = false
            if v == "LoneCave" then
                task.wait(5)
                game:GetService"Players".LocalPlayer.Character.Head:Destroy()
                game:GetService"Players".LocalPlayer.CharacterAdded:Wait()
                repeat task.wait() until #game:GetService"Players".LocalPlayer.Character:GetChildren() >= 20
            end
            if v == "LoneCave" then break end
            task.wait(1)
        end
    end
    Requirements.Connections.TreeAdded:Disconnect()
    if Loop then Requirements.Funcs.GetTree(Trees, Amount, Loop) end
    game:GetService"Players".LocalPlayer.Character.HumanoidRootPart.CFrame = Requirements.Vars.OldPos
	Requirements.Booleans.IsChopping = false
	library:Notify("Get Tree", "Got selected tree(s) successfully")
end

Requirements.Funcs.OneUnitCutter = function(Value)
	if not Value then Requirements.Connections.PlankReAdded:Disconnect() Requirements.Connections.UnitCutterClick:Disconnect() return end
	Requirements.Connections.PlankReAdded = game:GetService("Workspace").PlayerModels.ChildAdded:Connect(function(v)
		if v:WaitForChild("TreeClass") and v:WaitForChild("WoodSection") then
			Requirements.Strings.ClickedPart = v
			task.wait()
		end
	end)

    Requirements.Connections.UnitCutterClick =  Requirements.Vars.Mouse.Button1Down:Connect(function()
		Requirements.Strings.ClickedPart = Requirements.Vars.Mouse.Target.Parent
		if game:GetService"Players".LocalPlayer.Character:FindFirstChild"Tool" then
			game:GetService"Players".LocalPlayer.Character.Humanoid:UnequipTools()
		end
		if not game:GetService"Players".LocalPlayer.Backpack:FindFirstChild"Tool" then
			return library:Notify("Error!", "You need an axe to use this feature")
		end
		if Requirements.Strings.ClickedPart:FindFirstChild"TreeClass" and Requirements.Strings.ClickedPart.TreeClass.Value ~= "Sign" then
			if Requirements.Strings.ClickedPart.TreeClass.Value == "LoneCave" and Requirements.Funcs.GetAxeInfo("Tool","LoneCave").ToolName.Value ~= "EndTimesAxe" then
				return library:Notify("Error!", "You need an EndTimes Axe to cut this wood")
			end
			Requirements.Funcs.Teleport(CFrame.new(Requirements.Strings.ClickedPart:FindFirstChild"WoodSection".CFrame.p) + Vector3.new(5,1,0))
			repeat 
				if not Requirements.Booleans.UnitCutter then break end
				Requirements.Funcs.ChopTree(Requirements.Strings.ClickedPart:WaitForChild"CutEvent",1,1,Requirements.Strings.ClickedPart.TreeClass.Value)
				if Requirements.Strings.ClickedPart.Parent:FindFirstChild("Cut") then
					Requirements.Funcs.Teleport(Requirements.Strings.ClickedPart:FindFirstChild("Cut").CFrame + Vector3.new(0,3,-3))
				end
				task.wait()
			until Requirements.Strings.ClickedPart:FindFirstChild"WoodSection".Size.X <= 1.88 and Requirements.Strings.ClickedPart:FindFirstChild"WoodSection".Size.Y <= 1.88 and Requirements.Strings.ClickedPart:FindFirstChild"WoodSection".Size.Z <= 1.88
			library:Notify("Unit Cutter", "Finished Cutting")
		end
    end)
end

Requirements.Funcs.AutoChop = function(Value)
    if not Value then Requirements.Connections.AutoCut:Disconnect() Requirements.Connections.AutoCutTreeAdded:Disconnect() return end
    Requirements.Connections.AutoCutTreeAdded = game:GetService("Workspace").LogModels.ChildAdded:Connect(function(v)
        if v:WaitForChild("Owner").Value == game.Players.LocalPlayer then
            Requirements.Booleans.LogAutoChopped = true
        end
    end)
    
    Requirements.Connections.AutoCut = Requirements.Vars.Mouse.Button1Up:Connect(function()
        if Requirements.Vars.Mouse.Target.Name == "WoodSection" then
            if tostring(Requirements.Vars.Mouse.Target.Parent.Owner.Value) == "nil" or game.Players.LocalPlayer.Name then
                Requirements.Strings.ClickedPart = Requirements.Vars.Mouse.Target
				if Requirements.Strings.ClickedPart.Parent:FindFirstChild("TreeClass").Value == "LoneCave" and Requirements.Funcs.GetAxeInfo("Tool","LoneCave").ToolName.Value ~= "EndTimesAxe" then
					return library:Notify("Error!","You need an endtimes axe to cut this tree")
				end
                Requirements.Booleans.AutoCutTarget = Requirements.Strings.ClickedPart.CFrame:pointToObjectSpace(Requirements.Vars.Mouse.Hit.p).Y + Requirements.Strings.ClickedPart.Size.Y/2
                repeat
                    if not Requirements.Config.AutoChop then break end
                    Requirements.Funcs.ChopTree(Requirements.Strings.ClickedPart.Parent.CutEvent,Requirements.Strings.ClickedPart.ID.Value,Requirements.Booleans.AutoCutTarget,Requirements.Strings.ClickedPart.Parent.TreeClass.Value)
                    task.wait()
                until Requirements.Booleans.LogAutoChopped == true
                Requirements.Booleans.LogAutoChopped = false
                if Requirements.Config.AutoChop then library:Notify("Ernestlin","Finished Cutting") end
            end
        end
    end)
end

Requirements.Funcs.GetTreeUnits = function(Value)
	if not Value then return Requirements.Connections.ClickToGetUnits:Disconnect() end
	Requirements.Vars.Mouse = game:GetService("Players").LocalPlayer:GetMouse()
    Requirements.Connections.ClickToGetUnits = Requirements.Vars.Mouse.Button1Down:Connect(function()
        Requirements.Strings.ClickedPart = Requirements.Vars.Mouse.Target
        if Requirements.Strings.ClickedPart.Name == "WoodSection" and Requirements.Strings.ClickedPart.Parent:FindFirstChild("TreeClass") then
			library:Notify("Ernestlin","Calculated "..Requirements.Funcs.CalcUnits(Requirements.Strings.ClickedPart.Parent).." Units")
        end
    end)
end

Requirements.Funcs.SetSawmillState = function(Value)
	Requirements.Vars.Mouse = game:GetService'Players'.LocalPlayer:GetMouse()
	Requirements.Strings.SelectedSawmill = nil
    Requirements.Connections.SawmillSettingsC = Requirements.Vars.Mouse.Button1Down:Connect(function()
        Requirements.Strings.ClickedPart = Requirements.Vars.Mouse.Target
        if Requirements.Strings.ClickedPart.Parent.Name == 'PlayerModels' then
            Requirements.Strings.SelectedSawmill = Requirements.Strings.ClickedPart.Parent
        elseif Requirements.Strings.ClickedPart.Parent.Name == 'Parts' then
            Requirements.Strings.SelectedSawmill = Requirements.Strings.ClickedPart.Parent.Parent
        end
    end)
    repeat task.wait() until tostring(Requirements.Strings.SelectedSawmill) ~= "nil"
    if Requirements.Strings.SelectedSawmill:FindFirstChild("ItemName") and Requirements.Strings.SelectedSawmill.ItemName.Value:sub(1,7) == "Sawmill" then
        for i = 1,20 do
            if not Value then
                game:GetService("ReplicatedStorage").Interaction.RemoteProxy:FireServer(Requirements.Strings.SelectedSawmill.ButtonRemote_XDown)
                task.wait(1)
                game:GetService("ReplicatedStorage").Interaction.RemoteProxy:FireServer(Requirements.Strings.SelectedSawmill.ButtonRemote_YDown)
            else
                game:GetService("ReplicatedStorage").Interaction.RemoteProxy:FireServer(Requirements.Strings.SelectedSawmill.ButtonRemote_XUp)
                task.wait(1)
                game:GetService("ReplicatedStorage").Interaction.RemoteProxy:FireServer(Requirements.Strings.SelectedSawmill.ButtonRemote_YUp)
            end
            task.wait(1)
        end
    end
	library:Notify("Ernestlin","Finished maxing/decreasing settings")
	Requirements.Connections.SawmillSettingsC:Disconnect()
end

Requirements.Funcs.ChopColor = function()
	Workspace.DescendantAdded:Connect(function(v)
		if v.Name == "Cut" then
			v.Color = Requirements.Config.ChopColor
		end
	end)
end
Requirements.Funcs.ChopColor()

Requirements.Funcs.ClickToSell = function(Value)
	if not Value then Requirements.Connections.ClickToSellC:Disconnect() return end
	Requirements.Vars.Mouse = game:GetService"Players".LocalPlayer:GetMouse()
	Requirements.Connections.ClickToSellC = Requirements.Vars.Mouse.Button1Down:Connect(function()
		Requirements.Strings.ClickedPart = Requirements.Vars.Mouse.Target.Parent
		if Requirements.Strings.ClickedPart:FindFirstChild"Owner" and Requirements.Strings.ClickedPart.Owner.Value == game:GetService"Players".LocalPlayer then 
			if Requirements.Strings.ClickedPart:FindFirstChild"TreeClass" and Requirements.Strings.ClickedPart.Name:sub(1,6) == "Loose_" or Requirements.Strings.ClickedPart.Name == "Plank" then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Requirements.Strings.ClickedPart:FindFirstChild("WoodSection").CFrame.p)
				for i = 1,30 do
					game:GetService("ReplicatedStorage").Interaction.ClientIsDragging:FireServer(Requirements.Strings.ClickedPart)
					Requirements.Strings.ClickedPart:PivotTo(game.workspace.Stores.WoodRUs.Furnace:FindFirstChild("Big", true).Parent.CFrame + Vector3.new(0,8,0))
					task.wait()
				end
			end
		end
	end)
end

Requirements.Funcs.MoveLogs = function(Pos,Value)
    if not Requirements.Funcs.FindLogs() then return library:Notify("Error!","Failed to find logs") end
    for i,v in next, game:GetService("Workspace").LogModels:GetChildren() do
        if v:FindFirstChild("Owner") and v.Owner.Value == game.Players.LocalPlayer then
            if not v.PrimaryPart then
                v.PrimaryPart = v:FindFirstChild("WoodSection")
            end
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(v.PrimaryPart.CFrame.p)
			if Value then 
				for i,v in next, v:GetChildren() do
					if v.Name == "WoodSection" then
						local FreezeWood = Instance.new("BodyVelocity", v)
                        FreezeWood.Velocity = Vector3.new(0, 0, 0)
                        FreezeWood.P = 100000
					end
				end
			end
            for i = 1,30 do
				pcall(function()
					game:GetService("ReplicatedStorage").Interaction.ClientIsDragging:FireServer(v)
					v:PivotTo(Pos)
					task.wait()
				end)
            end
            task.wait()
        end
    end
    if Value and Requirements.Funcs.FindLogs() then return Requirements.Funcs.MoveLogs(Pos,Value) end
	if not Requirements.Booleans.AutoFarm then
    	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Requirements.Vars.OldPos
	end
end

Requirements.Funcs.SellPlanks = function()
    if not Requirements.Funcs.FindPlanks() then return library:Notify("Error!","Failed to find planks") end
    Requirements.Vars.OldPos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
    repeat
		pcall(function()
			for i,v in next, game:GetService("Workspace").PlayerModels:GetChildren() do
				if v:FindFirstChild("Owner") and v.Owner.Value == game.Players.LocalPlayer then
					if v:FindFirstChild("TreeClass") and v.TreeClass.Value ~= "Sign" then
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(v:FindFirstChild"WoodSection".CFrame.p) + Vector3.new(5,0,0)
						for i = 1,35 do
							game.ReplicatedStorage.Interaction.ClientIsDragging:FireServer(v)
							v:PivotTo(CFrame.new(314.54, -0.5, 86.823))
							task.wait(.05)
						end
						task.wait()
					end
				end
			end
		end)
        task.wait()
    until not Requirements.Funcs.FindPlanks()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Requirements.Vars.OldPos
    library:Notify("Ernestlin","Sold All Planks")
end

Requirements.Funcs.TreeJointCutter = function(Tree)
    if Tree:FindFirstChild"TreeClass" and Tree.TreeClass.Value == "LoneCave" then
        if not GetAxeInfo("Tool","LoneCave").ToolName.Value ~= "EndTimesAxe" then
            return library:Notify("Error!", "You need an EndTimes axe to cut this tree")
        end
    end
    Requirements.Connections.TreeAdded = game:GetService"Workspace".LogModels.ChildAdded:Connect(function(v)
        if v:waitForChild"Owner" and v.Owner.Value == game.Players.LocalPlayer then
            Requirements.Booleans.TreeCutDown = true
        end
    end)
    
    Requirements.Tables.AllIDS = Requirements.Funcs.GetAllIDs(Tree)
    
    while #Requirements.Tables.AllIDS ~= 0 do
        for i,v in next, Tree:GetChildren() do
            if v.Name == "WoodSection" then
                if v:FindFirstChild"ID" and v.ID.Value == Requirements.Tables.AllIDS[#Requirements.Tables.AllIDS] then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(v.CFrame.p)
                    repeat
                        Requirements.Funcs.ChopTree(v.Parent.CutEvent, Requirements.Tables.AllIDS[#Requirements.Tables.AllIDS], 1, v.Parent.TreeClass.Value)
                        task.wait()
                    until Requirements.Booleans.TreeCutDown == true
                    Requirements.Booleans.TreeCutDown = false
                    table.remove(Requirements.Tables.AllIDS, table.find(Requirements.Tables.AllIDS, Requirements.Tables.AllIDS[#Requirements.Tables.AllIDS]))
                    task.wait(1)
                end
            end
        end
        task.wait()
    end
    library:Notify("Ernestlin", "Finished cutting all branches")
end

Requirements.Funcs.AutoFarm = function(Trees)
	if Requirements.Booleans.IsChopping then
		return library:Notify("Error!", "You are currently getting trees please wait")
	end
	if game.Players.LocalPlayer.Character:FindFirstChild("Tool") then
		game.Players.LocalPlayer.Character.Humanoid:UnequipTools()
	end
	if not game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Tool") or game.Players.LocalPlayer.Character:FindFirstChild("Tool") then
		return library:Notify("Error!", "You need a tool to use this feature")
	end
	if typeof(Trees) ~= "table" then
        Trees = {Trees}
    end
	if #Trees < 1 then
		return library:Notify("Error!", "No tree(s) selected")
	end
	Requirements.Vars.OldPos = game:GetService"Players".LocalPlayer.Character.HumanoidRootPart.CFrame
	Requirements.Booleans.IsChopping = true
    Requirements.Connections.TreeAdded = game:GetService("Workspace").LogModels.ChildAdded:Connect(function(v)
        if v:WaitForChild"Owner" and v.Owner.Value == game.Players.LocalPlayer then
			if v:WaitForChild"TreeClass" and v:WaitForChild"WoodSection" then
           		Requirements.Booleans.TreeCutDown = true
			end
        end
    end)
	while Requirements.Booleans.AutoFarm do
		for it,vt in next, Trees do
			if not Requirements.Booleans.AutoFarm then break end
			Requirements.Strings.TreeToGet = Requirements.Funcs.GetTreesLowID(vt)
			if Requirements.Strings.TreeToGet == false then break end
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Requirements.Strings.TreeToGet.CFrame.p) + Vector3.new(0,0,5)
			repeat
				if not Requirements.Booleans.AutoFarm then break end
                if game:GetService"Players".LocalPlayer.Backpack:FindFirstChild"Tool" then
                    Requirements.Funcs.ChopTree(Requirements.Strings.TreeToGet.Parent.CutEvent,1,0.32,v)
                end
                game:GetService('RunService').Heartbeat:wait()
            until Requirements.Booleans.TreeCutDown
			Requirements.Booleans.TreeCutDown = false
			repeat
				if not Requirements.Booleans.AutoFarm then break end
				for i,v in next, game:GetService("Workspace").LogModels:GetChildren() do
					if not Requirements.Booleans.AutoFarm then break end
					if v:FindFirstChild"Owner" and v.Owner.Value == game:GetService"Players".LocalPlayer then
						if v:FindFirstChild"TreeClass" and v.TreeClass.Value == vt then
							game:GetService"Players".LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(v:FindFirstChild"WoodSection".CFrame.p)
							if not v.PrimaryPart then
								v.PrimaryPart = v:FindFirstChild"WoodSection"
							end
							for i,v in next, v:GetChildren() do
								if v.Name == "WoodSection" then
									local FreezeWood = Instance.new("BodyVelocity", v)
									FreezeWood.Velocity = Vector3.new(0, 0, 0)
									FreezeWood.P = 100000
								end
							end
							for i = 1,35 do
								if not Requirements.Booleans.AutoFarm then break end
								pcall(function()
									game:GetService("ReplicatedStorage").Interaction.ClientIsDragging:FireServer(v)
									v:PivotTo(game.workspace.Stores.WoodRUs.Furnace:FindFirstChild("Big", true).Parent.CFrame + Vector3.new(0,8,0))
									task.wait()
								end)
							end
						end
					end
				end
				task.wait(.05)
			until not Requirements.Funcs.FindLogs()
			task.wait()
		end
		task.wait(.5)
	end
	game:GetService"Players".LocalPlayer.Character.HumanoidRootPart.CFrame = Requirements.Vars.OldPos
	Requirements.Booleans.IsChopping = false
	Requirements.Connections.TreeAdded:Disconnect()
end
  function DropAllTools()
    if #game.Players.LocalPlayer.Backpack:GetChildren() <= 0 then
		return library:Notify("Error!", "You Have 0 Axes in Backpack")
    end;

    for i,v in next,game.Players.LocalPlayer.Backpack:GetChildren() do
        if v.Name == "Tool" then
            game.ReplicatedStorage.Interaction.ClientInteracted:FireServer(v,"Drop tool",game.Players.LocalPlayer.Character.Head.CFrame)
            wait(1)
        end;
    end;
  end;
  function CountAllAxes()
    local count = 0
    if game.Players.LocalPlayer.Character:FindFirstChild("Tool") ~= nil then
        if game.Players.LocalPlayer.Character("Tool") then
            count = count + 1
        end;
    end;
    
    for i,v in next,game.Players.LocalPlayer.Backpack:GetChildren() do
        if v:FindFirstChild("AxeClient") then
            count = count + 1
        end;
    end;
	library:Notify("Notice!","Axes in backpack  "..count)
  end;
  function dupe_load(slot)
    if not game:GetService("ReplicatedStorage").LoadSaveRequests.ClientMayLoad:InvokeServer(game:GetService("Players").LocalPlayer) then
        print("Load Is On cooldown Please Wait")
		library:Notify("Notice!","Load Is On cooldown Please Wait")
        repeat task.wait() until  game:GetService("ReplicatedStorage").LoadSaveRequests.ClientMayLoad:InvokeServer(game:GetService("Players").LocalPlayer)
    end
    if slot then
        skipLoading = true
    end
    game:GetService("ReplicatedStorage").LoadSaveRequests.RequestLoad:InvokeServer(slot,game.Players.LocalPlayer)
    if game:GetService("Players").LocalPlayer.CurrentSaveSlot.Value == slot then
		library:Notify("Notice!","loading slot  "..slot)
    end
  end
  function AxeDupe(Slot)
    if #game.Players.LocalPlayer.Backpack:GetChildren() <= 0 then
       return library:Notify("Error!", "You Have 0 Axes in Backpack")
    end;
    
    local Slot = slotnumber
    repeat wait() until game.ReplicatedStorage.LoadSaveRequests.ClientMayLoad:InvokeServer(game.Players.LocalPlayer)
    game.Players.LocalPlayer.Character.Head:Destroy()
    wait(2.5)
    dupe_load(Slot)
    game:GetService("ReplicatedStorage").LoadSaveRequests.RequestLoad:InvokeServer(Slot,game:GetService("Players").LocalPlayer)
    repeat task.wait() until game:GetService("Players").LocalPlayer.OwnsProperty.Value == true
    repeat task.wait() until game:GetService("ReplicatedStorage").LoadSaveRequests.ClientMayLoad:InvokeServer(game:GetService("Players").LocalPlayer)
    wait(0.5)
  end
--Settings begin
	Tab = UI:CreateTab("Settings","6031280882")
		Section = Tab:CreateSection("UI")
		Section:Button("Destroy UI",function()
		DestroyUI()
	end)
	Section:KeyBind("Toggle UI",Requirements.Config.HideUI,function(Value)
		Requirements.Config.HideUI = Value
		HideUi()
	end)
	Section:Toggle("Save Config",Requirements.Config.AutoSaveConfig,function(Value)
		Requirements.Config.AutoSaveConfig = Value
			if Value then
				task.spawn(function()
				while Requirements.Config.AutoSaveConfig do
					if isfile("ErnestlinV2Config.txt") then
					writefile("ErnestlinV2Config.txt", game:GetService("HttpService"):JSONEncode(Requirements.Config))
					end
				task.wait(1)
			end
		end)
	end

	Section = Tab:CreateSection("Slot Names Not Added")
		Section = Tab:CreateSection("Game")
			Section:Toggle("Dark Mode",Requirements.Config.UIMode,function(Value)
				Requirements.Config.UIMode = Value
				Requirements.Funcs.GameMenuTheme(Value and Color3.fromRGB(0,0,0) or Color3.fromRGB(225,225,225), Value and Color3.fromRGB(225,225,225) or Color3.fromRGB(0,0,0))
			end)
			Section:Button("Rejoin Game",function()
			game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId,game.JobId, game.Players.LocalPlayer)
		end)
	end)
	----auto buy
	local CancelActions;
  local Player = game.Players.LocalPlayer
  local ReplicatedStorage = game:GetService("ReplicatedStorage")  local GetChar = function()
    if Player.Character == nil then
        repeat task.wait() until Player.Character ~= nil
        return Player.Character
    else
        return Player.Character
    end
  end
  local TeleportReliablity = 30
  local OldCharacterPos;
  
  BringObject = function(Model, Position, TeleportSettings)
    if not Player.Character then return end
    
    local Character = Player.Character
    
    local ToTeleportBeforeBringing = TeleportSettings[1]
    local ToTeleportAfterBringing  = TeleportSettings[2]
    
    if not Model.PrimaryPart then
        Model.PrimaryPart = Model:FindFirstChild("Main") or Model:FindFirstChild("WoodSection") 
    end    
    
    if not Model.PrimaryPart then return end
    
    if ToTeleportBeforeBringing then
        Character.HumanoidRootPart.Anchored = true
        for i = 1,10 do
            Character.Humanoid.Sit = false
            if (Character.HumanoidRootPart.Position - Model.PrimaryPart.Position).Magnitude > 17 then
                Character:SetPrimaryPartCFrame(CFrame.new(Model.PrimaryPart.Position + Vector3.new(5,3,5))) 
            end
            game:GetService("RunService").Stepped:Wait()
        end
        Character.HumanoidRootPart.Anchored = false
    end
    
    for i = 1,TeleportReliablity do
        if not Model.PrimaryPart then break end
        Character.Humanoid.Sit = false    
            
        game:GetService("ReplicatedStorage").Interaction.ClientIsDragging:FireServer(Model)
        Model:SetPrimaryPartCFrame(Position)
        game:GetService("ReplicatedStorage").Interaction.ClientIsDragging:FireServer(Model)
        
        for _,v in pairs(Model:GetChildren()) do
            if v:IsA("BasePart") or v:IsA("Part") then
                v.Velocity = Vector3.new(0,15,0)
                v.RotVelocity = Vector3.new(0,0,0)
            end    
        end
        game:GetService("RunService").Stepped:Wait()
    end
    
    wait(0.1)
    
    if ToTeleportAfterBringing then
        task.spawn(function()
            for i = 1,10 do
                Character:SetPrimaryPartCFrame(OldCharacterPos + Vector3.new(0,5,0))
                Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
                Character.HumanoidRootPart.RotVelocity = Vector3.new(0,0,0)
                task.wait()
            end
        end)
    end    
  end
  
  
  
  local Counters = {
    ["Thom"] = Vector3.new(268, 2, 67.4);
    ["Bob"] = Vector3.new(260, 7.2, -2551);
    ["Corey"] = Vector3.new(477, 2.4, -1722);
    ["Jenny"] = Vector3.new(528, 2.4, -1459);
    ["Timothy"] = Vector3.new(5238, -167.2, 740);
    ["Lincoln"] = Vector3.new(4595, 6.2, -785);
  }
  
  local StoreOwnerIDs = {
    ["Thom"] = 7;
    ["Bob"] = 10;
    ["Corey"] = 8;
    ["Jenny"] = 9;
    ["Timothy"] = 11;
    ["Lincoln"] = 12;
  }
    
  local StoreOwnerPositions = {
    ["Thom"] = Vector3.new(262.4, 2.99929, 70.3);
    ["Bob"] = Vector3.new(255.351, 8.39809, -2553.31);
    ["Corey"] = Vector3.new(472.8, 3.798523, -1716.7);
    ["Jenny"] = Vector3.new(532.11, 3.798914, -1465.63);
    ["Timothy"] = Vector3.new(5232.4, -166.201, 742.9);
    ["Lincoln"] = Vector3.new(4591.8, 7.59853, -782.101);
  }
  
  function GetPrice(Name)
    if ReplicatedStorage.ClientItemInfo:FindFirstChild(Name) then
        return ReplicatedStorage.ClientItemInfo[Name].Price.Value
    else
        print("Could not find Item")
    end    
  end 
  
  function GetItem(Name)
    local Items = {}
    for _,v in pairs(workspace.Stores:GetDescendants()) do
        if v:IsA("StringValue") and v.Name == "BoxItemName" then
            --if Name ~= "Wire" then
                if v.Value == Name then
                    table.insert(Items, v.Parent) 
                end
           -- elseif Name == "Wire" then
                
            --end    
        end
    end
    return Items
  end
  
  function GetClosestStoreOwner(BasePos)
    local ClosestStoreOwner
    local TargetDistance = math.huge
    
    for i,v in pairs(StoreOwnerPositions) do
        Distance = (BasePos - v).Magnitude
        if Distance < TargetDistance then
            TargetDistance = Distance
            ClosestStoreOwner = i
        end
    end
    
    return ClosestStoreOwner
  end   
  
  function PurchaseItem(ID)
    ReplicatedStorage.NPCDialog.PlayerChatted:InvokeServer({
        ["Character"] = "",
        ["Name"] = "",
        ["ID"] = ID,
        ["Dialog"] = ""
    },"ConfirmPurchase")
  end
  
  function BuyItem(Item,Amount,Position)
    local ToBuyFrom
    local MerchantID
    
    for i = 1,Amount do
        if CancelActions then CancelActions = false return end
        
        if GetItem(Item)[1]:FindFirstChild("Main") then
            local Item = GetItem(Item)[1]
            local ItemName = Item.BoxItemName.Value
   
            
            if not ToBuyFrom then
                ToBuyFrom = GetClosestStoreOwner(Item.Main.Position) 
            end
            
            if not MerchantID then
                for i,v in pairs(StoreOwnerIDs) do
                    if i == ToBuyFrom then
                        MerchantID = v 
                    end    
                end
            end
            BringObject(Item, CFrame.new(Counters[ToBuyFrom]), {true, false})
            PurchaseItem(MerchantID)
            
            game.StarterGui:SetCore("SendNotification", {
                Title = "Count";
                Text = tostring(i).."/"..tostring(Amount).." "..ItemName.."'s Bought";
                Duration = 1;
            })
            BringObject(Item, Position, {true, false})
            
        end    
    end
    CancelActions = false
  end    
  
  local ItemToBuy
  local AmountToBuy = 1
  
  for _,v in pairs(game:GetService("ReplicatedStorage").ClientItemInfo:GetChildren()) do
    if v:IsA("Folder") then
        for _,x in pairs(workspace.Stores:GetDescendants()) do -- check if you can purchase
            if x.Name == "BoxItemName" then
                if x.Value == v.Name and not table.find(ItemList, v.Name) then
                    table.insert(ItemList, v.Name)    
                end    
            end    
        end    
    end    
  end
  local BuyListDropdown
  local CheckIfWPPlaced = function()
    if TPToWPorPLR == false then 
        local WayPointPart = Instance.new("Part")
        if not WayPointPart then 
            game.StarterGui:SetCore("SendNotification", {
                Title = "Notice";
                Text = "Please place a waypoint";
                Duration = 1;
            })
            return false 
        end 
    else
        return true 
    end    
    
    return true
  end
  
  local GetWPLoc = function()
    
    if WayPointPart then
        if TPToWPorPLR == false then -- wp
            return WayPointPart.CFrame
        else
            return GetChar().Head.CFrame
        end
    else
        return GetChar().Head.CFrame
    end    
  end  
	--------------------------------------------------
Tab = UI:CreateTab("World","7709849714")
Section = Tab:CreateSection("World")
Section:Toggle("Always Day",Requirements.Config.AlwaysDay,function(Value)
			Requirements.Config.AlwaysDay = Value
			Requirements.Funcs.AlwaysDay(Value)
		end)
 Section:Toggle("Always Night",Requirements.Config.AlwaysNight,function(Value)
			Requirements.Config.AlwaysNight = Value
			Requirements.Funcs.AlwaysNight(Value)
		end)
Section:Toggle("No Fog",Requirements.Config.NoFog,function(Value)
			Requirements.Config.NoFog = Value
			Requirements.Funcs.NoFog(Value)
		end)
Section:Toggle("Spook",Requirements.Config.Spook,function(Value)
			Requirements.Config.Spook = Value
			Requirements.Funcs.Spook(Value)
		end)
Section:Toggle("Better Graphics",Requirements.Config.BetterGraphics,function(Value)
			Requirements.Config.BetterGraphics = Value
			Requirements.Funcs.BetterGraphics(Value)
		end)
-----------------------------------------------------------------
Tab = UI:CreateTab("Plot","7794285284")
Section = Tab:CreateSection("Load Slot")
		Section:Slider("Slot Number",1,1,6,false,function(Value)
			Requirements.Strings.SlotNumber = Value
		end)
		Section:Button("Load Slot",function()
			Requirements.Funcs.LoadSlot(Requirements.Strings.SlotNumber)
		end)
		Section:Button("Unload Current Slot",function()
			if game:GetService("Players").LocalPlayer.CurrentSaveSlot.Value ~= -1 then
				Requirements.Funcs.LoadSlot(math.huge)
			else
				library:Notify("Error!", "You do not currently have a slot loaded")
			end
		end)
		Section:Toggle("Fast Load",Requirements.Config.FastLoad,function(Value)
			Requirements.Config.FastLoad = Value
		end)
		Section = Tab:CreateSection("New Slots")
		Section:Button("Free Land",function()
			Requirements.Funcs.FreeLand()
		end)
		Section:Button("Max Land",function()
			Requirements.Funcs.MaxLand()
		end)
		Section:Button("Sell Sold Sign",function()
			Requirements.Funcs.SellSign()
		end)
		Section = Tab:CreateSection("Whitelisting")
		Requirements.Tables.UIVars.AWL = Section:Toggle("Auto Whitelist",Requirements.Config.AutoWL,function(Value)
			Requirements.Funcs.AutoWhiteList(Value)
			Requirements.Config.AutoWL = Value
		end)
		Requirements.Tables.UIVars.ABL = Section:Toggle("Auto Blacklist",Requirements.Config.AutoBL,function(Value)
			Requirements.Funcs.AutoBlacklist(Value)
			Requirements.Config.AutoBL = Value
		end)
		Section:Button("Anti-Blacklist",function()
			Requirements.Funcs.AntiBL()
		end)
----------------------------------------------------------------
Tab = UI:CreateTab("Player","6022668898")
		Section = Tab:CreateSection("Movement")
	 	Section:Slider("Speed Walk",Requirements.Config.Walkspeed,16,50,300,false,function(Value)
			Requirements.Config.Walkspeed = Value
			Requirements.Funcs.WalkSpeed(Value)
 		 end)
		Section:Slider("Jump Power",Requirements.Config.JumpPower,50,300,false,function(Value)
			Requirements.Config.JumpPower = Value
			Requirements.Funcs.JumpPower(Value)
		end)
		Section:Slider("Sprint Speed",Requirements.Config.SprintSpeed,50,300,false,function(Value)
			Requirements.Config.SprintSpeed = Value
		end)

		Section:KeyBind("Sprint Key",Requirements.Config.SprintKey,function(Value)
			Requirements.Config.SprintKey = Value
		end)
		Section:Toggle("Infinite Jump",Requirements.Config.InfJump,function(Value)
			Requirements.Config.InfJump = Value
			Requirements.Funcs.InfJump(Value)
		end)
		Section:KeyBind("Fly", Requirements.Config.FlyKey,function(Value)
			Requirements.Config.FlyKey = Value
			Requirements.Booleans.Flying = not Requirements.Booleans.Flying
			Requirements.Funcs.PlayerFly(Requirements.Booleans.Flying)
		end)
		--Section:Slider("Fly Speed",Requirements.Config.FlySpeed,50,500,false,function(Value)
		--	Requirements.Config.FlySpeed = Value
		--end)
		Section:KeyBind("NoClip",Requirements.Config.NoClipKey,function(Value)
			Requirements.Config.NoClipKey = Value
			Requirements.Booleans.isClipping = not Requirements.Booleans.isClipping
			Requirements.Funcs.NoClip(Requirements.Booleans.isClipping)
		end)
		Section = Tab:CreateSection("Player")
		Section:Toggle("Invisible",false,function(Value)
			Requirements.Funcs.Invisable(Value)
		end)
		Section:Toggle("Drag Mod",Requirements.Config.DragMod,function(Value)
			Requirements.Config.DragMod = Value
		end)
		Section:Toggle("Anti-AFK",Requirements.Config.AntiAFK,function(Value)
			Requirements.Config.AntiAFK = Value
			Requirements.Funcs.AntiAFK(Value)
		end)
		Section:Button("BTools",function()
			Requirements.Funcs.BTools()
		end)
		Section:Button("Safe Suicide",function()
			Requirements.Funcs.SafeSuicide()
		end)
		Section = Tab:CreateSection("Teleports")
		Section:DropDown("Waypoints",{"The Den", "Lighthouse", "Safari", "Bridge", "Bob's Shack", "EndTimes Cave", "The Swamp", "The Cabin", "Volcano", "Boxed Cars", "Tiaga Peak", "Land Store", "Link's Logic", "Palm Island", "Palm Island 2", "Fine Art Shop", "SnowGlow Biome", "Cave", "Shrine Of Sight", "Fancy Furnishings", "Docks", "Strange Man", "Wood Dropoff", "Snow Biome", "Wood RUs", "Green Box", "Spawn", "Cherry Meadow", "Bird Cave",},true,function(Value)  
			Requirements.Funcs.Teleport(Requirements.Tables.WaypointsPositions[Value])
		end)
		Section:PlrList("Teleport To Player",true,false,function(Value)
			Requirements.Funcs.TeleportToPlayer(Value)
		end)
		Section:PlrList("Teleport To Player's Plot",true,true,function(Value)
			Requirements.Funcs.TeleportToPlayersBase(Value)
		end)
		Section:KeyBind("Teleport Key",Requirements.Config.TeleportKey,function(Value)
			Requirements.Config.TeleportKey = Value
			Requirements.Vars.Mouse = game.Players.LocalPlayer:GetMouse()
				if Requirements.Vars.Mouse.Target ~= nil then
					Requirements.Funcs.Teleport(CFrame.new(Requirements.Vars.Mouse.Hit.p) + Vector3.new(0,5,0))
				end
		end)
------------------------------------------------------------------------
Tab = UI:CreateTab("Wood","8594844067")
Section = Tab:CreateSection("Get Tree")
	Section:Slider("Amount",1,1,30,false,function(Value)
		Requirements.Strings.GetTreeAmount = Value
	end)
	Section:MultiDropDown("Select Tree",{"Oak", "Generic", "Cherry", "Birch", "Volcano", "GoldSwampy", "GreenSwampy", "Walnut", "Palm", "Fir", "Pine", "SnowGlow", "Frost", "Koa", "CaveCrawler", "LoneCave", "Spooky","SpookyNeon"},function(Value)
		Requirements.Strings.SelectedTreeToGet = Value
	end)
	Section:Toggle("Loop Get Tree",false,function(Value)
		Requirements.Booleans.LoopGetTree = Value
	end)
	Requirements.Tables.UIVars.GSTB = Section:Button("Get Selected Tree(s)",function()
		if Requirements.Tables.UIVars.GSTB:GetTxt() == "Get Selected Tree(s)" then
			Requirements.Tables.UIVars.GSTB:ChangeText("Abort Cutting")
			Requirements.Vars.OldPos = game:GetService"Players".LocalPlayer.Character.HumanoidRootPart.CFrame
			Requirements.Funcs.GetTree(Requirements.Strings.SelectedTreeToGet, Requirements.Strings.GetTreeAmount, Requirements.Booleans.LoopGetTree)
			Requirements.Tables.UIVars.GSTB:ChangeText("Get Selected Tree(s)")
			------------------------------------------------------------------------------------
			Requirements.Vars.OldPos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
		Requirements.Funcs.MoveLogs(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame,false)		
---------------------added to return tree
		else
			Requirements.Booleans.AbortGetTree = true
			Requirements.Tables.UIVars.GSTB:ChangeText("Get Selected Tree(s)")
		end
	end)	
	Section = Tab:CreateSection("Auto Farm chop and sell")
	Section:MultiDropDown("Select Tree",{"Oak", "Generic", "Cherry", "Birch", "Volcano", "GoldSwampy", "GreenSwampy", "Walnut", "Palm", "Fir", "Pine", "SnowGlow", "Frost", "Koa", "CaveCrawler",},function(Value)
		Requirements.Strings.TreesToFarm = Value
	end)
	Section:Toggle("Farm",false,function(Value)
		Requirements.Booleans.AutoFarm = Value
			if Value then Requirements.Funcs.AutoFarm(Requirements.Strings.TreesToFarm) end
		end)
		Section = Tab:CreateSection("Tree snd Plank Functions")
	Section:Toggle("Calculate Tree Units",false,function(Value)
		Requirements.Funcs.GetTreeUnits(Value)
	end)
	Section:Toggle("Click To Sell",false,function(Value)
		Requirements.Funcs.ClickToSell(Value)
	end)
	Section:Button("Sell All Logs",function()
		Requirements.Vars.OldPos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
		Requirements.Funcs.MoveLogs(game.workspace.Stores.WoodRUs.Furnace:FindFirstChild("Big", true).Parent.CFrame + Vector3.new(0,8,0),true)
	end)
	Section:Button("Bring All Logs",function()
		Requirements.Vars.OldPos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
		Requirements.Funcs.MoveLogs(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame,false)
	end)
	Section:Button("Sell All Planks",function()
		Requirements.Funcs.SellPlanks()
	end)
	Section:Toggle("Auto Chop",Requirements.Config.AutoChop,function(Value)
		Requirements.Config.AutoChop = Value
		Requirements.Funcs.AutoChop(Value)
	end)
	Section:ColorPicker("Chop Line Color",Requirements.Config.ChopColor,function(Value)
		Requirements.Config.ChopColor = Value
	end)
Section:Button("Cut Tree Joints",function()
		library:Notify("Ernestlin", "Click to select a tree")
		Requirements.Vars.Mouse = game:GetService"Players".LocalPlayer:GetMouse()
		Requirements.Connections.TJC = Requirements.Vars.Mouse.Button1Down:Connect(function()
		Requirements.Strings.ClickedPart = Requirements.Vars.Mouse.Target
			if Requirements.Strings.ClickedPart.Parent:FindFirstChild"Owner" and Requirements.Strings.ClickedPart.Parent.Owner.Value == game.Players.LocalPlayer then
				if Requirements.Strings.ClickedPart.Parent:FindFirstChild"TreeClass" and Requirements.Strings.ClickedPart.Parent.TreeClass.Value ~= "Sign" then
					if Requirements.Strings.ClickedPart.Parent.Parent.Name == "LogModels" then
						Requirements.Strings.TreeToJointCut = Requirements.Strings.ClickedPart.Parent
					end
				end
			end
			task.spawn(function()
			Requirements.Funcs.TreeJointCutter(Requirements.Strings.TreeToJointCut)
		end)
	Requirements.Connections.TJC:Disconnect()
	end)
end)

function getMouseTarget()
	local cursorPosition = game:GetService("UserInputService"):GetMouseLocation()
	return workspace:FindPartOnRayWithIgnoreList(Ray.new(workspace.CurrentCamera.CFrame.p,(workspace.CurrentCamera:ViewportPointToRay(cursorPosition.x, cursorPosition.y, 0).Direction * 1000)),game.Players.LocalPlayer.Character:GetDescendants())
end
--------
function FillBP (value)
loadstring(game:HttpGet("https://raw.githubusercontent.com/ErnestlinBuild/scripts/main/AutoFill.txt"))()
end
----------------------------------------------------------------
Tab = UI:CreateTab("Tools","7201461214")
Section = Tab:CreateSection("Hackers Building Tool")
	Section:Button("Building Tool",function()		 
		 local Func = loadstring(game:HttpGet("https://raw.githubusercontent.com/ErnestlinBuild/scripts/main/help3.txt"))()
			loadstring(Script .. Func("oddyblood"))()			
	end)
	Section:Toggle("One Unit Cutter",false,function(Value)
		Requirements.Booleans.UnitCutter = Value
		Requirements.Funcs.OneUnitCutter(Value)
	end)
Section = Tab:CreateSection("Auto Blueprint Filler")
local WoodPlayer
local WoodLst
local AbortFiler = false
function MeasurePing()
		local time = tick()
		game:GetService("ReplicatedStorage"):WaitForChild("TestPing"):InvokeServer()
		return tick() - time
	end
Section:PlrList("Select player to fill",true,true,function(Value)		 
        WoodPlayer = Value
		end)
		for i,v in pairs(Requirements.Tables.WoodList ) do
		WoodLst = v
		end
Section:MultiDropDown("Select Tree",{"Oak", "Generic", "Cherry", "Birch", "Volcano", "GoldSwampy", "GreenSwampy", "Walnut", "Palm", "Fir", "Pine", "SnowGlow", "Frost", "Koa", "CaveCrawler", "LoneCave", "Spooky","SpookyNeon"},function(Value) 
	  for i,v in pairs(Value) do
	   Requirements.Strings.SelectedTreeToGet = v	  
	  end
	end)
	local start = Section:Button("Start filling BPrints",function(Value)
while true do
        if AbortFiler then AbortFiler = false break end
        AbortFiler = false 
        task.wait(1) 
        for i, v in pairs(game.Workspace.PlayerModels:GetChildren()) do
            if v:FindFirstChild("Owner") and v.Owner.Value ~= nil and v.Owner.Value == game.Players[WoodPlayer] then            
			  if v:FindFirstChild("TreeClass") and v.TreeClass.Value == Requirements.Strings.SelectedTreeToGet then
                    local Freeze, Pos = Instance.new("BodyVelocity", v), Instance.new("BodyPosition", v)
                    Freeze.Velocity = Vector3.new(0, 0, 0)
                    Freeze.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                    Freeze.P = 9000
                    Pos.MaxForce = Vector3.new(0, 0, 0)
                    Pos.P = 100000
                    Wood = v
                end
            end
        end
        for _, z in pairs(game.Workspace.PlayerModels:GetChildren()) do
				if z:FindFirstChild("Owner") and z.Owner.Value == game.Players.LocalPlayer then
					if z:FindFirstChild("BuildDependentWood") then
						if z:FindFirstChild("Type") and z.Type.Value == "Blueprint" then 
                            BP = z
						end
					end
				end
			end
                            MeasurePing()
                            task.wait(0.4)
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Wood.WoodSection.CFrame
                            MeasurePing()
                            task.wait(0.4)
                            game:GetService("ReplicatedStorage").Interaction.ClientIsDragging:FireServer(Wood)
                            MeasurePing()
                            Wood.WoodSection.CFrame = BP.BuildDependentWood.CFrame
                            task.wait()
                            MeasurePing()
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = BP.BuildDependentWood.CFrame
        end
	 
	end)
	Section:Button("Abort Filler",function(Value)		 
		  Requirements.Booleans.AbortFiler = Value
		game.ReplicatedStorage.Notices.SendUserNotice:Fire('Filler Abort')
	end)
-----begin autobuy

Tab = UI:CreateTab("Auto Buy","7714189116")
Section = Tab:CreateSection("Auto Buy Items")
Section:Slider("Amount",1,1,25,false,function(Value)
    AmountToBuy = Value
 end)
 Section:MultiDropDown("Select Item",Requirements.Funcs.GetShopItems(),function(Value)
 for i,v in pairs(Value) do
	   Requirements.Strings.AutoBuyItem = v	  
	  end
end)
 Requirements.Tables.UIVars.ABB = Section:Button("Purchase Item(s)",function()
	 if not CheckIfWPPlaced() then return end
		if Requirements.Strings.AutoBuyItem then               
		CuttingTree = true
		local OldCharacterPos = GetChar().Head.CFrame
		
		BuyItem(Requirements.Strings.AutoBuyItem,AmountToBuy,GetWPLoc())
		CuttingTree = false
		IsStandingAPlank = false
		GetChar():SetPrimaryPartCFrame(OldCharacterPos)
	else
		game.StarterGui:SetCore("SendNotification", {
			Title = "Error";
		Text = "Please select an item to buy";
			Duration = 5;
		})
	end  
end)
Section = Tab:CreateSection("Other Auto Buy options")
 
------------------------------------------------------------------->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
Section:Button("Purchase All BluePrints",function()
	if #game:GetService("Players").LocalPlayer.PlayerBlueprints.Blueprints:GetChildren() >= 69 then return library:Notify("Error!","You already own all blueprints") end
	if game:GetService"Players".LocalPlayer.leaderstats.Money.Value >= Requirements.Funcs.GetTotalPrice(Requirements.Funcs.GetBlueprints(), 1) then
		Requirements.Funcs.AutoBuy(Requirements.Funcs.GetBlueprints(), 1, false, true, false)
	else
		library:Notify("Error!", "You need $"..Requirements.Funcs.GetTotalPrice(Requirements.Funcs.GetBlueprints(),1).." more to purchase all blueprints")
	end
end)
Section = Tab:CreateSection("Auto Pay options")
Section:Button("Toll Bridge - $100",function()
	Requirements.Funcs.MiscBuy(14, "100", "Toll Bridge")
end)

Section:Button("Ferry Ticket - $400",function()
	Requirements.Funcs.MiscBuy(13, "400", "Ferry Ticket")
end)
Section = Tab:CreateSection("Power Build")
Section:Button("Build Power Cost - $10Mill",function()
	Requirements.Funcs.MiscBuy(3, "10009000", "Power To Build With Ease")
end)
Tab = UI:CreateTab("Base Tools","8558464342")
 Section = Tab:CreateSection("Base Sorter")
Section:Slider("How many Wide?", 1, 1, 50,false,function(Value)
	Requirements.Vars.boxSizeX = value
end)
Section:Slider("How many thick?" , 1, 1, 50, false,function(Value)
	Requirements.Vars.boxSizeY = value 
end)
Section:Toggle("Boxes or Axes?",function(Value)
	if Value then
		Requirements.Vars.boxType = 'Axes'
	else
				Requirements.Vars.boxType = 'Boxes'
	end
end)
 
Section:Button("Select the item you want to sort",function()

		Requirements.Vars.sortBoxesButton = Value
		Requirements.Tables.sortItems = {}
		count = 0
		for i, v in pairs(game.Workspace.PlayerModels:GetChildren()) do
			if v:FindFirstChild('SelectionBox') then
				v.SelectionBox:Destroy()
			end
		end	
 
		pcall(function() Requirements.Connections.getItems:Disconnect() end)
		pcall(function() Requirements.Connections.boxSortPosition:Disconnect() end)
		pcall(function() Requirements.Connections.cancelBox:Disconnect() end)
		pcall(function() Requirements.Connections.placeBoxSort:Disconnect() end)
 
		--Requirements.Vars.Mouse = game:GetService("Players").LocalPlayer:GetMouse()
		getItems = Requirements.Vars.Mouse.Button1Up:Connect(function()	
			Requirements.Strings.target = Requirements.Vars.Mouse.Target	 
			if Requirements.Strings.target.Parent:FindFirstChild('PurchasedBoxItemName') or Requirements.Strings.target.Parent.Type.Value == "Tool" or Requirements.Strings.target.Parent.Type.Value == "Gift" or Requirements.Strings.target.Parent.Type.Value == "Loose Item" then 
				if Requirements.Strings.target.Parent:FindFirstChild('Owner') and Requirements.Strings.target.Parent.Owner.Value == game.Players.LocalPlayer or game.ReplicatedStorage.Interaction.ClientIsWhitelisted:InvokeServer(Requirements.Strings.target.Parent.Owner.Value) then
					for i, v in pairs(game.Workspace.PlayerModels:GetChildren()) do  
						if v.Name == Requirements.Strings.target.Parent.Name and (v:FindFirstChild('Owner') and (v.Owner.Value == game.Players.LocalPlayer or game.ReplicatedStorage.Interaction.ClientIsWhitelisted:InvokeServer(v.Owner.Value))) then
							if not table.find(Requirements.Tables.sortItems, v.Parent) then
								if Requirements.Vars.boxType == 'Axes' and v:FindFirstChild('ToolName')then
									game:GetService("ReplicatedStorage").Interaction.ClientRequestOwnership:FireServer(v)
									local selItem = Instance.new("SelectionBox")
							
									selItem.Parent = v
									selItem.Color3 = Color3.fromRGB(255, 16, 240)
									selItem.Adornee = v
									selItem.LineThickness = 0.05
									table.insert(Requirements.Tables.sortItems, v)
								elseif Requirements.Vars.boxType == 'Boxes' and ((v:FindFirstChild('PurchasedBoxItemName') or v.Type.Value == 'Gift') or (v.Name == 'Candy')) then						
									game:GetService("ReplicatedStorage").Interaction.ClientRequestOwnership:FireServer(v)
									local selItem = Instance.new("SelectionBox")
									selItem.Parent = v
								
									selItem.Color3 = Color3.fromRGB(255, 16, 240)
									selItem.Adornee = v
									selItem.LineThickness = 0.05
									table.insert(Requirements.Tables.sortItems, v)				
								end						
							end
						end
					end
					pcall(function()  Requirements.Connections.getItems:Disconnect() end)
					if Requirements.Tables.sortItems[1] then
						local maxRow = Requirements.Vars.boxSizeX
						local maxColumn = Requirements.Vars.boxSizeY
						local maxHeight = 1
						local preview = Instance.new('Part', game.Workspace)
						preview.Name = 'Preview'
						preview.Anchored = true
						preview.Transparency = 1
						preview.CanCollide = false                  
						local previewBox = Instance.new('SelectionBox',preview)
						preview.SelectionBox.LineThickness = 0.05
						
						while wait() do
							if #Requirements.Tables.sortItems <= vRequirements.Vars.boxSizeX * Requirements.Vars.boxSizeY * maxHeight then
								break
							else
								maxHeight = maxHeight + 1
							end
						end
						preview.Size = Vector3.new(Requirements.Tables.sortItems[1].Main.Size.X * maxColumn, Requirements.Tables.sortItems[1].Main.Size.Y * maxHeight,  Requirements.Tables.sortItems[1].Main.Size.Z * maxRow)
						previewBox.Adornee = preview
						local yy
						if maxHeight == 1 then
							yy = -preview.Size.Y
						else
							yy = -(preview.Size.Y - Requirements.Tables.sortItems[1].Main.Size.Y/2)
						end
						local yyy = 0
						if maxHeight > 2 then
							yyy = (maxHeight - 2) * Requirements.Tables.sortItems[1].Main.Size.Y/2
						end
						local previewBoxPos = preview.Position + Vector3.new(-(preview.Size.X/2 + Requirements.Tables.sortItems[1].Main.Size.X/2), yy + yyy,-(preview.Size.Z/2 + Requirements.Tables.sortItems[1].Main.Size.Z/2))
						local itemIndex2 = 1
						for y = 1, maxHeight do
							for x = 1, maxColumn do
								for z = 1, maxRow do
									if  Requirements.Tables.sortItems[itemIndex2] then
										local item =  Requirements.Tables.sortItems[itemIndex2]:Clone()
										item.Parent = preview
										item.Main.CanCollide = false
										item.Main.Orientation = Vector3.new(0,0,-1)
										item.Main.Position = Vector3.new(previewBoxPos.X + x * (Requirements.Tables.sortItems[1].Main.Size.X), previewBoxPos.Y + y * (Requirements.Tables.sortItems[1].Main.Size.Y), previewBoxPos.Z + z * (Requirements.Tables.sortItems[1].Main.Size.Z))
										item.Main.Transparency = 0.7
										if item.Main:FindFirstChild('ItemImage') then
											for i,v in pairs(item.Main:GetChildren()) do
												if v.Name == 'ItemImage' then
													v.Transparency = 0.7
												end
											end
										end
										item.SelectionBox:Destroy()
										local weld = Instance.new('WeldConstraint', item)
										weld.Part0 = item.Main
										weld.Part1 = preview
										itemIndex2 = itemIndex2 + 1
									end
								end
							end
						end
						pcall(function() getItems:Disconnect() end)
						Requirements.Vars.Mouse = game:GetService("Players").LocalPlayer:GetMouse()
						Requirements.Connections.cancelBox = Requirements.Vars.Mouse.Button2Up:Connect(function()
							if game.Workspace:FindFirstChild('Preview') then
								game.Workspace.Preview:Destroy()
								pcall(function() Requirements.Connections.cancelBox:Disconnect() end)
								pcall(function() Requirements.Connections.placeBoxSort:Disconnect() end)
								pcall(function() Requirements.Connections.boxSortPosition:Disconnect() end)
									for i, v in pairs(Requirements.Tables.sortItems) do
										pcall(function() v.SelectionBox:Destroy() end)
									end
								Requirements.Tables.sortItems = {}
								SendNotification('Box sort has been canceled.')
							end
						end)
						Requirements.Vars.Mouse = game:GetService("Players").LocalPlayer:GetMouse()
						Requirements.Connections.boxSortPosition = Requirements.Vars.Mouse.Move:Connect(function()
                            Requirements.Vars.Mouse.TargetFilter = preview
                            local hit = Requirements.Vars.Mouse.Hit.Position
                            if Requirements.Vars.Mouse.Target.Name ~= 'Ground' then
                                preview.CFrame = CFrame.new(hit.X - preview.Size.X/2, hit.Y + preview.Size.Y/2, hit.Z - preview.Size.Z/2)
                            end
                        end)
						Requirements.Vars.Mouse = game:GetService("Players").LocalPlayer:GetMouse()
						Requirements.Connections.placeBoxSort = Requirements.Vars.Mouse.Button1Down:Connect(function()
							pcall(function()Requirements.Connections.boxSortPosition:Disconnect() end)
							local pos = preview.CFrame + Vector3.new(-(preview.Size.X/2 + Requirements.Tables.sortItems[1].Main.Size.X/2), yy + yyy,-(preview.Size.Z/2 + Requirements.Tables.sortItems[1].Main.Size.Z/2))
							local itemIndex = 1
							for y = 1, maxHeight do
                                for x = 1, maxColumn do
                                    for z = 1, maxRow do
                                        if Requirements.Tables.sortItems[itemIndex] then
											local item = Requirements.Tables.sortItems[itemIndex]
											local originProperty
                                            for i,v in pairs(game.Workspace.Properties:GetChildren()) do
												if v.Owner.Value == item.Owner.Value then
                                                    originProperty = v.OriginSquare.CFrame + Vector3.new(0, 5, 0)
                                                end
                                            end
                                            game:GetService("ReplicatedStorage").PlaceStructure.ClientPlacedStructure:FireServer(nil, originProperty, game.Players.LocalPlayer, nil, item, true)
                                            game:GetService("ReplicatedStorage").PlaceStructure.ClientPlacedStructure:FireServer(nil, CFrame.new(pos.X + x * (Requirements.Tables.sortItems[1].Main.Size.X), pos.Y + y * (Requirements.Tables.sortItems[1].Main.Size.Y), pos.Z + z * (Requirements.Tables.sortItems[1].Main.Size.Z)), game.Players.LocalPlayer, nil, item, true)
                                            pcall(function() Requirements.Tables.sortItems[itemIndex].SelectionBox:Destroy() end)
                                            itemIndex = itemIndex + 1
                                        end
                                     end
                                end
                            end
							pcall(function() preview:Destroy() end)
                            pcall(function() Requirements.Connections.placeBoxSort:Disconnect() end)
                            pcall(function() Requirements.Connections.cancelBox:Disconnect() end)
                            pcall(function() Requirements.Connections.boxSortPosition:Disconnect() end)
                         -- print('Sorting has been completed.')
						end)
					end
				else
               -- Print('That item does not belong to you or are whitelisted.')
                pcall(function() getItems:Disconnect() end)
				end
			else
            pcall(function() getItems:Disconnect() end)
           -- Print('Canceled. That is not a box item or an axe.')
			end
		end)
	end)
	
	
	
	



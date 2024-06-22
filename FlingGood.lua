getgenv().flingloop = true

function flingloopfix()
    local Targets = {"FLINGTARGET"} -- Replace with actual targets or leave as is

    local Players = game:GetService("Players")
    local Player = Players.LocalPlayer

    local AllBool = false

    local GetPlayer = function(Name)
        Name = Name:lower()
        if Name == "all" or Name == "others" then
            AllBool = true
            return
        elseif Name == "random" then
            local GetPlayers = Players:GetPlayers()
            if #GetPlayers > 1 then
                table.remove(GetPlayers, table.find(GetPlayers, Player))
                return GetPlayers[math.random(#GetPlayers)]
            end
        else
            for _, x in ipairs(Players:GetPlayers()) do
                if x ~= Player and (x.Name:lower():match("^"..Name) or x.DisplayName:lower():match("^"..Name)) then
                    return x
                end
            end
        end
    end

    local Message = function(_Title, _Text, Time)
        game:GetService("StarterGui"):SetCore("SendNotification", {Title = _Title, Text = _Text, Duration = Time})
    end

    local SkidFling = function(TargetPlayer)
        local Character = Player.Character
        local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
        local RootPart = Humanoid and Humanoid.RootPart

        local TCharacter = TargetPlayer.Character
        local THumanoid = TCharacter and TCharacter:FindFirstChildOfClass("Humanoid")
        local TRootPart = THumanoid and THumanoid.RootPart
        local THead = TCharacter and TCharacter:FindFirstChild("Head")
        local Accessory = TCharacter and TCharacter:FindFirstChildOfClass("Accessory")
        local Handle = Accessory and Accessory:FindFirstChild("Handle")

        if Character and Humanoid and RootPart and TCharacter and THumanoid and TRootPart then
            local FPos = function(BasePart, Pos, Ang)
                RootPart.CFrame = CFrame.new(BasePart.Position) * Pos * Ang
                Character:SetPrimaryPartCFrame(CFrame.new(BasePart.Position) * Pos * Ang)
                RootPart.Velocity = Vector3.new(9e7, 9e7 * 10, 9e7)
                RootPart.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
            end

            local SFBasePart = function(BasePart)
                local Angle = 0
                repeat
                    Angle = Angle + 100
                    FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                    task.wait()
                    FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                    task.wait()
                    -- Add more movements as needed
                until BasePart.Velocity.Magnitude > 500 or BasePart.Parent ~= TCharacter or TCharacter.Parent ~= Players or THumanoid.Sit or Humanoid.Health <= 0
            end

            workspace.FallenPartsDestroyHeight = 0/0

            local BV = Instance.new("BodyVelocity")
            BV.Name = "EpixVel"
            BV.Parent = RootPart
            BV.Velocity = Vector3.new(9e8, 9e8, 9e8)
            BV.MaxForce = Vector3.new(1/0, 1/0, 1/0)

            Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)

            if TRootPart and THead then
                if (TRootPart.CFrame.p - THead.CFrame.p).Magnitude > 5 then
                    SFBasePart(THead)
                else
                    SFBasePart(TRootPart)
                end
            elseif TRootPart then
                SFBasePart(TRootPart)
            elseif THead then
                SFBasePart(THead)
            elseif Handle then
                SFBasePart(Handle)
            else
                Message("Error Occurred", "Target is missing necessary parts", 5)
            end

            BV:Destroy()
            Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
            workspace.CurrentCamera.CameraSubject = Humanoid

            repeat
                RootPart.CFrame = getgenv().OldPos * CFrame.new(0, .5, 0)
                Character:SetPrimaryPartCFrame(getgenv().OldPos * CFrame.new(0, .5, 0))
                Humanoid:ChangeState("GettingUp")
                for _, x in ipairs(Character:GetChildren()) do
                    if x:IsA("BasePart") then
                        x.Velocity, x.RotVelocity = Vector3.new(), Vector3.new()
                    end
                end
                task.wait()
            until (RootPart.Position - getgenv().OldPos.p).Magnitude < 25

            workspace.FallenPartsDestroyHeight = getgenv().FPDH
        else
            Message("Error Occurred", "Invalid target", 5)
        end
    end

    -- Whitelisted User IDs
    local WhitelistedUserIDs = {
        [129215104] = true,
        [6069697086] = true,
        [4072731377] = true,
        [6150337449] = true,
        [1571371222] = true,
        [2911976621] = true,
        [2729297689] = true,
        [6150320395] = true,
        [301098121] = true,
        [773902683] = true,
        [290931] = true,
        [671905963] = true,
        [3129701628] = true,
        [3063352401] = true,
        [3129413184] = true
    }

    for _, x in ipairs(Targets) do
        local TPlayer = GetPlayer(x)
        if TPlayer and TPlayer ~= Player then
            if not WhitelistedUserIDs[TPlayer.UserId] then
                SkidFling(TPlayer)
            else
                -- Handle whitelisted users differently if needed
                Fluent:Notify({
                Title = "Whitelisted Player Detected",
                Content = "You're trying to Fling a Whitelisted Player",
                Duration = 3
            })
            end
        elseif not AllBool then
              Fluent:Notify({
                Title = "Error Occured",
                Content = "Player not found or not Available",
                Duration = 3
        })
    end
    end
end

while getgenv().flingloop do
    pcall(flingloopfix)
    task.wait()
end

Config = Config or {};

local Commands = Config.Commands or {};
local Prefix = Config.Prefix or GetCurrentResourceName() .. "::";

function SelectNearestFromPool(poolName, position, radius)
    local entities = GetGamePool(poolName);
    local maxDistance = radius;
    local selectedPed = nil;
    for _, handle in pairs(entities) do
        if DoesEntityExist(handle) and not IsPedAPlayer(handle) then
            local pedCoords = GetEntityCoords(handle);
            local dist = Vdist(position.x, position.y, position.z, pedCoords.x, pedCoords.y, pedCoords.z)
            if dist < maxDistance then
                maxDistance = dist;
                selectedPed = handle;
            end
        end
    end
    return DoesEntityExist(selectedPed) and selectedPed or nil;
end

function fdv(radius, radiusInput)
    -- Select vehicle
    local position = GetEntityCoords(GetPlayerPed(-1));
    local veh = SelectNearestFromPool("CVehicle", position, radius);
    if veh then
        DeleteEntity(veh);
    end
    
    if radiusInput and type(radius) == "number" then
        -- Deletes all entities within the player-specified radius
        local entities = GetGamePool("CVehicle");
        local maxRadius = radius;
        for _, handle in pairs(entities) do
            if DoesEntityExist(handle) then
                local pedCoords = GetEntityCoords(handle);
                local dist = Vdist(position.x, position.y, position.z, pedCoords.x, pedCoords.y, pedCoords.z)
                if dist < maxRadius then
                    DeleteEntity(handle);
                end
            end
        end
    end
end

function fdo(radius, radiusInput)
    local position = GetEntityCoords(GetPlayerPed(-1));
    local obj = SelectNearestFromPool("CObject", position, radius);
    if obj then
        DeleteEntity(obj);
    end

    if radiusInput and type(radius) == "number" then
        -- Deletes all entities within the player-specified radius
        local entities = GetGamePool("CObject");
        local maxRadius = radius;
        for _, handle in pairs(entities) do
            if DoesEntityExist(handle) then
                local pedCoords = GetEntityCoords(handle);
                local dist = Vdist(position.x, position.y, position.z, pedCoords.x, pedCoords.y, pedCoords.z)
                if dist < maxRadius then
                    DeleteEntity(handle);
                end
            end
        end
    end
end

function fdp(radius, radiusInput)
    local position = GetEntityCoords(GetPlayerPed(-1));
    local ped = SelectNearestFromPool("CPed", position, radius);
    if ped then
        DeleteEntity(ped);
    end

    if radiusInput and type(radiusInput) == "number" then
        -- Deletes all entities within the player-specified radius
        local entities = GetGamePool("CVehicle");
        local maxRadius = radius;
        for _, handle in pairs(entities) do
            if DoesEntityExist(handle) and not IsPedAPlayer(handle) then
                local pedCoords = GetEntityCoords(handle);
                local dist = Vdist(position.x, position.y, position.z, pedCoords.x, pedCoords.y, pedCoords.z)
                if dist < maxRadius then
                    DeleteEntity(handle);
                end
            end
        end
    end
end

if Commands.fdv and Commands.fdv.enabled then
    AddEventHandler(Prefix .. "fdv", fdv);
end
if Commands.fdo and Commands.fdo.enabled then
    AddEventHandler(Prefix .. "fdo", fdo);
end
if Commands.fdp and Commands.fdp.enabled then
    AddEventHandler(Prefix .. "fdp", fdp);
end

for cmd, data in pairs(Commands) do
    local Enabled = data.enabled or false;
    local Keybind = data.keybind or false;
    local Restricted = data.restricted or false;
    local Description = data.description or "Deletes nearest entity of type";
    local ToolTip = data.tooltip or "";
    local DefaultKeybind = data.defaultKeybind or "";
    local Radius = data.radius or 2;
    local RadiusInput = data.radiusInput or false;

    if Enabled then
        RegisterCommand(cmd, function(source, radius)
            if source < 0 then return end; -- Ignore console
            if RadiusInput and type(radius) == "number" then
                Radius = math.min(radius, Radius);
            end
            TriggerEvent(Prefix .. cmd, Radius, RadiusInput);
        end, Restricted);
        if Keybind then
            RegisterKeyMapping(cmd, Description, "keyboard", DefaultKeybind);
        end
        if ToolTip and ToolTip ~= "" then
            local args = {};
            if RadiusInput then
                args[1] = { name = "radius", help = "Deletes all peds within your specified radius" }
            end
            TriggerEvent("chat:addSuggestion", "/" .. cmd, ToolTip, args)
        end
    end
end

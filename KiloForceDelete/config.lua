Config = {
    Prefix = GetCurrentResourceName() .. "::",
    Commands = {
        fdv = { enabled = true, keybind = true, restricted = false, description = "Deletes nearest vehicle", tooltip = "Deletes nearest vehicle", defaultKeybind = "", radius = 5, radiusInput = false },
        fdp = { enabled = true, keybind = true, restricted = false, description = "Deletes nearest ped", tooltip = "Deletes nearest ped", defaultKeybind = "", radius = 2, radiusInput = false },
        fdo = { enabled = true, keybind = true, restricted = false, description = "Deletes nearest object", tooltip = "Deletes nearest object", defaultKeybind = "", radius = 1.5, radiusInput = false }
    }
};

-- Leaving defaultKeybind as a blank string will not assign it to a keybind, but still allows the player to set it themselves.
-- If radiusInput is true, a number argument called 'radius' will be added to the command. When a radius is specified by the player, the resource will delete all entities of the specified type within the specified radius. Additionally, the 'radius' you set is treated as a maximum to prevent abuse.
-- If restricted is true, not everyone can use the command. You'll have to assign the command.fdv (or fdp or fdo) permission to the people you want to be able to use it.
-- If keybind is false, the keybindings won't be created.
-- If enabled is false, the command is disabled.
-- radius is the maximum deletion radius
-- tooltip is the description that appears when typing the command in chat
-- description is the description that appears on the keybinding.
 
-- defaultKeybind is the default keybind. Changing this will not change any existing keybinds, which are stored on the client. This means it will only affect new players.
Config = {
    Prefix = GetCurrentResourceName() .. "::",
    Commands = {
        fdv = { enabled = true, keybind = true, restricted = false, description = "Deletes nearest vehicle", tooltip = "Deletes nearest vehicle", defaultKeybind = "", radius = 5 },
        fdp = { enabled = true, keybind = true, restricted = false, description = "Deletes nearest ped", tooltip = "Deletes nearest ped", defaultKeybind = "", radius = 2 },
        fdo = { enabled = true, keybind = true, restricted = false, description = "Deletes nearest object", tooltip = "Deletes nearest object", defaultKeybind = "", radius = 1.5 }
    }
};

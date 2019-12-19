local restartList = {}
local restartKey = "F5"

local function about(player)
	AddPlayerChat(player, [[
[pkg] ----------------------------------
[pkg] pkg v2.0.0 by alexandregv
[pkg] https://github.com/alexandregv/Onset-pkg
[pkg] https://github.com/alexandregv/OnsetPackages
[pkg] Need help? /pkg help
[pkg] ----------------------------------
]])
end

local helps_sorted = {
	[1]  = "help",
	[2]  = "list",
	[3]  = "info",
	[4]  = "start",
	[5]  = "stop",
	[6]  = "restart",
	[7]  = "restart-all",
	[8]  = "restart-list",
	[9]  = "set",
	[10] = "get",
}

local helps = {
	["help"] = "/pkg help [cmd] | Print help about commands",
	["list"] = "/pkg list | List all started packages",
	["info"] = "/pkg info <packages> | Get informations about one or more package(s)",
	["start"] = "/pkg start <packages> | Start one or more package(s)",
	["stop"] = "/pkg stop <packages> | Stop one or more package(s)",
	["restart"] = "/pkg restart <packages> | Restart one or more package(s)",
	["restart-all"] = "/pkg restart-all | Restart all packages",
	["restart-list"] = "/pkg restart-list | Restart packages defined with /pkg set restart-list",
	["set"] = "/pkg set <restart-list|restart-key> | Set restart-list or restart-key value",
	["get"] = "/pkg get <restart-list|restart-key> | Get restart-list or restart-key value",
}

local function help(player, cmd)
	local help = helps[cmd]
	if cmd == nil then
		for _, v in ipairs(helps_sorted) do
			AddPlayerChat(player, "[pkg] "..helps[v])
		end
	elseif help then
		AddPlayerChat(player, "[pkg] "..help)
	else
		AddPlayerChat(player, "[pkg] "..helps["help"])
	end
end


local function list(player)
	AddPlayerChat(player, "[pkg] Started packages list:")
	for _, v in pairs(GetAllPackages()) do
		AddPlayerChat(player, "[pkg] + "..v)
	end
end

local function start(player, ...)
	local pkgs = {...}

	if #pkgs == 0 then
		AddPlayerChat(player, "[pkg] "..helps["start"])
	else
		for _, v in pairs(pkgs) do
			if v == GetPackageName() then
				AddPlayerChat(player, '[pkg] Skipped "'..v..'" because a package can not start itself')
			else
				if IsPackageStarted(v) then
					AddPlayerChat(player, '[pkg] Package "'..v..'" is already started')
				else
					if StartPackage(v) then
						AddPlayerChat(player, '[pkg] Started "'..v..'"')
					else
						AddPlayerChat(player, '[pkg] Failed starting "'..v..'"')
					end
				end
			end
		end
	end
end

local function stop(player, ...)
	local pkgs = {...}

	if #pkgs == 0 then
		AddPlayerChat(player, "[pkg] "..helps["stop"])
	else
		for _, v in pairs(pkgs) do
			if v == GetPackageName() then
				AddPlayerChat(player, '[pkg] Skipped "'..v..'" because a package can not stop itself')
			else
				if IsPackageStarted(v) then
					if StopPackage(v) then
						AddPlayerChat(player, '[pkg] Stopped "'..v..'"')
					else
						AddPlayerChat(player, '[pkg] Failed stopping "'..v..'"')
					end
				else
					AddPlayerChat(player, '[pkg] Package "'..v..'" is already stopped')
				end
			end
		end
	end
end

local function restart(player, ...)
	local pkgs = {...}

	if #pkgs == 0 then
		AddPlayerChat(player, "[pkg] "..helps["restart"])
	else
		for _, v in pairs(pkgs) do
			if v == GetPackageName() then
				AddPlayerChat(player, '[pkg] Skipped "'..v..'" because a package can not restart itself')
			else
				if StopPackage(v) ~= true then
					AddPlayerChat(player, '[pkg] Failed stopping "'..v..'"')
				end
				Delay(100, function()
					if StartPackage(v) then
						AddPlayerChat(player, '[pkg] Restarted "'..v..'"')
					else
						AddPlayerChat(player, '[pkg] Failed starting "'..v..'"')
					end
				end )
			end
		end
	end
end

local function restart_all(player)
	for _, v in pairs(GetAllPackages()) do
		if v == GetPackageName() then
			AddPlayerChat(player, '[pkg] Skipped "'..v..'" because a package can not restart itself')
		else
			if StopPackage(v) ~= true then
				AddPlayerChat(player, '[pkg] Failed stopping "'..v..'"')
			end
			Delay(100, function()
				if StartPackage(v) then
					AddPlayerChat(player, '[pkg] Restarted "'..v..'"')
				else
					AddPlayerChat(player, '[pkg] Failed starting "'..v..'"')
				end
			end )
		end
	end
end

local function restart_list(player)
	if #restartList == 0 then
		AddPlayerChat(player, "[pkg] The restart-list is empty. Set it with /pkg set restart-list <packages>")
	else
		for _, v in pairs(restartList) do
			if v == GetPackageName() then
				AddPlayerChat(player, '[pkg] Skipped "'..v..'" because a package can not restart itself')
			else
				if StopPackage(v) ~= true then
					AddPlayerChat(player, '[pkg] Failed stopping "'..v..'"')
				end
				Delay(100, function()
					if StartPackage(v) then
						AddPlayerChat(player, '[pkg] Restarted "'..v..'"')
					else
						AddPlayerChat(player, '[pkg] Failed starting "'..v..'"')
					end
				end )
			end
		end
	end
end

AddRemoteEvent("pkg:restart-list", function(player)
	restart_list(player)
end )

AddEvent("OnPlayerJoin", function(player)
	CallRemoteEvent(player, "pkg:set-restartKey", restartKey)
end )

local function get(player, var)
	if var == "restart-list" then
		if #restartList == 0 then
			AddPlayerChat(player, "[pkg] The restart-list is empty. Set it with /pkg set restart-list <packages>")
		else
			AddPlayerChat(player, "[pkg] Packages in the restart-list:")
			for _, v in pairs(restartList) do
				AddPlayerChat(player, "[pkg] + "..v)
			end
		end
	elseif var == "restart-key" then
		if restartKey == "" or restartKey == nil then
			AddPlayerChat(player, "[pkg] The restart-key is not set. Set it with /pkg set restart-key F5")
		else
			AddPlayerChat(player, '[pkg] The restart-key is "'..restartKey..'"')
		end
	else
		AddPlayerChat(player, "[pkg] "..helps["get"])
	end
end

local function set(player, var, ...)
	local values = {...}

	if var == "restart-list" then
		restartList = {}
		if #values == 0 then
			AddPlayerChat(player, '[pkg] The restart-list has been emptied')
		else
			for _, v in pairs(values) do
				if v ~= GetPackageName() then
					table.insert(restartList, v)
				end
			end
		AddPlayerChat(player, "[pkg] New packages added to the restart-list. Check it with /pkg get restart-list")
		end
	elseif var == "restart-key" then
		if values[1] == nil or values[1] == "" then
			restartKey = ""
			for _, v in pairs(GetAllPlayers()) do
				CallRemoteEvent(v, "pkg:set-restartKey", "nil")
			end
			AddPlayerChat(player, '[pkg] The restart-key has been unset')
		else
			restartKey = values[1]
			for _, v in pairs(GetAllPlayers()) do
				CallRemoteEvent(v, "pkg:set-restartKey", restartKey)
			end
			AddPlayerChat(player, '[pkg] The restart-key has been set to "'..restartKey..'"')
		end
	end
end


local cmds = {
	["about"] = about,

	["help"] = help,
	["h"] = help,

	["list"] = list,
	["l"] = list,

	["info"] = info,
	["i"] = info,

	["start"] = start,
	["+"] = start,

	["stop"] = stop,
	["-"] = stop,

	["restart"] = restart,
	["r"] = restart,

	["restart-all"] = restart_all,
	["ra"] = restart_all,

	["restart-list"] = restart_list,
	["rl"] = restart_list,

	["set"] = set,

	["get"] = get,
}

AddCommand("pkg", function(player, cmd, ...)
	local cmdfunc = cmds[cmd]
	if cmd == nil then
		cmds["about"](player, ...)
	elseif cmdfunc then
		cmdfunc(player, ...)
	else
		cmds["help"](player)
	end
end )

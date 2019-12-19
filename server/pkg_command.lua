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
		cmds["about"](player, {...})
	elseif cmdfunc then
		cmdfunc(player, {...})
	else
		cmds["help"](player, {...})
	end
end )

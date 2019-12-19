reloaded = {}

local function reload_packages(player, pkgs)
	if #pkgs > 0 then
		AddPlayerChat(player, '[reloader] <span color="#ff0000">Warning: Reloading packages is generally a BAD idea. If you encounter any error or weird thing like duplicated entity etc, please restart the server.</>')

		for _, name in pairs(pkgs) do
			if name ~= GetPackageName() then
				print('[reloader] Reloading "'..name..'"')
				AddPlayerChat(player, '[reloader] Reloading "'..name..'"')

				StopPackage(name)
				Delay(100, function()
					StartPackage(name)
				end )
			end
		end
	else
		AddPlayerChat(player, "[reloader] Package list is empty. You can set it with /setreloaded <packages>.")
	end
end

AddRemoteEvent("reloader:reload", function(player)
	reload_packages(player, reloaded)
end )

AddCommand("reloadall", function(player)
	reload_packages(player, GetAllPackages())
end )

AddCommand("reload", function(player, ...)
	if #{...} == 0 then
		reload_packages(player, reloaded)
	else
		reload_packages(player, {...})
	end
end )

AddCommand("setreloaded", function(player, ...)
	reloaded = {}
	for _, name in pairs({...}) do
		if name ~= "reloader" then
			table.insert(reloaded, name)
		end
	end
	AddPlayerChat(player, "[reloader] Packages reloaded with /reload or F5: "..table.concat(reloaded, ", "))
end )

AddCommand("getreloaded", function(player)
	if #reloaded > 0 then
		AddPlayerChat(player, "[reloader] Packages reloaded with /reload or F5: "..table.concat(reloaded, ", "))
	else
		AddPlayerChat(player, "[reloader] Package list is empty. You can set it with /setreloaded <packages>.")
	end
end )

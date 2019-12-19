local restartKey = "F5"

AddRemoteEvent("pkg:set-restartKey", function(key)
	restartKey = key
end )

AddEvent("OnKeyPress", function(key)
	if key == restartKey then
		CallRemoteEvent("pkg:restart-list")
	end
end )

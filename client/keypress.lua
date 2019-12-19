AddEvent("OnKeyPress", function (key)
	if key == "F5" then
		CallRemoteEvent("reloader:reload")
	end
end )

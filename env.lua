local function env_commands(word)
	for file in io.popen([[dir /b C:\bin\env\]]..word..[[*]]):lines() do
		clink.add_match(string.gsub(file, "%.[^.]*$", ""))
	end
	return true
end

clink.arg.register_parser("env", env_commands)
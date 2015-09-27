local function spaz_folders(word)
	for dir in io.popen([[dir /b /ad-h C:\Dev\spazmodius\]]..word..[[*]]):lines() do
		clink.add_match(dir)
	end
	return true
end

clink.arg.register_parser("spaz", spaz_folders)
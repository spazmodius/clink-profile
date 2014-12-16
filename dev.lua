local function dev_folders(word)
	for dir in io.popen([[dir /b /ad-h C:\Dev\]]..word..[[*]]):lines() do
		clink.add_match(dir)
	end
	return true
end

clink.arg.register_parser("dev", dev_folders)
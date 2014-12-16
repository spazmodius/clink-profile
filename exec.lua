local function exec_match_generator(text, first, last)
	-- only if this is the first word of the line
	if first > 1 then
		return false
	end

	-- Strip off any path components that may be on text
	local prefix = ""
	local i = text:find("[\\/:][^\\/:]*$")
	if i then
		prefix = text:sub(1, i)
	end

	-- Extract any possible extension that maybe on the text being completed.
	local ext = nil
	local dot = text:find("%.[^.]*")
	if dot then
		ext = text:sub(dot):lower()
	end

	local suffices = clink.split(clink.get_env("pathext"), ";")
	for i = 1, #suffices, 1 do
		local suffix = suffices[i]

		-- Does 'text' contain some of the suffix (i.e. "cmd.e")? If it does
		-- then merge them so we get "cmd.exe" rather than "cmd.*.exe".
		if ext and suffix:sub(1, #ext):lower() == ext then
			suffix = ""
		end

		suffices[i] = text.."*"..suffix
	end

	-- executables in the cwd (or absolute/relative path).
	if clink.match_count() == 0 or match_style >= 1 then
		for _, suffix in ipairs(suffices) do
			clink.match_files(suffix)
		end
	end

	-- directories too.
	clink.match_files(text.."*", true, clink.find_dirs)

	clink.matches_are_files()
	return true
end

--------------------------------------------------------------------------------
clink.register_match_generator(exec_match_generator, 50)

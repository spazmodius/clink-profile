local function add_matches(commandFormat, word)
	local command = string.format(commandFormat, word)
	local file = io.popen(command)
	local lines = file:lines()
	for line in lines do
		clink.add_match(line)
	end
	file:close()
end

local function git_local_branches(word)
	add_matches("git for-each-ref --format=%%(refname:short) refs/heads/*%s*", word)
end

local function git_all_branches(word)
	add_matches("git for-each-ref --format=%%(refname:short) refs/heads/*%s*", word)
	add_matches("git for-each-ref --format=%%(refname:short) refs/remotes/*/*%s*", word)
end

clink.arg.register_parser("co", git_all_branches)
clink.arg.register_parser("lol", git_local_branches)
clink.arg.register_parser("br", clink.arg.new_parser():set_arguments({"-D","-d"}, {git_local_branches}))
clink.arg.register_parser("br-d", git_local_branches)
clink.arg.register_parser("delete-branch", git_local_branches)

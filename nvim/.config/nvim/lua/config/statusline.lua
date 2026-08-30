local modes = {
	n = "NORMAL",
	i = "INSERT",
	v = "VISUAL",
	V = "V-LINE",
	["\22"] = "V-BLOCK",
	c = "COMMAND",
	t = "TERMINAL",
	R = "REPLACE",
	s = "SELECT",
	S = "S-LINE",
	["\19"] = "S-BLOCK",
}

local mode_colours = {
	n = "#61AFEF",
	i = "#98C379",
	v = "#C678DD",
	V = "#C678DD",
	["\22"] = "#C678DD",
	c = "#E5C07B",
	t = "#56B6C2",
	R = "#E06C75",
	s = "#C678DD",
	S = "#C678DD",
	["\19"] = "#C678DD",
}

local function setup_statusline_highlights()
	-- Entire statusline
	vim.api.nvim_set_hl(0, "StatusLine", {
		fg = "#ABB2BF",
		bg = "#181716",
	})

	-- Current mode
	vim.api.nvim_set_hl(0, "StlMode", {
		fg = "#282C34",
		bg = mode_colours[vim.fn.mode()] or mode_colours.n,
	})

	-- Project root
	vim.api.nvim_set_hl(0, "StlProject", {
		fg = "#E5C07B",
		-- bg = "#181716",
	})

	-- Git branch
	vim.api.nvim_set_hl(0, "StlGit", {
		fg = "#98C379",
		-- bg = "#181716",
	})
end

setup_statusline_highlights()

vim.api.nvim_create_autocmd("ModeChanged", {
	callback = setup_statusline_highlights,
})

local function update_statusline()
	if vim.bo.filetype == "netrw" then
		return
	end

	local filename = vim.api.nvim_buf_get_name(0)

	if filename == "" then
		vim.w.project_root = nil
		vim.w.git_branch = nil
		vim.w.rel_path = "[No Name]"
		return
	end

	local root = vim.fs.root(0, { ".git" })

	if not root then
		vim.w.project_root = nil
		vim.w.git_branch = nil
		vim.w.rel_path = vim.fn.fnamemodify(filename, ":~")
		return
	end

	vim.w.project_root = vim.fs.basename(root)
	vim.w.rel_path = vim.fs.relpath(root, filename)

	local branch = vim.fn.system({
		"git",
		"-C",
		root,
		"branch",
		"--show-current",
	})

	branch = vim.trim(branch)

	vim.w.git_branch = branch ~= "" and branch or nil
end

local function statusline()
	local current_mode = vim.fn.mode()
	local mode = modes[current_mode] or current_mode:upper()

	local branch = ""
	if vim.w.git_branch then
		branch = "%#StlGit#  " .. vim.w.git_branch .. " %*"
	end

	local diag = ""
	local counts = vim.diagnostic.count(0)

	local labels = {
		" ",
		" ",
		" ",
		" ",
	}

	local highlights = {
		"DiagnosticError",
		"DiagnosticWarn",
		"DiagnosticInfo",
		"DiagnosticHint",
	}

	for i = 1, 4 do
		local count = counts[i]

		if count and count > 0 then
			diag = diag .. "%#" .. highlights[i] .. "#" .. labels[i] .. count .. "%* "
		end
	end

	return table.concat({
		"%#StlMode# ",
		mode,
		" %*",

		"%#StlProject# ",
		vim.w.project_root or "",
		" %*",

		branch,

		" ",
		vim.w.rel_path or vim.fn.expand("%:~"),
		"%=",
		diag,
		vim.bo.filetype,
		" %l:%c",
	})
end

_G.statusline = statusline

vim.api.nvim_create_autocmd({ "BufEnter", "DirChanged" }, {
	callback = update_statusline,
})

vim.api.nvim_create_autocmd("DiagnosticChanged", {
	callback = function()
		vim.cmd.redrawstatus()
	end,
})

vim.o.statusline = "%!v:lua.statusline()"

local function setup_statusline_highlights()
	local pms = vim.api.nvim_get_hl(0, { name = "PmenuSel", link = false })
	local vis = vim.api.nvim_get_hl(0, { name = "Visual", link = false })

	vim.api.nvim_set_hl(0, "StlMode", {
		fg = pms.fg,
		bg = vis.bg,
	})

  -- use whatever colour a string is for git branch
  vim.api.nvim_set_hl(0, "StlGit", {
	fg = vim.api.nvim_get_hl(0, {
		name = "String",
		link = false,
	}).fg,
	bg = vis.bg,
})
end

setup_statusline_highlights()

vim.api.nvim_create_autocmd("ColorScheme", {
	callback = setup_statusline_highlights,
})

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

local function update_statusline()
	local filename = vim.api.nvim_buf_get_name(0)

	if filename == "" then
		vim.b.rel_path = "[No Name]"
		vim.b.git_branch = nil
		return
	end

	local root = vim.fs.root(0, { ".git" })

	if root then
		vim.b.rel_path = vim.fs.relpath(root, filename)

		local branch = vim.fn.system("git -C " .. vim.fn.shellescape(root) .. " branch --show-current 2>/dev/null")
		branch = branch:gsub("%s+$", "")

		vim.b.git_branch = branch ~= "" and branch or nil
	else
		vim.b.rel_path = vim.fn.fnamemodify(filename, ":~")
		vim.b.git_branch = nil
	end
end

local function statusline()
	local mode = modes[vim.fn.mode()] or vim.fn.mode():upper()

	local branch = ""
	if vim.b.git_branch then
		branch = "%#StlGit# " .. vim.b.git_branch .. " %*"
	end

	local path = vim.b.rel_path or vim.fn.expand("%:~")

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
			diag = diag
				.. "%#"
				.. highlights[i]
				.. "#"
				.. labels[i]
				.. count
				.. "%* "
		end
	end

	return table.concat({
		"%#StlMode# ",
		mode,
		" %*",
		branch,
		" ",
		path,
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

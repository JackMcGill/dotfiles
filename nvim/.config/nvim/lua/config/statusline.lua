local palettes = {
	tokyonight = {
		mode = {
			n = "#7AA2F7",
			i = "#9ECE6A",
			v = "#BB9AF7",
			V = "#BB9AF7",
			["\22"] = "#BB9AF7",
			c = "#E0AF68",
			t = "#2AC3DE",
			R = "#F7768E",
			s = "#BB9AF7",
			S = "#BB9AF7",
			["\19"] = "#BB9AF7",
		},

		project = {
			fg = "#A9B1D6",
			bg = "#292E42",
		},

		git = {
			fg = "#73DACA",
			bg = "#1F2335",
		},

		text = "#C0CAF5",
	},

	kanagawa = {
		mode = {
			n = "#7E9CD8",
			i = "#98BB6C",
			v = "#957FB8",
			V = "#957FB8",
			["\22"] = "#957FB8",
			c = "#E6C384",
			t = "#7AA89F",
			R = "#E82424",
			s = "#957FB8",
			S = "#957FB8",
			["\19"] = "#957FB8",
		},

		project = {
			fg = "#727169",
			bg = "#1F1F28",
		},

		git = {
			fg = "#6A9589",
			bg = "#1F1F28",
		},

		text = "#DCD7BA",
	},
}

local function setup_statusline_highlights()
	local theme = vim.g.colors_name or "tokyonight"
	local palette = palettes[theme] or palettes.tokyonight

	vim.api.nvim_set_hl(0, "StlMode", {
		fg = palette.text,
		bg = palette.mode[vim.fn.mode()] or palette.mode.n,
	})

	vim.api.nvim_set_hl(0, "StlProject", {
		fg = palette.project.fg,
		bg = palette.project.bg,
	})

	vim.api.nvim_set_hl(0, "StlGit", {
		fg = palette.git.fg,
		bg = palette.git.bg,
	})
end

setup_statusline_highlights()

vim.api.nvim_create_autocmd("ColorScheme", {
	callback = setup_statusline_highlights,
})

vim.api.nvim_create_autocmd("ModeChanged", {
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

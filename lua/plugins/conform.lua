vim.pack.add({ "https://github.com/stevearc/conform.nvim" })

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		go = { "goimports", "gofmt" },
		python = { "ruff_format", "black", stop_after_first = true },
		json = { "biome", "prettier", stop_after_first = true },
		markdown = { "prettier" },
		javascript = { "biome", "prettier", stop_after_first = true },
		typescript = { "biome", "prettier", stop_after_first = true },
		javascriptreact = { "biome", "prettier", stop_after_first = true },
		typescriptreact = { "biome", "prettier", stop_after_first = true },
		css = { "prettier" },
		html = { "prettier" },
	},
	formatters = {
		biome = { require_cwd = true },
        prettier = {
            args = { "--tab-width", "4" },
        },
	},
	-- default_format_opts = {
	-- 	lsp_format = "fallback",
	-- },
	-- format_on_save = { timeout_ms = 500, lsp_format = "fallback" },
})

vim.api.nvim_create_user_command("FormatDisable", function(opts)
	if opts.bang then
		vim.b.disable_autoformat = true
	else
		vim.g.disable_autoformat = true
	end
	vim.notify("Autoformat disabled" .. (opts.bang and " (buffer)" or " (global)"), vim.log.levels.WARN)
end, { desc = "Disable autoformat-on-save", bang = true })

vim.api.nvim_create_user_command("FormatEnable", function()
	vim.b.disable_autoformat = false
	vim.g.disable_autoformat = false
	vim.notify("Autoformat enabled", vim.log.levels.INFO)
end, { desc = "Re-enable autoformat-on-save" })

local auto_format = true

vim.keymap.set("n", "<leader>uf", function()
	auto_format = not auto_format
	if auto_format then
		vim.cmd("FormatEnable")
	else
		vim.cmd("FormatDisable")
	end
end, { desc = "Toggle Autoformat" })

vim.keymap.set({ "n", "v" }, "<leader>cn", "<cmd>ConformInfo<cr>", { desc = "Conform Info" })

vim.keymap.set({ "n", "v" }, "<leader>cf", function()
	require("conform").format({ async = true }, function(err, did_edit)
		if not err and did_edit then
			vim.notify("Code formatted", vim.log.levels.INFO, { title = "Conform" })
		end
	end)
end, { desc = "Format buffer" })

vim.keymap.set({ "n", "v" }, "<leader>cF", function()
	require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 })
end, { desc = "Format Injected Langs" })

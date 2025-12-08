local function augroup(name)
	return vim.api.nvim_create_augroup("user_" .. name, { clear = true })
end

-- Format on save
vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function() vim.lsp.buf.format() end,
})

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
    group = augroup("checktime"),
    callback = function()
        if vim.o.buftype ~= "nofile" then
            vim.cmd("checktime")
        end
    end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    group = augroup("highlight_yank"),
    callback = function()
        (vim.hl or vim.highlight).on_yank()
    end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
    group = augroup("resize_splits"),
    callback = function()
        local current_tab = vim.fn.tabpagenr()
        vim.cmd("tabdo wincmd =")
        vim.cmd("tabnext " .. current_tab)
    end,
})


-- make it easier to close man-files when opened inline
vim.api.nvim_create_autocmd("FileType", {
    group = augroup("man_unlisted"),
    pattern = { "man" },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
    end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
    group = augroup("close_with_q"),
    pattern = {
        "PlenaryTestPopup",
        "checkhealth",
        "dbout",
        "gitsigns-blame",
        "grug-far",
        "help",
        "lspinfo",
        "neotest-output",
        "neotest-output-panel",
        "neotest-summary",
        "notify",
        "qf",
        "spectre_panel",
        "startuptime",
        "tsplayground",
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.schedule(function()
            vim.keymap.set("n", "q", function()
                vim.cmd("close")
                pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
            end, {
                buffer = event.buf,
                silent = true,
                desc = "Quit buffer",
            })
        end)
    end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
    group = augroup("wrap_spell"),
    pattern = { "text", "plaintex", "typst", "gitcommit", "markdown" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
})

-- Set filetype for .env and .env.* files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    group = augroup("env_filetype"),
    pattern = { "*.env", ".env.*" },
    callback = function()
        vim.opt_local.filetype = "sh"
    end,
})

-- Set filetype for .toml files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    group = augroup("toml_filetype"),
    pattern = { "*.tomg-config*" },
    callback = function()
        vim.opt_local.filetype = "toml"
    end,
})

-- Set filetype for .ejs files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    group = augroup("ejs_filetype"),
    pattern = { "*.ejs", "*.ejs.t" },
    callback = function()
        vim.opt_local.filetype = "embedded_template"
    end,
})

-- Set filetype for .code-snippets files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    group = augroup("code_snippets_filetype"),
    pattern = { "*.code-snippets" },
    callback = function()
        vim.opt_local.filetype = "json"
    end,
})

-- Diagnostic settings
vim.diagnostic.config({
    virtual_text = true,
    severity_sort = true,
    signs = true,
    underline = true,
    float = {
        style = "minimal",
        border = "solid",
        source = "if_many",
        header = "",
        prefix = "",
    },
    update_in_insert = false,
})

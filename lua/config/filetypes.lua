vim.filetype.add({
    extension = {
        njk = "html",
    },
})

vim.filetype.add({
    pattern = {
        ["^[^.]+$"] = "bash",
    },
})

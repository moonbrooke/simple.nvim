vim.pack.add({ "https://github.com/sotte/presenting.nvim", })

require('presenting').setup({
    options = {
        width = 60,
    },
    separator = {
        markdown = "^==+",
        org = "^*+ ",
        adoc = "^==+ ",
        asciidoctor = "^==+ ",
    },
    keep_separator = false,
    parse_frontmatter = false,
})

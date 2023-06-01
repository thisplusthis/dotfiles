local is_ok, nvim_tree = pcall(require, 'nvim-tree')
if not is_ok then
    return
end

-- Hint: :help nvim-tree-default-mappings
-- setup with some options
nvim_tree.setup({
    sort_by     = "case_sensitive",
    view        = {
        width = 30,
        side = 'left',
    },
    renderer    = {
        group_empty = true,
    },
    filters     = {
        dotfiles = true,
    },
    diagnostics = {
        enable = true,
    },
})

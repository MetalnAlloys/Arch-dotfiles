local M = {}

--function M.setup_nvim_lsp()

  local on_attach = function()
    require'completion'.on_attach()
    require'diagnostic'.on_attach()
  end

--  require'nvim_lsp'.bashls.setup{on_attach=on_attach}
--  require'nvim_lsp'.clangd.setup{on_attach=on_attach}
--  require'nvim_lsp'.vimls.setup{
--    on_attach=on_attach,
--    init_options = {
--      runtimepath = vim.api.nvim_get_option('runtimepath'),
--      indexes = {
--        gap = 75,
--        count = 5,
--      },
--    },
--  }
--
--  require'nvim_lsp'.rust_analyzer.setup{
--  on_attach= on_attach,
--    settings = {
--        completion = {
--            postfix = { enable = false },
--        },
--    },
--}
--
--end

return M

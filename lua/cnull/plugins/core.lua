local M = {
  plugins = {

    -- Dependencies (Utilities)
    -- ------------------------

    -- Some lua plugins require plenary as a utility dependency like
    -- telescope.nvim
    { 'nvim-lua/plenary.nvim' },

    -- Since vim/neovim do not support building plugins with the deno runtime
    -- (neovim has support for plugins built nodejs but not deno), this
    -- dependency is for those that do use deno, like ddc.vim (autocompletion
    -- plugin).
    { 'vim-denops/denops.vim' },

    -- Core (What is essential - for me at least)
    -- ------------------------------------------

    -- This is my own plugin to create project specific configurations, it's
    -- essentially a vim config that defers from your own config to meet the
    -- project needs and not your own config (not everything is about your
    -- config, Bob!).
    { 'creativenull/projectlocal-vim' },

    -- Pretty much the standard plugin to have when working with teams that
    -- use different editors/IDEs, compliments nicely with my plugin above.
    { 'editorconfig/editorconfig-vim' },

    -- Lua plugin to automatically insert pairs like single-quote ('),
    -- double-quote ("), etc when in insert mode.
    { 'windwp/nvim-autopairs' },

    -- Lua plugin to highlight the line where the error occurred when
    -- browsing the quickfix list (:help quickfix) or the location-list
    -- (:help location-list).
    { 'kevinhwang91/nvim-bqf' },

    -- Kind of hard to explain, but a vim plugin that can spell corrections,
    -- substitions, and coersion i.e. changing different casing like
    -- snake_case to camelCase, etc.
    { 'tpope/vim-abolish', opt = true },

    -- Vim plugin to select text and surround them in quotes, parenthesis, etc,
    -- in normal/visual mode. Nothing much else to say, but this has been a very
    -- needed plugin for me.
    { 'tpope/vim-surround', opt = true },

    -- Vim plugin to repeat the above two plugins with the dot (.) operator.
    -- If you don't know the dot operator is used to repeat what changes you
    -- did in insert mode, but with this plugin you can now perform the
    -- the same for plugins that support vim-repeat API.
    { 'tpope/vim-repeat', opt = true },

    -- Easily align text with a pivot
    -- An example, if you have the following:
    --
    --   const hello = "Hello World"
    --   const ok = "ok world"
    --
    -- Easy align with = as pivot:
    --
    --   const hello = "Hello World"
    --   const ok    = "ok world"
    --
    { 'junegunn/vim-easy-align' }
  },
}

function M.after()
  -- nvim-autopairs Config
  -- ---
  require('nvim-autopairs').setup({})
end

return M

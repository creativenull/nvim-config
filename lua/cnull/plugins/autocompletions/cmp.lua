local augroup = require('cnull.core.event').augroup
local cmp = require('cmp')

-- LuaSnip Config
-- ---
local luasnip_ok, luasnip = pcall(require, 'luasnip')
if luasnip_ok then
  require('luasnip/loaders/from_vscode').load()
end

-- nvim-cmp Config
-- ---
cmp.setup({
  completion = {
    keyword_length = 3,
  },
  snippet = {
    expand = function(args)
      -- if vim.fn.exists('*vsnip#anonymous') == 1 then
      --   vim.fn['vsnip#anonymous'](args.body)
      -- end

      -- if vim.fn.exists('*UltiSnips#Anon') == 1 then
      --   vim.fn['UltiSnips#Anon'](args.body)
      -- end

      if luasnip_ok then
        luasnip.lsp_expand(args.body)
      end
    end,
  },

  mapping = {
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping.confirm({ select = true }),
  },

  -- You should specify your *installed* sources.
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    -- { name = 'ultisnips' },
    -- { name = 'vsnip' },
  },

  formatting = {
    format = function(entry, item)
      item.menu = ({
        nvim_lsp = '[LSP]',
        luasnip = '[SNIPPET]',
        -- ultisnips = '[SNIPPET]',
        -- vsnip = '[SNIPPET]',
      })[entry.source.name]

      return item
    end,
  },

  documentation = {
    border = 'single',
  },
})

-- Disable on filetypes not needed like prompt windows
augroup('cmp_user_events', {
  {
    event = 'FileType',
    pattern = { 'TelescopePrompt' },
    exec = function()
      cmp.setup.buffer({
        completion = {
          autocomplete = false,
        },
      })
    end,
  },
})

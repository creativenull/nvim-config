local cmp = require('cmp')

-- LuaSnip Config
-- ---
--[[ local luasnip_ok, luasnip = pcall(require, 'luasnip')
if luasnip_ok then
  require('luasnip/loaders/from_vscode').load()
end ]]

-- nvim-cmp Config
-- ---
cmp.setup({
  snippet = {
    expand = function(args)
      if vim.fn.exists('*vsnip#anonymous') == 1 then
        vim.fn['vsnip#anonymous'](args.body)
      end

      -- if vim.fn.exists('*UltiSnips#Anon') == 1 then
      --   vim.fn['UltiSnips#Anon'](args.body)
      -- end

      -- if luasnip_ok then
      --   luasnip.lsp_expand(args.body)
      -- end
    end,
  },

  mapping = {
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping.confirm({ select = true }),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
  },

  -- You should specify your *installed* sources.
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'buffer' },
  }),

  formatting = {
    format = require('lspkind').cmp_format({
      with_text = true,
      menu = {
        buffer = '[B]',
        nvim_lsp = '[LS]',
        vsnip = '[S]',
      },
    }),
  },

  window = {
    documentation = {
      max_width = 80,
      border = 'rounded',
    },
  },
})

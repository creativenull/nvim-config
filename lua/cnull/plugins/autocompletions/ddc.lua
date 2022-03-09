local augroup = require('cnull.core.event').augroup
local imap = require('cnull.core.keymap').imap

vim.call('ddc#custom#patch_global', {
  backspaceCompletion = true,
  autoCompleteDelay = 100,
  sources = { 'nvim-lsp', 'vsnip', 'around', 'buffer' },
  sourceOptions = {
    ['_'] = {
      matchers = { 'matcher_fuzzy' },
      sorters = { 'sorter_fuzzy' },
      converters = { 'converter_fuzzy' },
    },
    ['nvim-lsp'] = {
      mark = 'LS',
      maxCandidates = 10,
      forceCompletionPattern = [[\.\w*|:\w*|->\w*]],
    },
    vsnip = {
      mark = 'S',
      maxCandidates = 5,
    },
    around = {
      mark = 'A',
      maxCandidates = 3,
    },
    buffer = {
      mark = 'B',
      maxCandidates = 3,
    }
  },
  sourceParams = {
    kindLabels = {
      Class = 'ﴯ Class',
      Color = ' Color',
      Constant = ' Cons',
      Constructor = ' New',
      Enum = ' Enum',
      EnumMember = ' Enum',
      Event = ' Event',
      Field = 'ﰠ Field',
      File = ' File',
      Folder = ' Dir',
      Function = ' Fun',
      Interface = ' Int',
      Keyword = ' Key',
      Method = ' Method',
      Module = ' Mod',
      Operator = ' Op',
      Property = 'ﰠ Prop',
      Reference = ' Ref',
      Snippet = ' Snip',
      Struct = 'פּ Struct',
      Text = ' Text',
      TypeParameter = '',
      Unit = '塞 Unit',
      Value = ' Value',
      Variable = ' Var',
    },
  },
})

-- Complete trigger
imap('<C-y>', [[pumvisible() ? (vsnip#expandable() ? "\<Plug>(vsnip-expand)" : "\<C-y>") : "\<C-y>"]], { expr = true })

-- Manual popup trigger
imap('<C-Space>', 'ddc#map#manual_complete()', { silent = true, expr = true })

augroup('ddc_user_events', {
  {
    event = 'VimEnter',
    exec = function()
      vim.call('popup_preview#enable')
      vim.call('ddc#enable')
    end,
  },
})

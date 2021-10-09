local lualine = require('lualine')
local custom_theme = require('lualine.themes.powerline')
custom_theme.normal.a = {}
custom_theme.normal.a.bg = '#047857'
custom_theme.normal.z = {}
custom_theme.normal.z.bg = '#444444'
custom_theme.insert.z = {}
custom_theme.insert.z.bg = custom_theme.insert.a.bg
custom_theme.insert.z.fg = custom_theme.insert.a.fg

-- Line Info Component
local function line_info_component()
  local bufnr = vim.api.nvim_get_current_buf()
  local bufinfo = vim.fn.getbufinfo(bufnr)
  bufinfo = bufinfo[1]
  local linecount = bufinfo.linecount
  local linenum = bufinfo.lnum
  local col = vim.fn.col('.')
  return string.format(' %s/%s  %s', linenum, linecount, col)
end

-- LSP Attach Info Component
local function lsp_ready_component()
  if not vim.lsp.buf.server_ready() then
    return ''
  else
    return 'LSP'
  end
end

lualine.setup({
  options = {
    icons_enabled = true,
    theme = 'powerline',
    section_separators = {'', ''},
    disabled_filetypes = {'TelescopePrompt', 'nnn'}
  },

  sections = {
    lualine_a = {'filename'},
    lualine_b = {'branch'},
    lualine_c = {},

    lualine_x = {'encoding'},
    lualine_y = {line_info_component},
    lualine_z = {
      lsp_ready_component,
      {
        'diagnostics',
        sources = {'nvim_lsp'},
        sections = {'error', 'warn'},
      },
    },
  },

  inactive_sections = {
    lualine_a = {'filename'},
    lualine_b = {},
    lualine_c = {},

    lualine_x = {},
    lualine_y = {line_info_component},
    lualine_z = {'encoding'},
  },
})
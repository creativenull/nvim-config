local lsp_provider = require('feline.providers.lsp')

-- Filename
-- local primary_color = { bg = '#047857', fg = '#ffffff' }
local primary_color = { bg = '#ea31b5', fg = '#ffffff' }

-- LSP
local lsp_hl = { bg = '#ffffff', fg = '#262626' }
local lsp_error_hl = { bg = '#df0000', fg = '#ffffff' }
local lsp_warning_hl = { bg = '#ff8700', fg = '#ffffff' }

-- Line Info Provider - show line number and column number
local line_info_hl = { bg = '#606060', fg = '#ffffff' }
local function line_info_provider()
  local bufnr = vim.api.nvim_get_current_buf()
  local bufinfo = vim.fn.getbufinfo(bufnr)[1]
  local linecount = bufinfo.linecount
  local linenum = bufinfo.lnum
  local col = vim.fn.col('.')
  return string.format('  %s/%s  %s ', linenum, linecount, col)
end

local function make_active_stl()
  local active = { {}, {}, {} }

  -- Left
  -- Active File Info {{{
  table.insert(active[1], {
    provider = {
      name = 'file_info',
      opts = { colored_icon = false },
    },
    hl = primary_color,
    right_sep = 'slant_right',
    left_sep = 'block',
  })
  -- }}}

  -- Active Git Branch {{{
  table.insert(active[1], {
    provider = 'git_branch',
    left_sep = 'block',
  })
  -- }}}

  -- Right
  -- Active File Encoding {{{
  table.insert(active[3], {
    provider = 'file_encoding',
    right_sep = 'block',
  })
  -- }}}

  -- Active Line Info {{{
  table.insert(active[3], {
    provider = line_info_provider,
    hl = line_info_hl,
    left_sep = 'slant_left',
  })
  -- }}}

  -- Active LSP Component {{{
  table.insert(active[3], {
    provider = function()
      if lsp_provider.is_lsp_attached() then
        return ' LSP '
      end
      return ''
    end,
    hl = lsp_hl,
    left_sep = {
      str = 'slant_left',
      hl = { bg = '#606060', fg = '#ffffff' },
    },
  })
  -- }}}

  -- Active LSP Error Component {{{
  table.insert(active[3], {
    provider = function()
      local count, icon = lsp_provider.diagnostic_errors()
      return count .. ' ', icon
    end,
    enabled = function()
      return lsp_provider.diagnostics_exist('Error')
    end,
    hl = lsp_error_hl,
    left_sep = {
      str = 'slant_left',
      hl = { bg = '#ffffff', fg = '#df0000' },
    },
  })
  -- }}}

  -- Active LSP Warning Component {{{
  table.insert(active[3], {
    -- provider = lsp_warning_provider,
    provider = function()
      local count, icon = lsp_provider.diagnostic_warnings()
      return count .. ' ', icon
    end,
    enabled = function()
      return lsp_provider.diagnostics_exist('Warning')
    end,
    hl = lsp_warning_hl,
    left_sep = {
      str = 'slant_left',
      hl = function()
        -- Render proper color blend when both errors and warnings
        -- are being shown
        -- if has_errors() then
        if lsp_provider.diagnostics_exist('Error') then
          return { bg = '#df0000', fg = '#ff8700' }
        else
          return { bg = '#ffffff', fg = '#ff8700' }
        end
      end,
    },
  })
  -- }}}

  return active
end

local function make_inactive_stl()
  local inactive = { {}, {} }

  -- Left
  -- Inactive File Info {{{
  table.insert(inactive[1], {
    provider = {
      name = 'file_info',
      opts = { colored_icon = false },
    },
    hl = primary_color,
    right_sep = 'slant_right',
    left_sep = 'block',
  })
  -- }}}

  -- Right
  -- Inactive File Encoding {{{
  table.insert(inactive[2], { provider = 'file_encoding' })
  table.insert(inactive[2], { provider = ' ' })
  -- }}}

  -- Inactive Line Info {{{
  table.insert(inactive[2], {
    provider = line_info_provider,
    hl = line_info_hl,
    left_sep = 'slant_left',
  })
  -- }}}

  return inactive
end

-- Termguicolors is a dependency
if not vim.opt.termguicolors:get() then
  vim.opt.termguicolors = true
end

require('feline').setup({
  components = {
    active = make_active_stl(),
    inactive = make_inactive_stl(),
  },
})

-- local cp = require('catppuccin.core.color_palette')
local lsp_provider = require('feline.providers.lsp')

-- Filename
local filename_hl = { bg = '#047857', fg = '#ffffff' }
-- local filename_hl = { bg = '#ea31b5', fg = '#ffffff' }

-- LSP
local lsp_hl = { bg = '#ffffff', fg = '#262626' }
local lsp_error_hl = { bg = '#df0000', fg = '#ffffff' }
local lsp_warning_hl = { bg = '#ff8700', fg = '#ffffff' }

-- File Encoding
local file_encoding_info_hl = { bg = '#606060', fg = '#ffffff' }

-- Insert mode
local insert_hl = { bg = '#005f87' }
-- local insert_hl = { bg = cp.catppuccin12 }

-- Line Info Provider - show line number and column number
local function line_info_provider()
  local bufnr = vim.api.nvim_get_current_buf()
  local bufinfo = vim.fn.getbufinfo(bufnr)[1]
  local linecount = bufinfo.linecount
  local linenum = bufinfo.lnum
  local col = vim.fn.col('.')
  return string.format('  %s/%s  %s ', linenum, linecount, col)
end

local function is_insert_mode()
  return vim.api.nvim_get_mode().mode == 'i'
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
    hl = filename_hl,
    left_sep = 'block',
  })
  table.insert(active[1], {
    provider = ' ',
    hl = filename_hl,
    right_sep = {
      str = 'slant_right',
      hl = function()
        if is_insert_mode() then
          return { bg = insert_hl.bg, fg = filename_hl.bg }
        else
          return { fg = filename_hl.bg }
        end
      end,
    },
  })
  -- }}}

  -- Active Git Branch {{{
  table.insert(active[1], {
    provider = 'git_branch',
    left_sep = 'block',
    hl = function()
      if is_insert_mode() then
        return insert_hl
      else
        return {}
      end
    end,
  })
  -- }}}

  -- Right
  -- Active Line Info {{{
  table.insert(active[3], {
    provider = line_info_provider,
    hl = function()
      if is_insert_mode() then
        return insert_hl
      else
        return {}
      end
    end,
  })
  table.insert(active[3], {
    provider = ' ',
    hl = file_encoding_info_hl,
    left_sep = {
      str = 'slant_left',
      hl = function()
        if is_insert_mode() then
          return { bg = insert_hl.bg, fg = file_encoding_info_hl.bg }
        else
          return { fg = file_encoding_info_hl.bg }
        end
      end,
    },
  })
  -- }}}

  -- Active File Encoding {{{
  table.insert(active[3], { provider = 'file_encoding', hl = file_encoding_info_hl })
  table.insert(active[3], { provider = ' ', hl = file_encoding_info_hl })
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
      return lsp_provider.diagnostics_exist('Warn')
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
    hl = filename_hl,
    left_sep = 'block',
  })
  table.insert(inactive[1], {
    provider = ' ',
    hl = filename_hl,
    right_sep = {
      str = 'slant_right',
      hl = function()
        if is_insert_mode() then
          return { bg = insert_hl.bg, fg = filename_hl.bg }
        else
          return { fg = filename_hl.bg }
        end
      end,
    },
  })
  -- }}}

  -- Right
  -- Inactive Line Info {{{
  table.insert(inactive[2], {
    provider = ' ',
    hl = file_encoding_info_hl,
    left_sep = {
      str = 'slant_left',
      hl = function()
        if is_insert_mode() then
          return { bg = insert_hl.bg, fg = file_encoding_info_hl.bg }
        else
          return { fg = file_encoding_info_hl.bg }
        end
      end,
    },
  })
  -- }}}

  -- Inactive File Encoding {{{
  table.insert(inactive[2], { provider = 'file_encoding', hl = file_encoding_info_hl })
  table.insert(inactive[2], { provider = ' ', hl = file_encoding_info_hl })
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

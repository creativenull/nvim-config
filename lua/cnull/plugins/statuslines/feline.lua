-- Line Info Provider - show line number and column number
local function line_info_provider()
  local bufnr = vim.api.nvim_get_current_buf()
  local bufinfo = vim.fn.getbufinfo(bufnr)[1]
  local linecount = bufinfo.linecount
  local linenum = bufinfo.lnum
  local col = vim.fn.col('.')
  return string.format(' %s/%s  %s ', linenum, linecount, col)
end

-- LSP status - check if LSP is available
local function lsp_status_provider()
  if vim.lsp.buf.server_ready() then
    return ' LSP '
  end

  return ''
end

-- Utility to check, in case both
-- errors and warnings are being shown
local function has_errors()
  local bufnr = vim.api.nvim_get_current_buf()
  local errors = vim.lsp.diagnostic.get_count(bufnr, 'Error')
  return errors > 0
end

-- LSP Error Provider - show error diagnostics
local function lsp_error_provider()
  local bufnr = vim.api.nvim_get_current_buf()
  local errors = vim.lsp.diagnostic.get_count(bufnr, 'Error')
  if errors > 0 then
    return string.format(' %d ', errors)
  end
  return ''
end

local function lsp_warning_provider()
  local bufnr = vim.api.nvim_get_current_buf()
  local warnings = vim.lsp.diagnostic.get_count(bufnr, 'Warning')
  if warnings > 0 then
    return string.format(' %d ', warnings)
  end
  return ''
end

local function make_active_stl()
  local active = { {}, {}, {} }

  -- Left
  -- Active File Info {{{
  table.insert(active[1], {
    provider = ' ',
    hl = { bg = '#047857' },
  })
  table.insert(active[1], {
    provider = {
      name = 'file_info',
      opts = { colored_icon = false },
    },
    hl = { bg = '#047857' },
    right_sep = 'slant_right',
  })
  -- }}}

  -- Active Git Branch {{{
  table.insert(active[1], { provider = ' ' })
  table.insert(active[1], { provider = 'git_branch' })
  -- }}}

  -- Right
  -- Active File Encoding {{{
  table.insert(active[3], { provider = 'file_encoding' })
  table.insert(active[3], { provider = ' ' })
  -- }}}

  -- Active Line Info {{{
  table.insert(active[3], {
    provider = ' ',
    hl = { bg = '#606060' },
    left_sep = 'slant_left',
  })

  table.insert(active[3], {
    provider = line_info_provider,
    hl = { bg = '#606060' },
  })
  -- }}}

  -- Active LSP Component {{{
  table.insert(active[3], {
    provider = lsp_status_provider,
    hl = {
      fg = '#262626',
      bg = '#ffffff',
    },
    left_sep = {
      str = 'slant_left',
      hl = {
        fg = '#ffffff',
        bg = '#606060',
      },
    },
  })
  -- }}}

  -- Active LSP Error Component {{{
  table.insert(active[3], {
    provider = lsp_error_provider,
    hl = {
      fg = '#ffffff',
      bg = '#df0000',
    },
    left_sep = {
      str = 'slant_left',
      hl = {
        fg = '#df0000',
        bg = '#ffffff',
      },
    },
  })
  -- }}}

  -- Active LSP Warning Component {{{
  table.insert(active[3], {
    provider = lsp_warning_provider,
    hl = {
      fg = '#ffffff',
      bg = '#ff8700',
    },
    left_sep = {
      str = 'slant_left',
      hl = function()
        -- Render proper color blend when both errors and warnings
        -- are being shown
        if has_errors() then
          return {
            fg = '#ff8700',
            bg = '#df0000',
          }
        else
          return {
            fg = '#ff8700',
            bg = '#ffffff',
          }
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
    provider = ' ',
    hl = { bg = '#047857' },
  })
  table.insert(inactive[1], {
    provider = {
      name = 'file_info',
      opts = { colored_icon = false },
    },
    hl = { bg = '#047857' },
    right_sep = 'slant_right',
  })
  -- }}}

  -- Right
  -- Inactive File Encoding {{{
  table.insert(inactive[2], { provider = 'file_encoding' })
  table.insert(inactive[2], { provider = ' ' })
  -- }}}

  -- Inactive Line Info {{{
  table.insert(inactive[2], {
    provider = ' ',
    hl = { bg = '#606060' },
    left_sep = 'slant_left',
  })

  table.insert(inactive[2], {
    provider = line_info_provider,
    hl = { bg = '#606060' },
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

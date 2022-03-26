local colors = require('cnull.user.colors')

local theme = {
  normal = {
    a = { fg = colors.text_softlight, bg = colors.primary },
    b = { fg = colors.text_softlight, bg = colors.darkgray },
    c = { fg = '',                    bg = colors.bg_dark },
    x = { fg = colors.text_light,     bg = colors.darkgray },
    y = { fg = colors.text_light,     bg = colors.gray },
    z = { fg = colors.text_light,     bg = colors.indigo },
  },
  insert = {
    a = { fg = colors.text_softlight, bg = colors.insert_primary },
    b = { fg = colors.text_softlight, bg = colors.darkgray },
    c = { fg = '',                    bg = colors.insert_primary },
    x = { fg = colors.text_light,     bg = colors.insert_primary },
    y = { fg = colors.text_light,     bg = colors.gray },
    z = { fg = colors.text_light,     bg = colors.indigo },
  },
  visual = {
    a = { fg = colors.text_softlight, bg = colors.visual_primary },
    b = { fg = colors.text_softlight, bg = colors.darkgray },
    c = { fg = '',                    bg = colors.visual_primary },
    x = { fg = colors.text_light,     bg = colors.visual_primary },
    y = { fg = colors.text_light,     bg = colors.gray },
    z = { fg = colors.text_light,     bg = colors.indigo },
  },
  command = {
    a = { fg = colors.text_softdark,  bg = colors.command_primary },
    b = { fg = colors.text_softlight, bg = colors.darkgray },
    c = { fg = '',                    bg = colors.command_primary },
    x = { fg = colors.text_dark,      bg = colors.command_primary },
    y = { fg = colors.text_light,     bg = colors.gray },
    z = { fg = colors.text_light,     bg = colors.indigo },
  },
  replace = {
    a = { fg = colors.text_softdark,  bg = colors.replace_primary },
    b = { fg = colors.text_softlight, bg = colors.darkgray },
    c = { fg = '',                    bg = colors.replace_primary },
    x = { fg = colors.text_dark,      bg = colors.replace_primary },
    y = { fg = colors.text_light,     bg = colors.gray },
    z = { fg = colors.text_light,     bg = colors.indigo },
  },
  inactive = {
    a = { fg = colors.text_softlight, bg = colors.bg_softdark },
    b = { fg = colors.text_softlight, bg = colors.bg_softdark },
    c = { fg = '',                    bg = colors.bg_dark },
    x = { fg = colors.text_softlight, bg = colors.bg_softdark },
    y = { fg = colors.text_softlight, bg = colors.bg_softdark },
    z = { fg = colors.text_softlight, bg = colors.bg_softdark },
  },
}

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

local function lsp_ready_component()
  if not vim.lsp.buf.server_ready() then
    return ''
  else
    return 'LSP'
  end
end

local function err_diagnostic_component()
  local bufnr = vim.api.nvim_get_current_buf()
  local severity = vim.diagnostic.severity.ERROR

  local diagnostics = vim.diagnostic.get(bufnr, { severity = severity })

  return vim.tbl_count(diagnostics)
end

local function is_err_diagnostic()
  local bufnr = vim.api.nvim_get_current_buf()
  local severity = vim.diagnostic.severity.ERROR

  local diagnostics = vim.diagnostic.get(bufnr, { severity = severity })

  return vim.tbl_count(diagnostics) > 0
end

local function warn_diagnostic_component()
  local bufnr = vim.api.nvim_get_current_buf()
  local severity = vim.diagnostic.severity.WARN

  local diagnostics = vim.diagnostic.get(bufnr, { severity = severity })

  return vim.tbl_count(diagnostics)
end

local function is_warn_diagnostic()
  local bufnr = vim.api.nvim_get_current_buf()
  local severity = vim.diagnostic.severity.WARN

  local diagnostics = vim.diagnostic.get(bufnr, { severity = severity })

  return vim.tbl_count(diagnostics) > 0
end

require('lualine').setup({
  options = {
    icons_enabled = true,
    theme = theme,
    section_separators = { left = '', right = '' },
    disabled_filetypes = { 'TelescopePrompt' },
  },

  sections = {
    lualine_a = { 'filename' },
    lualine_b = { 'branch' },
    lualine_c = {},

    lualine_x = { 'encoding' },
    lualine_y = { line_info_component },
    lualine_z = {
      lsp_ready_component,
      {
        err_diagnostic_component,
        cond = is_err_diagnostic,
        separator = { left = '' },
        color = { fg = colors.text_softlight, bg = colors.error }
      },
      {
        warn_diagnostic_component,
        cond = is_warn_diagnostic,
        separator = { left = '' },
        color = { fg = colors.text_softdark, bg = colors.warn }
      },
    },
  },

  inactive_sections = {
    lualine_a = { 'filename' },
    lualine_b = {},
    lualine_c = {},

    lualine_x = {},
    lualine_y = { line_info_component },
    lualine_z = { 'encoding' },
  },
})

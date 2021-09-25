local feline = require('feline')

local components = {
  active = {
    {
      {
        provider = 'file_info',
        hl = {
          fg = '#eeeeee',
          bg = '#047857',
        },
      },
    },
    {},
    {}
  },
  inactive = {
    {},
    {},
  },
}

feline.setup({ components = components })

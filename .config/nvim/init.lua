-- Lazy
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable',
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Плагины
require('lazy').setup({
    { -- Цветовая схема
        'navarasu/onedark.nvim',
        priority = 1000,
        config = function()
            require('onedark').setup({ style = 'darker' }) -- style = 'dark' / 'darker' / 'cool' / 'deep' / 'warm' / 'warmer' / 'light'
            require('onedark').load()
        end
    },
    { -- Иконки
        'nvim-tree/nvim-web-devicons'
    },
    { -- Древовидный explorer
        'nvim-tree/nvim-tree.lua',
        config = function()
            require('nvim-tree').setup()
        end,
    },
    { -- Буфферы
        'akinsho/bufferline.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('bufferline').setup({ options = { numbers = 'buffer_id' } })
        end,
    },
    { -- Поиск и навигация
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('telescope').setup()
        end,
    },
    { -- Bыделение синтаксиса
        'nvim-treesitter/nvim-treesitter',
    },
    { -- Просмотр git diff
        'sindrets/diffview.nvim',
        dependencies = 'nvim-lua/plenary.nvim',
    },
    { -- Отметки изменения строк
        'lewis6991/gitsigns.nvim',
    },
    { -- Автодополнение
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
        },
        config = function()
            local cmp = require('cmp')
            cmp.setup({
                sources = cmp.config.sources({
                    { name = 'cmdline' }, 
                    { name = 'buffer' },
                    { name = 'path' },
                })
            })
        end,
    },
    { -- Команды на русском
        'powerman/vim-plugin-ruscmd',
        config = function()
        end
    }
})

-- Бинды
vim.keymap.set('n', '<F1>', ':NvimTreeToggle<CR>', { noremap = true })
vim.keymap.set('n', '<F2>', ':Telescope live_grep<CR>', { noremap = true })
vim.keymap.set('n', '<F3>', ':Telescope find_files<CR>', { noremap = true })
vim.keymap.set('n', '<F4>', ':DiffviewOpen HEAD~1<CR>', { noremap = true })

-- Настройки VIM
vim.opt.number=true
vim.opt.clipboard='unnamedplus'
vim.opt.tabstop=4
vim.opt.shiftwidth=4
vim.opt.expandtab=true

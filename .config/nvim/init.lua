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
            require('nvim-tree').setup({
                git = { ignore = false },
                filters = { dotfiles = false },
            })
            vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true })
        end,
    },
    { -- Автодополнение
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
        },
        config = function()
            require('cmp').setup({
                sources = require('cmp').config.sources({
                    { name = 'cmdline' }, 
                    { name = 'buffer' },
                    { name = 'path' },
                })
            })
        end,
    },
    { -- Поиск и навигация
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function() 
            vim.keymap.set('n', '<leader>g', ':Telescope live_grep<CR>', { noremap = true })
            vim.keymap.set('n', '<leader>f', ':Telescope find_files<CR>', { noremap = true })
        end,
    },
    { -- Bыделение синтаксиса
        'nvim-treesitter/nvim-treesitter',
    },
    { -- Буфферы
        'akinsho/bufferline.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function() require('bufferline').setup({ options = { numbers = 'buffer_id' } }) end,
    },
    { -- Быстрый переход
        'smoka7/hop.nvim',
        config = true,
        vim.keymap.set({'n', 'v'}, '<leader>h', function() require('hop').hint_words() end, { noremap = true })
    },
    { -- Просмотр git diff
        'sindrets/diffview.nvim',
        dependencies = 'nvim-lua/plenary.nvim',
        config = function() 
            vim.keymap.set('n', '<leader>do', ':DiffviewOpen HEAD~1<CR>', { noremap = true })
            vim.keymap.set('n', '<leader>dc', ':DiffviewClose<CR>', { noremap = true })
        end,
    },
    { -- Отметки изменения строк
        'lewis6991/gitsigns.nvim',
    },
    { -- Команды на русском
        'powerman/vim-plugin-ruscmd',
        config = function() end,
    },
    { -- OpenCode
        'nickjvandyke/opencode.nvim',
        config = function() 
            vim.g.opencode_opts = {}
            vim.o.autoread = true
            vim.keymap.set({ 'n', 'x' }, '<leader>oa', function() require('opencode').ask() end, { desc = 'Ask OpenCode…' })
            vim.keymap.set({ 'n', 'x' }, '<leader>os', function() return require('opencode').operator('@this ') .. '_' end, { desc = 'Append selected to OpenCode', expr = true })
        end,
    },
})

-- Utils
vim.keymap.set({'n', 't'}, '<C-]>', '<C-\\><C-n>', { noremap = true })
vim.keymap.set({'n', 't'}, '<leader>l', '<C-\\><C-n>:set scrollback=1 <bar> set scrollback=10000<CR>i', { noremap = true })
-- Git
vim.keymap.set('n', '<leader>ga', ':!git commit -a --amend --no-edit<CR>', { noremap = true })
vim.keymap.set('t', '<leader>ga', 'git commit -a --amend --no-edit<CR>', { noremap = true })
vim.keymap.set('n', '<leader>gс', ':!git add . && git commit -am \'\'<Left>', { noremap = true })
vim.keymap.set('t', '<leader>gс', 'git add . && git commit -am \'\'<Left>', { noremap = true })

-- Настройки VIM
vim.opt.number=true
vim.opt.clipboard='unnamedplus'
vim.opt.tabstop=4
vim.opt.shiftwidth=4
vim.opt.expandtab=true
vim.opt.swapfile = false

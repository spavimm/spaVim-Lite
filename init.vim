let g:coc_node_path = '~/.nvm/versions/node/v18.14.2/bin/node'
let g:python3_host_prog = '/usr/bin/python3'

let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')
if has('win32')&&!has('win64')
  let curl_exists=expand('C:\Windows\Sysnative\curl.exe')
else
  let curl_exists=expand('curl')
endif

let mapleader = " "

if !filereadable(vimplug_exists)
  if !executable(curl_exists)
    echoerr "Tienes que instalar curl o primero instalar Vim Plug tú mismo"
    execute "q!"
  endif
  echo "Instalando Vim-Plug..."
  echo ""
  silent exec "!"curl_exists" -fLo " . shellescape(vimplug_exists) . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall
endif

set autoindent " autoindent always ON.
set expandtab " expand tabs
set shiftwidth=4 " spaces for autoindenting
set softtabstop=4 " remove a full pseudo-TAB when i press <BS>
set nocompatible

set encoding=UTF-8
syntax on

call plug#begin(expand('~/.config/nvim/plugged'))

Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'ryanoasis/vim-devicons'
Plug 'nvim-tree/nvim-web-devicons'

Plug 'Raimondi/delimitMate'

Plug 'jelera/vim-javascript-syntax'

Plug 'wuelnerdotexe/vim-enfocado'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'sheerun/vim-polyglot'

Plug 'voldikss/vim-floaterm'

Plug 'akinsho/bufferline.nvim', { 'tag': 'v2.*' }

Plug 'folke/zen-mode.nvim'

Plug 'Pocco81/auto-save.nvim'

Plug 'APZelos/blamer.nvim'

Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }

Plug 'turbio/bracey.vim', {'do': 'npm install --prefix server'}

Plug 'kristijanhusak/vim-carbon-now-sh'

call plug#end()


" +++
" carbon now sh
vnoremap <F5> :CarbonNowSh<CR>


" +++
" bracey
noremap <leader>ll :Bracey<CR>
noremap <leader>lq :BraceyStop<CR>
noremap <leader>lr :BraceyReload<CR>


" +++
" markdown preview
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 0
let g:mkdp_command_for_global = 0
let g:mkdp_open_to_the_world = 0
let g:mkdp_open_ip = ''
let g:mkdp_browser = ''
let g:mkdp_echo_preview_url = 0
let g:mkdp_browserfunc = ''
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false,
    \ 'disable_filename': 0,
    \ 'toc': {}
    \ }
let g:mkdp_markdown_css = ''
let g:mkdp_highlight_css = ''
let g:mkdp_port = ''
let g:mkdp_page_title = '「${name}」'
let g:mkdp_filetypes = ['markdown']
let g:mkdp_theme = 'light'

nmap <leader>mda <Plug>MarkdownPreview
nmap <leader>mdq <Plug>MarkdownPreviewStop
nmap <leader>mdd <Plug>MarkdownPreviewToggle


" +++
" blamer
let g:blamer_enabled = 1
let g:blamer_delay = 700
let g:blamer_show_in_visual_modes = 1
let g:blamer_show_in_insert_modes = 0
let g:blamer_prefix = ' > '
let g:blamer_template = '<committer>, <committer-time> • <summary> • <committer-mail>'  " Opciones disponibles <author>, <author-mail>, <author-time>, <committer>, <committer-mail>, <committer-time>, <summary>, <commit-short>, <commit-long>

" Formato hora
let g:blamer_date_format = '%d/%m/%y %H:%M'
let g:blamer_relative_time = 0 "  Muestra la fecha de confirmación en formato relativo, por defecto 0
highlight Blamer guifg= lightgrey


" +++
" autosave
lua << EOF
require("auto-save").setup({
	enable = true,
	execution_message = {
		message = function()
		return ("Autosave: Guardado a las " .. vim.fn.strftime("%H:%M:%S"))
		end,
		dim = 0.18,
		cleaning_interval = 1250,
	},
	trigger_events = {"InsertLeave", "TextChanged"},
	condition = function (buf)
		local fn = vim.fn
		local utils = require("auto-save.utils.data")

		if
			fn.getbufvar (buf, "&modifiable") == 1 and
			utils.not_in(fn.getbufvar(buf, "&filetype"),{}) then
			return true
		end
		return false
	end,
	write_all_buffers = false,
	debounce_delay = 135,
	callbacks = {
		enabling = nil,
		disabling = nil,
		before_asserting_save = nil,
		before_saving = nil,
		after_saving = nil
	}
})
EOF


" +++
" modo zen
lua << EOF
	require("zen-mode").setup {
		window = {
			backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
    -- height and width can be:
    -- * an absolute number of cells when > 1
    -- * a percentage of the width / height of the editor when <= 1
    -- * a function that returns the width or the height
    			width = 120, -- width of the Zen window
    			height = 1, -- height of the Zen window
    -- by default, no options are changed for the Zen window
    -- uncomment any of the options below, or add other vim.wo options you want to apply
    			options = {
      -- signcolumn = "no", -- disable signcolumn
      -- number = false, -- disable number column
      -- relativenumber = false, -- disable relative numbers
      -- cursorline = false, -- disable cursorline
      -- cursorcolumn = false, -- disable cursor column
      -- foldcolumn = "0", -- disable fold column
      -- list = false, -- disable whitespace characters
    			},
  		},
  		plugins = {
    -- disable some global vim options (vim.o...)
    -- comment the lines to not apply the options
    			options = {
      				enabled = true,
      				ruler = false, -- disables the ruler text in the cmd line area
      				showcmd = false, -- disables the command in the last line of the screen
    			},
    			twilight = { enabled = true }, -- enable to start Twilight when zen mode opens
    			gitsigns = { enabled = false }, -- disables git signs
    			tmux = { enabled = false }, -- disables the tmux statusline
    -- this will change the font size on kitty when in zen mode
    -- to make this work, you need to set the following kitty options:
    -- - allow_remote_control socket-only
    -- - listen_on unix:/tmp/kitty
    			kitty = {
      				enabled = false,
      				font = "+4", -- font size increment
    			},
  		},
  -- callback where you can add custom code when the Zen window opens
  		on_open = function(win)
  		end,
  -- callback where you can add custom code when the Zen window closes
  		on_close = function()
  		end,
}
EOF


" +++
" bufferline
set termguicolors
lua << EOF
require('bufferline').setup{}
EOF


" floaterm
nnoremap <leader>tt :FloatermNew<cr>
nnoremap <leader>ty :FloatermToggle<cr>
nnoremap <leader>tp :FloatermNew python<cr>


" +++
"  telescope
lua << EOF
require('telescope').setup {
    defaults = {
        vimgrep_arguments = {
            },
            prompt_prefix = "   ", --⌦ 
            selection_caret = "  ",
            entry_prefix = "  ",
            initial_mode = "insert",
            selection_strategy = "reset",
            sorting_strategy = "ascending",
            layout_strategy = "horizontal",
            layout_config = {
                horizontal = {
                    prompt_position = "top",
                    preview_width = 0.55,
                    results_width = 0.8,
                    },
                    vertical = {
                        mirror = false,
                        },
                        width = 0.87,
                        height = 0.80,
                        preview_cutoff = 120,
                        },
                        file_sorter = require("telescope.sorters").get_fuzzy_file,
                        file_ignore_patterns = {},
                        generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
                        path_display = { "absolute" },
                        winblend = 0,
                        border = {},
                        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
                        color_devicons = true,
                        use_less = true,
                        set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
                        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
                        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
                        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
                        buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
                        },
                        extensions = {
                            fzf = {
                                fuzzy = true,
                                override_generic_sorter = false,
                                override_file_sorter = true,
                                case_mode = "smart_case",
                                },
                                media_files = {
                                    filetypes = { "png", "webp", "jpg", "jpeg" },
                                    find_cmd = "rg",
                                    },
                                    },
                        }
EOF
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>


" +++
" enfocado
set t_Co=256
set background=dark
let g:enfocado_style = 'neon'
"let g:enfocado_style = 'nature'
let g:enfocado_plugins = [
            \   'aerial',
            \   'bufferline',
            \   'cmp',
            \   'dap-ui',
            \   'indent-blankline',
            \   'lspconfig',
            \   'telescope',
            \ ]
colorscheme enfocado


" +++
" nerdtree
let g:NERDTreeGitStatusIndicatorMapCustom = {
            \ 'Modified'  :'✹',
            \ 'Staged'    :'✚',
            \ 'Untracked' :'✭',
            \ 'Renamed'   :'➜',
            \ 'Unmerged'  :'═',
            \ 'Deleted'   :'✖',
            \ 'Dirty'     :'✗',
            \ 'Ignored'   :'☒',
            \ 'Clean'     :'✔︎',
            \ 'Unknown'   :'?',
            \ }
let g:NERDTreeGitStatusUseNerdFonts = 1
let g:NERDTreeGitStatusShowIgnored = 0
let g:NERDTreeGitStatusUntrackedFilesMode = 'all'
let g:NERDTreeGitStatusShowClean = 1
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" +++++
nnoremap n nzzzv
nnoremap N Nzzzv
noremap <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
noremap <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

:imap ii <Esc>
noremap <leader>w :w<cr>
noremap <leader>ii :w!<cr>
noremap <leader>iq :wq<cr>
noremap <leader>q :q<cr>
noremap <leader>qq :q!<cr>
noremap <leader><Left> u<cr>
noremap <leader><Right> <C-r><cr>
noremap <leader>PP :PlugInstall<cr>
noremap <leader>PU :PlugUpdate<cr>
noremap <S-Right> :bn<CR>
noremap <S-left> :bp<CR>

set noshowmode
set ignorecase
filetype plugin indent on
set number relativenumber
set showmatch
set hidden
set backspace=indent,eol,start
set wildmenu
set nohlsearch
set wrap linebreak nolist

" +++
" configuracion splits
nnoremap <A-Up> :exe "resize " . (winheight(0) * 5/4)<CR>
nnoremap <A-Down> :exe "resize " . (winheight(0) * 4/5)<CR>
nnoremap <A-Right> :exe "vertical resize " . (winwidth(0) * 5/4)<CR>
nnoremap <A-Left> <Leader>Left :exe "vertical resize " . (winwidth(0) * 4/5)<CR>

map <C-Left> <C-w>h
map <C-Down> <C-w>j
map <C-Up> <C-w>k
map <C-Right> <C-w>l

nnoremap <silent> <C-q> :lclose<bar>b#<bar>:bd #<CR>
noremap <Leader>hh :<C-u>vsplit<CR>
" Crear un split horizontal

noremap <Leader>vv :<C-u>split<CR>
" Crear un split vertical

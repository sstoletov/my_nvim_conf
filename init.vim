set rnu

call plug#begin()

Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'tpope/vim-sensible'
Plug 'fatih/vim-go', { 'tag': '*' }
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'onsails/lspkind-nvim'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'windwp/nvim-autopairs'
Plug 'neovim/nvim-lspconfig'
Plug 'preservim/nerdtree'
Plug 'vim-airline/vim-airline-themes'
Plug 'https://github.com/folke/tokyonight.nvim.git'
Plug 'https://github.com/navarasu/onedark.nvim.git'
Plug 'https://github.com/nvim-tree/nvim-web-devicons.git'
Plug 'ryanoasis/vim-devicons'
Plug 'https://github.com/vim-airline/vim-airline.git'
Plug 'https://github.com/morhetz/gruvbox.git'

call plug#end()

lua << EOF
	require("ibl").setup()
EOF

let g:gruvbox_config = {
    \ 'style': 'darker',
\}

"colorscheme gruvbox

set background=dark
highlight Normal guibg=black ctermbg=black

set shiftwidth=4
set tabstop=4
set showtabline=2

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1             
let g:airline_theme='gruvbox'                       
let g:airline#extensions#whitespace#enabled = 0  
let g:airline#extensions#branch#enabled = 1   
let g:airline#extensions#hunks#enabled = 1

inoremap ( ()<Left>
inoremap [ []<Left>
inoremap { {}<Left>
inoremap " ""<Left>
inoremap ' ''<Left>

lua << EOF
  require("nvim-autopairs").setup {}
EOF

nnoremap <C-d> :NERDTreeToggle<CR>

lua << EOF
  require'lspconfig'.pyright.setup{}
  require'lspconfig'.ts_ls.setup{} 
  require'lspconfig'.gopls.setup{}        
  require'lspconfig'.rust_analyzer.setup{}
  require'lspconfig'.clangd.setup{} 

EOF

lua << EOF
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#expand"](args.body)
      end,
    },
    mapping = {
      ['<C-n>'] = cmp.mapping.select_next_item(),
      ['<C-p>'] = cmp.mapping.select_prev_item(),
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-u>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = {
      { name = 'nvim_lsp' },  
      { name = 'buffer' },   
      { name = 'path' },     
      { name = 'cmdline' },
    },
    formatting = {
      format = require'lspkind'.cmp_format({with_text = true, maxwidth = 50})
    }
  })
EOF

lua << EOF
  require'nvim-treesitter.configs'.setup {
    ensure_installed = { "c", "cpp", "lua", "python", "javascript", "html", "css" },
    highlight = { enable = true },
  }
EOF


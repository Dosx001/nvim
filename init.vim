filetype plugin on
filetype plugin indent on

set smartindent
set expandtab shiftwidth=2 tabstop=2 softtabstop=2
set path+=**
set complete-=i
set incsearch
set smartcase
set noswapfile
set nobackup
set nowrap
set hidden
set encoding=utf-8
set updatetime=100
set equalalways
set autoread
set showcmd
set noshowmode
set guicursor=a:ver25-blinkon0
set termguicolors
set list

augroup Start
  au!
  au VimResized * wincmd =
  au FileType json set filetype=jsonc
  au BufWinLeave <buffer> call clearmatches()
  au FileType help autocmd BufWinEnter <buffer=abuf> setlocal number relativenumber signcolumn=no
  au CursorMoved,CursorMovedI * call CenterCursor()
augroup END

fun! g:CenterCursor()
  let i = line('$') - line('.')
  if i < 30
    execute "set scrolloff=" . i
  else
    set scrolloff=999
  endif
endfun

com Py execute "wa | !clear; python3 '%:t'"
com Sass execute "wa | !clear; sass '%:t' > '%:t:r'.css"
com Restore execute "!git restore '%:p'"
com Source execute "w | source ~/.config/nvim/init.vim"
com Print execute "hardcopy > %.ps | !ps2pdf %.ps && rm %.ps"

set timeoutlen=5000
map <Space> <leader>
map <leader>i ^
map <leader>a $
map <leader>c i<C-x>s
map <leader>C :setlocal spell!<CR>
map <leader><C-c> zg
map <leader>v :vnew<CR>\z
map <leader>V <C-w>v
map <leader>s :new<CR>\z
map <leader>S <C-w>s
map <leader>t :tabe<CR>\z
map <leader>m :tab h 
map <leader>M :vert h 
map <leader>q <C-w>q
map <leader>Q :q!<CR>
map <leader><C-q> :qall!<CR>
map <leader>W :setlocal wrap!<CR>
map <leader>w <C-w>w
map <leader>x <C-w>x
map <leader>r :,s/
map <leader><C-r> :%s/
map <leader>u :earlier 1f<CR>
map <leader>U :earlier
map <leader>, q:<Up>
map <leader>. :<Up><CR>
map <leader>> :<Up>
map <leader>/ :noh<CR>
map <leader>0 :Source<CR>
map <leader>9 <cmd>source ~/.config/nvim/snippets/python.lua<CR>
map <leader>1 <cmd>set expandtab shiftwidth=4 tabstop=4 softtabstop=4<CR>
map <leader>o yyp<C-a>f.lDA 
ino <A-o> <Esc>yyp<C-a>f.2lDA
map gF :tabe <cfile><CR>
nno Y y$
map <expr> <A-i> "i" . nr2char(getchar()) . "<Esc>"
map <A-n> gt
map <A-p> gT
map <A-h> <C-w>h
map <A-j> <C-w>j
map <A-k> <C-w>k
map <A-l> <C-w>l
map <A-H> <C-w>5<
map <A-J> <C-w>5+
map <A-K> <C-w>5-
map <A-L> <C-w>5>
cno <A-k> <Up>
cno <A-j> <Down>
cno <A-h> <Left>
cno <A-l> <Right>
ino <C-v> <Esc>pi
ino <C-c> <C-x>s
ino <C-f> <C-x><C-f>
ino <C-h> <C-x><C-k>
ino <expr><Esc> col('.') == 1 ? "\<Esc>" : "\<Esc>l"
nno <F11> :Lazy! load 
nno <F12> :Lazy<CR>
nno <F5> :!<CR><CR>
ino <F5> <Esc>:!<CR><CR>
nno <C-p> $p
nno <C-s> :w<CR>
ino <C-s> <Esc>:w<CR>
nno <C-q> :wa<CR>
ino <C-q> <Esc>:wa<CR>
ino . .<C-g>u
ino <Space> <Space><C-g>u
map <A-r> <cmd>TSDisable rainbow \| TSEnable rainbow<CR>
nno <C-k> :call CtrlK()<CR>
ino <C-k> <Esc>:call CtrlK()<CR>

fun! g:CtrlK()
  let ft = expand('%:e')
  if ft == "py"
    execute "Py"
  elseif ft =~ 'html\|jsx\|tsx'
    call cursor(line('.'), len(getline('.')))
    call emmet#expandAbbr(3,"")
  elseif ft == "ts"
    execute "wa | !clear; tsc"
  endif
endfun

map gl <cmd>call NumList()<CR>
fun! g:NumList()
  let str = getline('.')
  let args = split(str)
  let ran = [1, 1, 1]
  let opt = split(args[0], ',')
  if len(opt) == 1
    let ran[1] = opt[0]
  elseif len(opt) == 2
    let ran[0] = opt[0]
    let ran[1] = opt[1]
  else
    let ran[0] = opt[0]
    let ran[1] = opt[1]
    let ran[2] = opt[2]
  endif
  norm 0D
  for i in range(ran[0], ran[1], ran[2])
    put = i . args[1]
  endfor
endfun

colorscheme default
hi Normal guifg=DarkGray
hi Comment ctermfg=4 guifg=#0037da
hi Constant ctermfg=1 guifg=#b30000
hi Special ctermfg=5 guifg=#881798
hi Identifier ctermfg=6 guifg=#3a96dd
" hi Function ctermfg=6 guifg=#e37d00
hi Statement ctermfg=130 gui=none guifg=#af5f00
hi PreProc ctermfg=5 guifg=#b3b300
hi Type ctermfg=2 gui=none guifg=#13a10e
hi Underlined term=underline cterm=underline ctermfg=5 gui=underline guifg=#881798

hi Visual ctermbg=235 guibg=#242424
hi VertSplit ctermfg=DarkRed ctermbg=237 guibg=#363636 guifg=#b30000
hi EndOfBuffer ctermfg=237 guifg=#363636 guibg=none
hi Pmenu ctermfg=1 ctermbg=Black guifg=#b30000 guibg=#0c0c0c
hi! link PmenuSel Visual
hi PmenuSbar ctermbg=248 guibg=Grey
hi PmenuThumb ctermbg=0 guibg=DarkRed
hi MsgArea guifg=#efefef
hi IncSearch gui=reverse,underline guifg=none guibg=none
hi Search term=reverse cterm=reverse gui=reverse guifg=none guibg=none
hi Title ctermfg=225 gui=none guifg=Magenta

hi DiffAdd ctermbg=22 gui=none guifg=Black guibg=#005f00
hi DiffChange ctermbg=3 gui=none guifg=Black guibg=#c19c00
hi DiffDelete ctermbg=88 gui=none guifg=Black guibg=#870000
hi DiffText term=reverse ctermbg=53 gui=none guifg=Black guibg=#5f005f

"set wildmenu
"hi WildMenu ctermfg=34 ctermbg=black

set showtabline=2
hi TabLine ctermfg=DarkRed ctermbg=234 gui=none guifg=#b30000 guibg=#1a1a1a
hi TabLineSel ctermfg=196 guifg=#ef0000 guibg=none
hi TabLineFill ctermfg=233 guifg=#111111

set number relativenumber
hi LineNr ctermfg=DarkRed ctermbg=234 guifg=#b30000 guibg=#1a1a1a

set colorcolumn=100
hi! link ColorColumn Visual

set cursorline
hi! link CursorLine Visual
hi CursorLineNR ctermbg=7 gui=none guifg=#a45900 guibg=#b3b3b3

"set cursorcolumn
"hi CursorColumn ctermbg=17

set signcolumn=yes
hi SignColumn ctermbg=none guibg=none

set listchars=tab:┆\ ,trail:•,extends:>,precedes:<,nbsp:~ ",eol:π
hi! link NonText Title
hi SpecialKey ctermfg=DarkRed guifg=#b30000
hi ExtendsChar ctermfg=DarkRed ctermbg=237 guifg=#b30000 guibg=#363636
hi PrecedesChar ctermfg=DarkRed ctermbg=237 guifg=#b30000 guibg=#363636
hi TrailChar ctermfg=DarkRed ctermbg=237 guifg=#b30000 guibg=#363636

set spelllang=en_us
hi SpellBad term=reverse ctermfg=Black ctermbg=Red guifg=#000000 guibg=#e74856
hi SpellCap term=reverse ctermfg=Black ctermbg=Blue guifg=#000000 guibg=#3b78ff
hi SpellRare term=reverse ctermfg=Black ctermbg=Magenta guifg=#000000 guibg=#b4009e
hi SpellLocal ctermfg=Black ctermbg=DarkCyan guifg=#000000 guibg=#3a96dd

lua require("init")

" Markdown Preview
let g:mkdp_open_ip = 'localhost'

" Sneak
map s s
map S S
map <A-s> <Plug>Sneak_s
map <A-S> <Plug>Sneak_S
nmap f <Plug>Sneak_f
nmap F <Plug>Sneak_F
nmap t <Plug>Sneak_t
nmap T <Plug>Sneak_T

" Surround
let g:surround_{99}  = "**\r**" " b
let g:surround_{105} = "*\r*" " i
let g:surround_{115} = "~~\r~~" " s

" System Copy
if system('uname -r | grep WSL')
  let g:system_copy#copy_command='/mnt/c/Windows/System32/clip.exe'
  let g:system_copy#paste_command='powershell.exe -NoProfile -command Get-Clipboard'
  let g:netrw_browsex_viewer="cmd.exe /C start"
endif

" Git Signs
hi GitSignsAdd ctermfg=green ctermbg=235 guifg=#3cef3c guibg=#242424
hi GitSignsChange ctermfg=226 ctermbg=235 guifg=#efef00 guibg=#242424
hi GitSignsDelete ctermfg=darkred ctermbg=235 guifg=#b30000 guibg=#242424
hi GitSignsChangeDelete ctermfg=202 ctermbg=235 guifg=#ef5900 guibg=#242424
map <A-]> <cmd>Gitsigns next_hunk<CR>
map <A-[> <cmd>Gitsigns prev_hunk<CR>
map <leader>g <cmd>Gitsigns preview_hunk<CR>

" Fire Nvim
map <F8> :set lines=10<CR>
if exists('g:started_by_firenvim')
  set filetype=markdown
endif

" Dail
nmap  <C-a>  <Plug>(dial-increment)
nmap  <C-x>  <Plug>(dial-decrement)
vmap  <C-a>  <Plug>(dial-increment)
vmap  <C-x>  <Plug>(dial-decrement)
vmap g<C-a> g<Plug>(dial-increment)
vmap g<C-x> g<Plug>(dial-decrement)

" Nvim TS Rainbow
hi IndentBlanklineIndent1 guifg=DarkRed gui=nocombine
hi IndentBlanklineIndent2 guifg=#974300 gui=nocombine
hi IndentBlanklineIndent3 guifg=#828200 gui=nocombine
hi IndentBlanklineIndent4 guifg=DarkGreen gui=nocombine
hi IndentBlanklineIndent5 guifg=DarkCyan gui=nocombine
hi IndentBlanklineIndent6 guifg=DarkBlue gui=nocombine
hi IndentBlanklineIndent7 guifg=DarkMagenta gui=nocombine
hi! link IndentBlanklineSpaceChar Title
hi link @variable Normal
" hi link @parameter Normal
" hi @parameter ctermfg=6 guifg=#e37d00

" Nvim Complation
hi CmpItemAbbrDeprecated gui=strikethrough guifg=DarkGray
hi CmpItemAbbrMatch guifg=#ef7f00
hi link CmpItemAbbrMatchFuzzy Type
hi link CmpItemAbbr Constant
hi link CmpItemKind Constant
hi link CmpItemMenu Constant
hi link CmpItemKindKeyword Statement
hi link CmpItemKindVariable Type
hi link CmpItemKindModule PreProc
" hi link CmpItemKindText Normal
hi CmpItemKindText guifg=DarkGray
hi link CmpItemKindFunction Identifier
hi link CmpItemKindMethod Identifier
hi link CmpItemKindProperty Comment
hi link CmpItemKindField Comment
hi link CmpItemKindClassDefault Special
hi link CmpItemKindSnippet Title
set completeopt=menu,menuone,noselect
map <A-}> <cmd>lua vim.diagnostic.goto_next()<CR>
map <A-{> <cmd>lua vim.diagnostic.goto_prev()<CR>
map <leader>f <cmd>CodeActionMenu<CR>
map <leader>F <cmd>lua vim.diagnostic.open_float()<CR>
map <leader>e <cmd>lua vim.lsp.buf.format()<CR>
map <leader>E <cmd>lua vim.lsp.buf.format{async = true}<CR>
map <leader>h <cmd>lua vim.lsp.buf.hover()<CR>
map <leader>R <cmd>lua vim.lsp.buf.rename()<CR>
map <leader>ld <cmd>lua vim.lsp.buf.definition()<CR>
map <leader>lD <cmd>lua vim.lsp.buf.declaration()<CR>
map <leader>li <cmd>lua vim.lsp.buf.implementation()<CR>
map <leader>la <cmd>lua vim.lsp.buf.add_workspace_folder()<CR>
map <leader>lr <cmd>lua vim.lsp.buf.reomve_workspace_folder()<CR>
map <leader>ll <cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>
map <leader>lR <cmd>lua vim.lsp.buf.references()<CR>
map <leader>lt <cmd>lua vim.lsp.buf.type_definition()<CR>

" Telescope
map <leader>zf <cmd>Telescope find_files<CR>
map <leader>zF <cmd>lua require('telescope.builtin').find_files{ cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1] }<CR>
map <leader>zg <cmd>Telescope live_grep<CR>
map <leader>zG <cmd>lua require('telescope.builtin').live_grep{ cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1] }<CR>
map <leader>zb <cmd>Telescope buffers<CR>
map <leader>zh <cmd>Telescope help_tags<CR>
map <leader>ze :e 
map <leader>zE :Ex<CR>

" DAP
map <F1> <cmd>lua require("dap").step_into()<CR>
map <F2> <cmd>lua require("dap").step_over()<CR>
map <F3> <cmd>lua require("dap").step_out()<CR>
map <F4> <cmd>lua require("dap").continue()<CR>
map <F8> <cmd>lua require("dap").pause()<CR>
map <F7> <cmd>lua require("dap").terminate()<CR>
map <leader>dc <cmd>lua require("dap").set_breakpoint(vim.fn.input("Condition: "))<CR>
map <leader>dr <cmd>lua require("dap").run_to_cursor()<CR>
map <leader>dR <cmd>lua require("dap").run_last()<CR>
map <leader>dh <cmd>lua require("dap.ui.widgets").hover()<CR>
map <leader>ds <cmd>lua require("dap.ui.widgets").scopes()<CR>
map <leader>dl <cmd>lua require("dap").goto_()<CR>

map <leader>dpm <cmd>lua require('dap-python').test_method()<CR>
map <leader>dpc <cmd>lua require('dap-python').test_class()<CR>
map <leader>dps <cmd>lua require('dap-python').debug_selection()<CR>

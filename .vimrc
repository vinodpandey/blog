" Enable pathogen for handling plugins
call pathogen#infect()
syntax on
filetype plugin indent on

" NERDTree configuration
nmap <silent> <c-n> :NERDTreeToggle<CR>
let NERDTreeIgnore=['\.pyc$','\~$']
let NERDTreeShowBookmarks=1

" map Ctrl+ space for omni completion
imap <C-Space> <C-x><C-o>
imap <C-@> <C-Space>

" Omni completion
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#CompleteCpp



" Pathogen config
    call pathogen#runtime_append_all_bundles()
    call pathogen#helptags()

" Global configuration

    set nocp                                       " make vim nocompatible with vi
    syntax on                                      " Activate the syntax color
    set number                                     " show line number
    colorscheme molokai                            " set color secheme
    au GUIEnter * set lines=48 columns=152         " set the window size
    winpos 420 80                                  " set the window position
    set cursorline                                 " highlight the current line
    " set cursorcolumn                             " highlight the current column
    set guifont=Monaco\ 10                         " set font and font size
    set go-=T                                      " hidde the menu
    set showmode                                   " sow the edit mode
    set ts=4                                       " set tab size
    set sw=4                                       " set tab size
    set sts=4                                      " set tab size
    set smartindent                                " intelligent autoindent
    filetype plugin on                             " enable file type detection and use of plugins
    " helptags ~/.vim/doc                            " read the documentation of the plugins
    set list                                       " show invisibles characteres by default
    set incsearch ignorecase hlsearch smartcase    " highlight,nocase and incremental searchs
    set guitablabel=%!expand(\"\%:t\")             " don't show the path in the tab
    set expandtab                                  " tabs to spaces
    filetype indent on                             " detect the kind of file for autoindent
    set hidden                                     " make Vim more liberal about hidden buffers
    set autochdir                                  " always switch to the current file directory..
    set showcmd                                    " Show current combination of keystrokes
    set title                                      " Change terminal title
    set ruler                                      " Show ruler with extra information
    set history=500                                " Commands to be rememebered
    set undolevels=1000                            " Undo levels
    set wildmenu                                   " show suggestions in the command line
    set undofile                                   " create files to save undo information
    set laststatus=2                               " show the status bar highlighted





    " Programming configuration

        " PHP config
            let php_sql_query=1
            let php_htmlInStrings=1
            let php_noShortTags = 1
            let php_folding = 0





" Functions

    function! <SID>StripTrailingWhitespaces()
        " Preparation: save last search, and cursor position.
        let _s=@/
        let l = line(".")
        let c = col(".")
        " Do the business:
        %s/\s\+$//e
        " Clean up: restore previous search history, and cursor position
        let @/=_s
    call cursor(l, c)
        endfunction

    function! <SID>FoldByKeys()
        " Preparation: save last search, and cursor position.
        let _s=@/
        let l = line(".")
        let c = col(".")
        " Do the business:
        set foldmethod=marker
        set foldmarker={,}
        " Clean up: restore previous search history, and cursor position
        let @/=_s
    call cursor(l, c)
        endfunction




" Maps

    let mapleader = ","

    " Shortcut to rapidly toggle 'set list'
    nmap <leader>l :set list!<CR>

    " Use the same symbols as TextMate for tabstops and EOLs
    set listchars=tab:▸\ ,eol:¬

    " map the folding
    inoremap <F9> <C-O>za
    nnoremap <F9> za
    onoremap <F9> <C-C>za
    vnoremap <F9> zf

    " map the function foldbykeys()
    nnoremap <silent> <F7> :call <SID>FoldByKeys()<CR> z<S-r>

    " map the function StripTrailingWhitespaces()
    nnoremap <silent> <F8> :call <SID>StripTrailingWhitespaces()<CR>

    "map delete blank lines
    nnoremap <silent> <F6> :g/^$/d<CR> gg

    " Press space to clear search highlighting and any message already displayed.
    nnoremap <silent> <Space> :silent noh<Bar>echo<CR>

    " Bubble single lines
    nmap <C-Up> [e
    nmap <C-Down> ]e
    " Bubble multiple lines
    vmap <C-Up> [egv
    vmap <C-Down> ]egv

    " Visually select the text that was last edited/pasted
    nmap gV `[v`]

    " shortcut to open the vimrc file
    nmap <leader>v :tabedit $MYVIMRC<CR>
    nmap <leader>g :tabedit $MYGVIMRC<CR>

    " Better tab navigation
    map <C-tab> gt
    imap <C-tab> <esc>gt
    map <C-S-tab> gT
    imap <C-S-tab> <esc>gT
    map <c-a> :tabnew<CR>i
    " :imap <c-a> <esc>:tabnew<CR>i

    " Better buffer navigation
    nmap <C-Right> :bn<CR>
    nmap <C-Left> :bp<CR>

    " Selection for search of words in lines
    map [I [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

    " Show syntax highlighting groups for word under cursor
    nmap <C-S-P> :call <SID>SynStack()<CR>
    function! <SID>SynStack()
      if !exists("*synstack")
        return
      endif
      echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
    endfunc

    " Toggle between NuMode and RNuMode
    nnoremap <leader>n :call g:ToggleNuMode()<cr>
    function! g:ToggleNuMode()
        if(&rnu == 1)
            set nu
        else
            set rnu
        endif
    endfunc





" Autocommands

    " Only do this part when compiled with support for autocommands
    if has("autocmd")

        " Syntax of these languages is fussy over tabs Vs spaces
        autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
        autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

        " Customisations based on house-style (arbitrary)
        autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab
        autocmd FileType xsl setlocal ts=2 sts=2 sw=2 expandtab
        autocmd FileType xml setlocal ts=2 sts=2 sw=2 expandtab

        " Treat .rss files as XML
        autocmd BufNewFile,BufRead *.rss setfiletype xml

        " Source the vimrc and gvimrc files after saving it
        autocmd BufWritePost .vimrc source ~/.vimrc
        autocmd BufWritePost .gvimrc source ~/.gvimrc

        autocmd BufWritePre *.* :call <SID>StripTrailingWhitespaces()

        autocmd BufRead,BufNewFile *.js set ft=javascript syntax=jquery

        au BufRead,BufNewFile *.tpl set filetype=smarty

        " :au FocusLost * :wa

    endif





" Plugins configurations

    " FuzzyFinder
        " :map <C-S-B> :FufBuffer<CR>
        " :map <C-S-F> :FufFile<CR>

    " MRU
        map <F2> :MRU<CR>

    " Snipplr
        let g:snipplr_rb = '~/../../bin/snipplr.rb'
        map <C-s> :SnipplrFind<CR>
        imap <C-s> <esc>:SnipplrFind<CR>

    " NerdTree
        map <F3> :NERDTreeToggle<CR>

    " Autocomplpop
        let g:acp_behaviorKeywordCommand = "\<C-x>\<C-o>"

    " Gundo
        nnoremap <F4> :GundoToggle<CR>

    " Tabularize
          nmap <Leader>t= :Tabularize /=<CR>
          vmap <Leader>t= :Tabularize /=<CR>
          nmap <Leader>t: :Tabularize /:\zs<CR>
          vmap <Leader>t: :Tabularize /:\zs<CR>

    " ZoomWin
          " :map <C-w>o :ZoomWin<CR>

    " Rainbow
         " if exists("g:btm_rainbow_color") && g:btm_rainbow_color
         "    call rainbow_parenthsis#LoadSquare ()
         "    call rainbow_parenthsis#LoadRound ()
         "    call rainbow_parenthsis#Activate ()
         " endif


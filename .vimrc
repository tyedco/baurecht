"scriptencoding utf-8
" ^^ Please leave the above line at the start of the file.

" Default configuration file for Vim
" $Header: /var/cvsroot/gentoo-x86/app-editors/vim-core/files/vimrc-r1,v 1.1 2005/03/08 21:44:19 ciaranm Exp $
" Modified by Ryan Phillips <rphillips@gentoo.org>

" You can override any of these settings on a global basis via the
" '/etc/vim/vimrc.local' file, and on a per-user basis via '~/.vimrc'. You may
" need to create these.

" {{{ General settings
" The following are some sensible defaults for Vim for most users.
" We attempt to change as little as possible from Vim's defaults,
" deviating only where it makes sense
set nocompatible        " Use Vim defaults (much better!)
set bs=2                " Allow backspacing over everything in insert mode
set ai                  " Always set auto-indenting on
set history=50          " keep 50 lines of command history
set ruler               " Show the cursor position all the time
set number              " shows the line number
set incsearch		" Searches while you are typing
set fileformats=dos
set viminfo='20,\"500   " Keep a .viminfo file.
set textwidth=78

" sets the indentation to 3
" indentation is done either
" by marking the whole block in visual mode: V
" and moving to the end then pressing '>' to indent
" or
"
" set tabstop=8 softtabstop=3 shiftwidth=3 noexpandtab 
set softtabstop=4 
set shiftwidth=4 
set expandtab 

let mapleader=","

"for ragtag expansion
let g:ragtag_global_maps = 1 

"get rid of folding feature
let Tex_FoldedSections=""
let Tex_FoldedEnvironments=""
let Tex_FoldedMisc=""
noremap ;; :%s:::g<Left><Left><Left>
noremap ;' :%s:::cg<Left><Left><Left><Left>

map ;ti :tabnew /home/ik/sh/lib/python/lawyers/import_pdf_to_db.py

"map <Space> <c-f>
map <F7> :w<CR>:!ispell -x -d british %<CR><CR>:e<CR><CR> "by pressing F7 you call ispell to do an interactive spellcheck

"these are shortcuts for latex
"what does the '!' mean?
imap ]i \item 
imap ]bi \begin{itemize}\item 
imap ]ei \end{itemize}
imap ]be \begin{enumerate}\item 
imap ]ee \end{enumerate}
imap ]bd \begin{description}\item[
imap ]ed \end{description}
imap ]bc \begin{center}
imap ]ec \end{center}
imap [be {\samepage\begin{eqnarray}
imap [ee \end{eqnarray}}
imap ]s1 \section{
imap ]s2 \subsection{
imap ]s3 \subsubsection{
imap ]p1 \paragraph{
imap ]p2 \subparagraph{
imap ]f \frac{

"sets the split windows to zero height that you only see a bar with the
"name of the file
set wmh=0

" When doing tab completion, give the following files lower priority. You may
" wish to set 'wildignore' to completely ignore files, and 'wildmenu' to enable
" enhanced tab completion. These can be done in the user vimrc file.
set suffixes+=.info,.aux,.log,.dvi,.bbl,.out
"Hack for latexsuite :help latex-suite.txt
set grepprg=grep\ -nH\ $*
" When displaying line numbers, don't use an annoyingly wide number column. This
" doesn't enable line numbers -- :set number will do that. The value given is a
" minimum width to use for the number column, not a fixed size.
if v:version >= 700
  set numberwidth=3
endif
" }}}

" {{{ Modeline settings
" We don't allow modelines by default. See bug #14088 and bug #73715.
" If you're not concerned about these, you can enable them on a per-user
" basis by adding "set modeline" to your ~/.vimrc file.
set nomodeline
" }}}

" {{{ Locale settings
" Try to come up with some nice sane GUI fonts. Also try to set a sensible
" value for fileencodings based upon locale. These can all be overridden in
" the user vimrc file.
if v:lang =~? "^ko"
  set fileencodings=euc-kr
  set guifontset=-*-*-medium-r-normal--16-*-*-*-*-*-*-*
elseif v:lang =~? "^ja_JP"
  set fileencodings=euc-jp
  set guifontset=-misc-fixed-medium-r-normal--14-*-*-*-*-*-*-*
elseif v:lang =~? "^zh_TW"
  set fileencodings=big5
  set guifontset=-sony-fixed-medium-r-normal--16-150-75-75-c-80-iso8859-1,-taipei-fixed-medium-r-normal--16-150-75-75-c-160-big5-0
elseif v:lang =~? "^zh_CN"
  set fileencodings=gb2312
  set guifontset=*-r-*
endif

" If we have a BOM, always honour that rather than trying to guess.
if &fileencodings !~? "ucs-bom"
  set fileencodings^=ucs-bom
endif

" Always check for UTF-8 when trying to determine encodings.
if &fileencodings !~? "utf-8"
  set fileencodings+=utf-8
endif

" Make sure we have a sane fallback for encoding detection
set fileencodings+=default
" }}}

" {{{ Syntax highlighting settings
" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif
" }}}

" {{{ Terminal fixes
if &term ==? "xterm"
  " Previously we would unset t_RV to prevent gnome-terminal from beeping as
  " vim started.  These days it appears that gnome-terminal has been repaired,
  " so re-enable this, and don't restrict t_Co=8.  (21 Jun 2004 agriffis)
  "set t_RV=			" don't check terminal version
  "set t_Co=8
  set t_Sb=^[4%dm
  set t_Sf=^[3%dm
  set ttymouse=xterm2	" only works for >=xfree86-3.3.3, should be okay
endif
" }}}

" {{{ Filetype plugin settings
" Enable plugin-provided filetype settings, but only if the ftplugin
" directory exists (which it won't on livecds, for example).
if isdirectory(expand("$VIMRUNTIME/ftplugin"))
  filetype plugin on

  " Uncomment the next line (or copy to your ~/.vimrc) for plugin-provided
  " indent settings. Some people don't like these, so we won't turn them on by
  " default.
  " filetype indent on
endif
" }}}

" {{{ Autocommands
if has("autocmd")

augroup gentoo
  au!

  " Gentoo-specific settings for ebuilds.  These are the federally-mandated
  " required tab settings.  See the following for more information:
  " http://www.gentoo.org/proj/en/devrel/handbook/handbook.xml
  " Note that the rules below are very minimal and don't cover everything.
  " Better to emerge app-vim/gentoo-syntax, which provides full syntax,
  " filetype and indent settings for all things Gentoo.
  au BufRead,BufNewFile *.e{build,class} let is_bash=1|setfiletype sh
  au BufRead,BufNewFile *.e{build,class} set ts=4 sw=4 noexpandtab

  " In text files, limit the width of text to 78 characters, but be careful
  " that we don't override the user's setting.
  autocmd BufNewFile,BufRead *.txt
        \ if &tw == 0 && ! exists("g:leave_my_textwidth_alone") |
        \     setlocal textwidth=78 |
        \ endif

  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
        \ if ! exists("g:leave_my_cursor_position_alone") |
        \     if line("'\"") > 0 && line ("'\"") <= line("$") |
        \         exe "normal g'\"" |
        \     endif |
        \ endif

  " When editing a crontab file, set backupcopy to yes rather than auto. See
  " :help crontab and bug #53437.
  autocmd FileType crontab set backupcopy=yes

augroup END

endif " has("autocmd")
" }}}

" {{{ vimrc.local
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif
" }}}

" vim: set fenc=utf-8 tw=80 sw=2 sts=2 et foldmethod=marker :
"
"
"set a few abbreviations for thesis
iab bcp \citep{
iab bct \citet{
iab stn sustainable
iab snby sustainability
iab SD sustainable development
iab envr environmental
iab NZ New Zealand
iab prc practice
iab wn SWNZ
iab PR Pernod Ricard
iab vny vineyard
iab hb Hawkes Bay
iab mrl Marlborough
iab gsb Gisborne
iab lvw Living Wine Group
iab scd scorecard
iab svb Sauvignon Blanc
iab gng genetic engineering
iab bd biodynamic
iab gm Grove Mill
iab cmtant comment = {,ant,}


if has("gui_running")
	set guifont=Monospace\ 12  " use this font
	colorscheme koehler
"	set columns=70
"else "if setting needed fo xterm
"they come here but I am quite happy how it is
endif
" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
filetype plugin on

" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
set shellslash

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: This enables automatic indentation as you type.
filetype indent on

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

"let's you indent text
set et
set sw=4
set smarttab 

"set nopaste
" preserves whitespace on pasting
set paste
"hides the toolbar in the gvim window
set guioptions-=T
" syntax highlighting groups
hi Comment	ctermfg=12

"cheat sheet:
"word count: g <C-g>

"substitute komma for newline:
":%s/,/<c-v> <enter> /gc

":% s/\<key=\([0-9]\+\)/Key='\1'/g 
"will locate all occurrances of ``key=number'' and replace them with Key='number', i.e. the word key will be capitalized and the following value will be enclosed in quotes

"the following example replaces 
"'2004)  The importance of sustainability' with
"2004],
"title = {The importance of sustainability
"and all similar year and title combinations
"http://www.geocities.com/volontir/
":%s/\(\d\d\d\d\))  \([A-Z]\)/\1},<C-V> <Enter>title = {\2/gc
":%s/\v(.*\n){5}/&\r         : insert a blank line every 5 lines *N*"
":%s/\(\p\+\)/(\1);/gc          :bracket the lines and put a semi-colon at
"the end
"this will change the first letter of a line into lower-case
":%s/^\s\+\u/\L&/gc
"f, jump to the next comma to the right

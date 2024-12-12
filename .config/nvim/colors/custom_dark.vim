" Name:		custom_dark
" Description:	This color scheme uses a dark palette for use in low light
" environments to avoid flashbanging the user when opening files :).
" Maintainer: Me! (probably change this if you ever intend to upload it
" anywhere though)
" Website: None
" License: MIT
" Last Change: 01/11/2024

" This needs to be here until i get around to giving equivalent colors for 
" less than 256 colors
if !has('gui_running') && &t_Co < 256
  finish
endif

hi clear

if exists('syntax_on')
  syntax reset
endif

let g:colors_name = 'custom_dark'


let g:usr_italics = get(g:, 'usr_italics', 0)
let g:usr_italics=1
" extra colours
" #b9b2dc
" #ccb1d8
" #dcb1d1
" #e7b3c8
" #eeb7be
" #f0bcb4
" #eec4ae
" #e8ccab
" #dfd4ac
" #d5dcb2 == berylgreen
"
" Color Palette
let s:p1        = '#17132a' " darkest base (general background?)
let s:p2        = '#221c40' "
let s:p3        = '#2f2758' "
let s:p4        = '#4b3f8d' "
let s:p5        = '#978ccb' " lightest base (normal text colour)

" let s:bribluppl      = '#'           " 
let s:blossom   = '#ddb1c7'     "red
let s:grncyan   = '#b2dcc7'     "green
let s:oliveylw  = '#dbdcb2'     "yellow
let s:litblugry = '#b2c7dc'     "blue"
let s:blupurpl  = '#b9b2dc'     "purple
let s:cyan      = '#36f9f6'     "cyan
let s:sand      = '#dccdb2'     "orange
let s:bribluppl = '#5c40e8'     "pink
let s:magenta   = '#e24091'     "magenta 
let s:purpheart = '#8c57ff'     "purple heart
let s:wldstrbry = '#f70a89'     "wild strawberry
let s:berylgrn  = '#d9dcb2'     "beryl green, base blupurpl's complement
let s:crete     = '#7f8c40'     "mid brightness green -- 'crete' "
let s:woodland  = '#545827'     "dull green
let s:undrgrwth = '#222211'     "dark green/brown
let s:wrnyellow = '#e8b41a'     "brighter yellow

" highlight Function
function! s:HL(group, fg, bg, attr)
    let l:attr = a:attr
    if !g:usr_italics && l:attr ==# 'italic'
        let l:attr = 'none'
    endif

    if !empty(a:fg)
        exec 'hi ' . a:group . ' guifg=' . a:fg
    endif
    if !empty(a:bg)
        exec 'hi ' . a:group . ' guibg=' . a:bg
    endif
    if !empty(a:attr)
        exec 'hi ' . a:group . ' gui=' . l:attr . ' cterm=' . l:attr
    endif
endfun

 
" basic colour declarations
" call s:HL('',                             '',                 '',             '')
call s:HL('ColorColumn',                    '',                 s:p4,           '')
call s:HL('Cursor',                         s:woodland,         s:p5,           '')
call s:HL('CursorColumn',                   '',                 s:p2,           '')
call s:HL('CursorLine',                     '',                 s:p2,           'none')
call s:HL('Directory',                      s:litblugry,        '',             '')
call s:HL('DiffAdd',                        s:p3,               s:grncyan,      'none')
call s:HL('DiffChange',                     s:p3,               s:oliveylw,     'none')
call s:HL('DiffDelete',                     s:p3,               s:blossom,      'none')
call s:HL('DiffText',                       s:p3,               s:litblugry,     'none')
call s:HL('ErrorMsg',                       s:wrnyellow,          s:p1,    'bold')
call s:HL('VertSplit',                      s:p4,               s:p1,    'none')
call s:HL('Fold',                           s:berylgrn,          s:undrgrwth,    '')
" call s:HL('FoldColumn',                   s:cyan,             s:p1,    '')
call s:HL('SignColumn',                     s:p2,               s:p1,    '')
call s:HL('LineNr',                         s:p4,               '',         '')
call s:HL('CursorLineNr',                   s:p5,               s:p2,    'none')
call s:HL('MatchParen',                     s:cyan,             '',     'bold')
call s:HL('ModeMsg',                        s:grncyan,          '',         '')
call s:HL('MoreMsg',                        s:grncyan,          '',         '')
call s:HL('NonText',                        s:p4,               '',         '')
call s:HL('Normal',                         s:p5,               s:p1,    'none')
call s:HL('Pmenu',                          s:p5,               s:p3,    '')
call s:HL('PmenuSel',                       s:p2,               s:litblugry,     '')
call s:HL('PmenuSbar',                      s:p3,               s:p4,    '')
call s:HL('PmenuThumb',                     s:p4,               s:p5,    '')
call s:HL('Question',                       s:grncyan,          '',         '')
call s:HL('Search',                         s:bribluppl,               s:p2,   '')
call s:HL('SpecialKey',                     s:p4,               '',         '')
call s:HL('SpellCap',                       s:litblugry,        '',         'undercurl')
call s:HL('SpellBad',                       s:blossom,          '',         'undercurl')
call s:HL('StatusLine',                     s:p5,               s:p3,    'none')
call s:HL('StatusLineNC',                   s:p2,               s:p4,    '')
call s:HL('TabLine',                        s:p3,               s:p1,    'none')
call s:HL('TabLineFill',                    s:p4,               s:p2,    'none')
call s:HL('TabLineSel',                     s:p2,               s:p4,    '')
call s:HL('Title',                          s:purpheart,        '',         'none')
call s:HL('Visual',                         s:p5,               s:p3,    '')
call s:HL('WarningMsg',                     s:wrnyellow,        '',         '')
call s:HL('WildMenu',                       s:p2,               s:litblugry,     '')

" Standard Syntax
call s:HL('Comment',                        s:p4,               '',         'italic')
call s:HL('Constant',                       s:blossom,          '',         '')
call s:HL('String',                         s:blupurpl,             '',         '')
call s:HL('Character',                      s:grncyan,          '',         '')
call s:HL('Identifier',                     s:magenta,         '',         'none')
call s:HL('Function',                       s:oliveylw,         '',         '')
call s:HL('Statement',                      s:litblugry,        '',         'none')
call s:HL('Operator',                       s:cyan,             '',         'none')
call s:HL('PreProc',                        s:cyan,             '',         '')
call s:HL('Define',                         s:litblugry,        '',         '')
call s:HL('Macro',                          s:litblugry,        '',         '')
call s:HL('Type',                           s:sand,             '',         'none')
call s:HL('Structure',                      s:magenta,          '',         '')
call s:HL('Special',                        s:cyan,             '',         '')
call s:HL('Underlined',                     s:litblugry,        '',         'undercurl')
call s:HL('Error',                          s:blossom,          s:p1,    'bold')
call s:HL('Todo',                           s:bribluppl,        s:p1,    'bold')
" Additional general syntax
call s:HL('TypeBuiltin',                    s:magenta,         '',          '')
call s:HL('CurSearch',                      s:p2,               s:bribluppl, '')
" OOP Syntax
call s:HL('Class',                          s:magenta,          '',      'bold')
" call s:HL('attribute')
" CSS/Sass/Less
call s:HL('cssAttrComma',                   s:grncyan,          '',         '')
call s:HL('cssAttributeSelector',           s:grncyan,          '',         '')
call s:HL('cssBraces',                      s:p5,               '',         '')
call s:HL('cssClassName',                   s:sand,             '',         '')
call s:HL('cssClassNameDot',                s:sand,             '',         '')
call s:HL('cssIdentifier',                  s:oliveylw,         '',         '')
call s:HL('cssImportant',                   s:blupurpl,         '',         '')
call s:HL('cssMediaType',                   s:blupurpl,         '',         '')
call s:HL('cssProp',                        s:p5,               '',         '')
call s:HL('cssSelectorOp',                  s:litblugry,        '',         '')
call s:HL('cssSelectorOp2',                 s:litblugry,        '',         '')

call s:HL('sassAmpersand',                  s:litblugry,        '',         '')
call s:HL('sassClass',                      s:sand,             '',         '')
call s:HL('sassClassChar',                  s:sand,             '',         '')

call s:HL('lessAmpersand',                  s:litblugry,        '',         '')
call s:HL('lessClass',                      s:sand,             '',         '')
call s:HL('lessClassChar',                  s:sand,             '',         '')
call s:HL('lessFunction',                   s:oliveylw,         '',         '')
call s:HL('lessCssAttribute',               s:p5,               '',         '')

" Git
call s:HL('gitcommitComment',               s:p4,               '',         'italic')
call s:HL('gitcommitOnBranch',              s:p4,               '',         'italic')
call s:HL('gitcommitFile',                  s:cyan,             '',         '')
call s:HL('gitcommitHeader',                s:blupurpl,         '',         '')
call s:HL('gitcommitBranch',                s:sand,             '',         '')
call s:HL('gitcommitUnmerged',              s:grncyan,          '',         '')
call s:HL('gitcommitUntrackedFile',         s:cyan,             '',         '')
call s:HL('gitcommitSelectedFile',          s:grncyan,          '',         '')
call s:HL('gitcommitDiscardedFile',         s:blossom,          '',         '')
call s:HL('gitcommitUnmergedFile',          s:oliveylw,         '',         '')
call s:HL('gitcommitSelectedType',          s:grncyan,          '',         '')
call s:HL('gitcommitDiscardedType',         s:blossom,          '',         '')
hi link gitcommitNoBranch       gitcommitBranch
hi link gitcommitUntracked      gitcommitComment
hi link gitcommitDiscarded      gitcommitComment
hi link gitcommitSelected       gitcommitComment
hi link gitcommitDiscardedArrow gitcommitDiscardedFile
hi link gitcommitSelectedArrow  gitcommitSelectedFile
hi link gitcommitUnmergedArrow  gitcommitUnmergedFile

" HTML
call s:HL('htmlArg',                        s:oliveylw,         '',         '')
call s:HL('htmlEndTag',                     s:blupurpl,         '',         '')
call s:HL('htmlTag',                        s:blupurpl,         '',         '')
call s:HL('htmlTagName',                    s:litblugry,        '',         '')
call s:HL('htmlTitle',                      s:p5,               '',         '')

" Javascript
call s:HL('javaScriptBraces',               s:p5,               '',         '')
call s:HL('javaScriptIdentifier',           s:litblugry,        '',         '')
call s:HL('javaScriptFunction',             s:litblugry,        '',         '')
call s:HL('javaScriptNumber',               s:blossom,          '',         '')
call s:HL('javaScriptReserved',             s:litblugry,        '',         '')
call s:HL('javaScriptRequire',              s:cyan,             '',         '')
call s:HL('javaScriptNull',                 s:blossom,          '',         '')

" Ruby
call s:HL('rubyBlockParameterList',         s:blupurpl,         '',         '')
call s:HL('rubyInterpolationDelimiter',     s:blupurpl,         '',         '')
call s:HL('rubyStringDelimiter',            s:grncyan,          '',         '')
call s:HL('rubyRegexpSpecial',              s:cyan,             '',         '')

" Vim-Fugitive
call s:HL('diffAdded',                      s:grncyan,          '',         '')
call s:HL('diffRemoved',                    s:blossom,          '',         '')

" Vim-Gittgutter
hi link GitGutterAdd    SignifySignAdd
hi link GitGutterChange SignifySignChange
hi link GitGutterDelete SignifySignDelete
call s:HL('GitGutterChangeDelete',          s:sand,             '',         '')

" Vim-Signify
call s:HL('SignifySignAdd',                 s:grncyan,          '',         '')
call s:HL('SignifySignChange',              s:oliveylw,         '',         '')
call s:HL('SignifySignDelete',              s:blossom,          '',         '')



"hi NormalFloat ctermbg=233 ctermfg=253 guibg=#110e20 guifg=#dcdcef
"hi Normal guibg=#221c3f guifg=#c2bce1 ctermbg=235 ctermfg=007
"hi ColorColumn cterm=NONE ctermbg=235 ctermfg=NONE guibg=#221c3f
"" hi CursorColumn
"hi CursorLine guibg=#342b5f ctermbg=236 ctermfg=NONE
"hi Cursor ctermbg=007 ctermfg=236 guibg=#c2bce1 guifg=#332a5f
"hi Delimiter guifg=#b9b2dc 
"hi StatusLine guibg=#a59cd3 guifg=#221c3f ctermbg=248 ctermfg=235
"hi Comment guifg=#6c5eb6 ctermfg=242 ctermbg=NONE
"hi custom_darkNormalFg ctermbg=233 ctermfg=253 guifg=#110e20 guifg=#dcdcef 
"hi Constant guifg=#fa9be8
"hi Error guifg=#f8ac07
"hi Warning guifg=#8b6004
"hi Statement guifg=#968bca
"hi String guifg=#ff8b39
"hi Identifier guifg=#a64cfa
"hi Type guifg=#b2dcd9
"hi Title guifg=#b004ff
"hi Special guifg=#36f9f6
"hi Operator guifg=#fede5d
"hi Function guifg=#36f9f6
"hi Number guifg=#c270e2
"hi Class guifg=#fe4450
"hi Fold guibg=#dee3c9 guifg=#2700ce
"
" end of colour definitions
"
" custom group declarations
hi! link Folded Fold
hi! link FoldColumn Fold
hi! link TabLine StatusLine
" start of group declarations
hi! link TermCursor Cursor
hi! link ToolbarButton TabLine
hi! link ToolbarLine TabLine
hi! link cssBraces Delimiter
hi! link cssClassName Special
hi! link cssClassNameDot custom_darkNormalFg
hi! link cssPseudoClassId Special
hi! link cssTagName Statement
hi! link helpHyperTextJump Constant
hi! link htmlArg Constant
hi! link htmlEndTag Statement
hi! link htmlTag Statement
hi! link jsonQuote custom_darkNormalFg
hi! link phpVarSelector Identifier
hi! link pythonFunction Function
"hi
hi! link rubyDefine Statement
hi! link rubyFunction Function
hi! link rubyInterpolationDelimiter String
hi! link rubySharpBang Comment
hi! link rubyStringDelimiter String
hi! link rustFuncCall custom_darkNormalFg
hi! link rustFuncName Title
hi! link rustType Constant
hi! link sassClass Special
hi! link shFunction custom_darkNormalFg
hi! link vimContinue Comment
hi! link vimFuncSID vimFunction
hi! link vimFuncVar custom_darkNormalFg
hi! link vimFunction Function
hi! link vimGroup Statement
hi! link vimHiGroup Statement
hi! link vimHiTerm Identifier
hi! link vimMapModKey Special
hi! link vimOption Identifier
hi! link vimVar custom_darkNormalFg
hi! link xmlAttrib Constant
hi! link xmlAttribPunct Statement
hi! link xmlEndTag Statement
hi! link xmlNamespace Statement
hi! link xmlTag Statement
hi! link xmlTagName Statement
hi! link yamlKeyValueDelimiter Delimiter
hi! link CtrlPPrtCursor Cursor
hi! link CtrlPMatch Title
hi! link CtrlPMode2 StatusLine
hi! link deniteMatched custom_darkNormalFg
hi! link deniteMatchedChar Title
hi! link elixirBlockDefinition Statement
hi! link elixirDefine Statement
hi! link elixirDocSigilDelimiter String
hi! link elixirDocTest String
hi! link elixirExUnitMacro Statement
hi! link elixirExceptionDefine Statement
hi! link elixirFunctionDeclaration Title
hi! link elixirKeyword Statement
hi! link elixirModuleDeclaration custom_darkNormalFg
hi! link elixirModuleDefine Statement
hi! link elixirPrivateDefine Statement
hi! link elixirStringDelimiter String
hi! link jsFlowMaybe custom_darkNormalFg
hi! link jsFlowObject custom_darkNormalFg
hi! link jsFlowType PreProc
hi! link graphqlName custom_darkNormalFg
hi! link graphqlOperator custom_darkNormalFg
hi! link gitmessengerHash Comment
hi! link gitmessengerHeader Statement
hi! link gitmessengerHistory Constant
hi! link jsArrowFunction Operator
hi! link jsClassDefinition custom_darkNormalFg
hi! link jsClassFuncName Title
hi! link jsExport Statement
hi! link jsFuncName Title
hi! link jsFutureKeys Statement
hi! link jsFuncCall custom_darkNormalFg
hi! link jsGlobalObjects Statement
hi! link jsModuleKeywords Statement
hi! link jsModuleOperators Statement
hi! link jsNull Constant
hi! link jsObjectFuncName Title
hi! link jsObjectKey Identifier
hi! link jsSuper Statement
hi! link jsTemplateBraces Special
hi! link jsUndefined Constant
hi! link markdownBold Special
hi! link markdownCode String
hi! link markdownCodeDelimiter String
hi! link markdownHeadingDelimiter Comment
hi! link markdownRule Comment
hi! link ngxDirective Statement
hi! link plug1 custom_darkNormalFg
hi! link plug2 Identifier
hi! link plugDash Comment
hi! link plugMessage Special
hi! link SignifySignAdd GitGutterAdd
hi! link SignifySignChange GitGutterChange
hi! link SignifySignChangeDelete GitGutterChangeDelete
hi! link SignifySignDelete GitGutterDelete
hi! link SignifySignDeleteFirstLine SignifySignDelete
hi! link StartifyBracket Comment
hi! link StartifyFile Identifier
hi! link StartifyFooter Constant
hi! link StartifyHeader Constant
hi! link StartifyNumber Special
hi! link StartifyPath Comment
hi! link StartifySection Statement
hi! link StartifySlash Comment
hi! link StartifySpecial custom_darkNormalFg
hi! link svssBraces Delimiter
hi! link swiftIdentifier custom_darkNormalFg
hi! link TSAttribute Special
hi! link TSBoolean Constant
hi! link TSCharacter Constant
hi! link TSComment Comment
hi! link TSConstructor custom_darkNormalFg
hi! link TSConditional Statement
hi! link TSConstant Constant
hi! link TSConstBuiltin Constant
hi! link TSConstMacro Constant
hi! link TSError Error
hi! link TSException Warning
hi! link TSField custom_darkNormalFg
hi! link TSFloat Constant
hi! link TSInclude Statement
hi! link TSKeyword Statement
hi! link TSKeywordFunction Statement
hi! link TSFunction Function
hi! link TSLabel Special
hi! link TSNamespace Statement
hi! link TSNumber Constant
hi! link TSOperator Operator
hi! link TSParameter custom_darkNormalFg
hi! link TSParameterReference custom_darkNormalFg
hi! link TSProperty custom_darkNormalFg
hi! link TSPunctDelimiter Delimiter
hi! link TSPunctBracket Delimiter
hi! link TSPunctSpecial Special
hi! link TSRepeat Statement
hi! link TSString String
hi! link TSStringRegex String
hi! link TSStringEscape Special
hi! link TSTag htmlTagName
hi! link TSTagAttribute htmlArg
hi! link TSTagDelimiter htmlTagName
hi! link TSText custom_darkNormalFg
hi! link TSTitle Title
hi! link TSType Type
hi! link TSTypeBuiltin TypeBuiltin
hi! link TSVariable custom_darkNormalFg
hi! link TSVariableBuiltin Statement
hi! link typescriptAjaxMethods custom_darkNormalFg
hi! link typescriptBraces Delimiter
hi! link typescriptEndColons Delimiter 
hi! link typescriptFuncKeyword Statement
hi! link typescriptGlobalObjects Statement
hi! link typescriptHtmlElemProperties custom_darkNormalFg
hi! link typescriptIdentifier Statement
hi! link typescriptMessage custom_darkNormalFg
hi! link typescriptNull Constant
hi! link typescriptParens custom_darkNormalFg

if has('nvim-0.8')
  hi! link @attribute TSAttribute
  hi! link @boolean TSBoolean
  hi! link @character TSCharacter
  hi! link @comment TSComment
  hi! link @constructor TSConstructor
  hi! link @conditional TSConditional
  hi! link @constant TSConstant
  hi! link @constant.builtin TSConstBuiltin
  hi! link @constant.macro TSConstMacro
  hi! link @error TSError
  hi! link @exception TSException
  hi! link @field TSField
  hi! link @float TSFloat
  hi! link @function TSFunction
  hi! link @function.builtin TSFunctionBuiltin
  hi! link @function.macro TSFunctionMacro
  hi! link @include TSInclude
  hi! link @keyword TSKeyword
  hi! link @keyword.function TSKeywordFunction
  hi! link @label TSLabel
  hi! link @method TSMethod
  hi! link @namespace TSNamespace
  hi! link @number TSNumber
  hi! link @operator TSOperator
  hi! link @parameter TSParameter
  hi! link @parameter.reference TSParameterReference
  hi! link @property TSProperty
  hi! link @punctuation.delimiter TSPunctDelimiter
  hi! link @punctuation.bracket TSPunctBracket
  hi! link @punctuation.special TSPunctSpecial
  hi! link @repeat TSRepeat
  hi! link @string TSString
  hi! link @string.regex TSStringRegex
  hi! link @string.escape TSStringEscape
  hi! link @tag TSTag
  hi! link @tag.attribute TSTagAttribute
  hi! link @tag.delimiter TSTagDelimiter
  hi! link @text TSText
  hi! link @text.note Todo
  hi! link @text.title TSTitle
  hi! link @text.uri TSURI
  hi! link @type TSType
  hi! link @type.builtin TSTypeBuiltin
  hi! link @variable TSVariable
  hi! link @variable.builtin TSVariableBuiltin
endif

if !has('nvim')
  hi! link SpecialKey Whitespace
endif


if has("nvim") && exists("&termguicolors") && &termguicolors
    let g:terminal_color_0  = "#17132a"
    let g:terminal_color_8  = "#221c40"
    let g:terminal_color_1  = "#ddb1c7"
    let g:terminal_color_9  = "#dccdb2"
    let g:terminal_color_2  = "#b2dcc7"
    let g:terminal_color_10 = "#b2dcc7" 
    let g:terminal_color_3  = "#dbdcb2" 
    let g:terminal_color_11 = "#dbdcb2" 
    let g:terminal_color_4  = "#b2c7dc"
    let g:terminal_color_12 = "#b2c7dc"
    let g:terminal_color_5  = "#b9b2dc"
    let g:terminal_color_13 = "#5c40e8"
    let g:terminal_color_6  = "#36f9f6" 
    let g:terminal_color_14 = "#4b3f8d"
    let g:terminal_color_7  = "#2f2758"
    let g:terminal_color_15 = "#978ccb"
endif

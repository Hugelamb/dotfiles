-- LaTeX math environment snippets (
local utils = require('luasnippets.utils')
local tex_utils = require('tex.utils')
-- Table snippet definitions
M = {
-- Symbols
  s({ trig = "iff", dscr = "Latex \\iff", snippetType="autosnippet" },
    t"\\iff",
  { condition = tex_utils.in_mathzone }
  ),        
-- Fonts
  s({ trig = "rm", dscr = "normal text", snippetType="autosnippet" },
    fmta(
      [[
      \textrm{ <> } <>
      ]],
      {
        i(1),
        i(0)
      }
    ),
  { condition = tex_utils.in_mathzone }
  ),  

  s({trig="cf", dscr="calligraphic typeface", snippetType="autosnippet"},
    fmta(
      [[
      \mathcal{<>} <>
      ]],
      { i(1), i(0) }
    ),  
    { condition = tex_utils.in_mathzone }
  ),
  s({trig="frak", dscr="fraktur typeface", snippetType="autosnippet"},
    fmta(
      [[
      \mathfrak{<>} <>
      ]],
      { i(1), i(0) }
    ),
    { condition = tex_utils.in_mathzone }
  ),
  s({ trig = "bf", dscr = "math bold typeface", snippetType="autosnippet" },
    fmta(
      [[
    \mathbf{<>} <>
    ]],
      {
        i(1), i(0)
      }
    ),
    { condition = tex_utils.in_mathzone }
  ),
  s({ trig = "bb", dscr = "blackboard typeface", snippetType="autosnippet"},
    fmt(
      [[
    \mathbb{<>}
    ]],
      { i(1) },
      { delimiters = "<>" }
    ),
    { condition = tex_utils.in_mathzone }  
  ),
  s({ trig = "ff", dscr = "trigger fraction environment", snippetType="autosnippet"},
    fmta(
      [[
    \frac{<>}{<>}
    ]],
      { i(1,"num"), i(2,"den") }
    ),
    { condition = tex_utils.in_mathzone }
  ),
-- Superscript snippet
  s({ trig = "([%w%)%]%}])^", dscr = "Superscript", wordTrig=false, regTrig=true,snippetType="autosnippet" },
    fmta(
    "<>^{<>}",
      {
        f( function(_, snip) return snip.captures[1] end ),
        d(1, utils.get_visual),
      }
    ),
    { condition = tex_utils.in_mathzone }
  ),  
-- Subscript snippet
  s({trig = "([%w%)%]%}])_", wordTrig=false, regTrig = true, snippetType="autosnippet"},
    fmta(
      "<>_{<>}",
      {
        f( function(_, snip) return snip.captures[1] end ),
        d(1, utils.get_visual),
      }
    ),
    {condition = tex_utils.in_mathzone}
  ),
  s({trig = "([%w%)%]%}])\"", wordTrig=false, regTrig = true, snippetType="autosnippet"},
    fmta(
      "<>^{<>}_{<>}",
      {
        f( function(_, snip) return snip.captures[1] end ),
        i(1),
        i(2),
      }
    ),
    {condition = tex_utils.in_mathzone}
  ),
  -- Operations 
  s({ trig = "==", dscr = "equals", snippetType="autosnippet" },
    t"&=",
    { condition = tex_utils.in_mathzone }
  ),    
  s({ trig = "neq", dscr = "not equal", snippetType="autosnippet" },
    t"\\neq",
    { condition = tex_utils.in_mathzone }
  ),  
  ms({ 
    common = {
      snippetType="autosnippet", condition=tex_utils.in_mathzone
    },
    "cnr",
    "binom",
    "ncr"
  }, {
      t"\\binom{",
      i(1),
      t"}{",
      i(2),
      t"}",
      i(0)
    }),
  s({ trig = "tr", dscr = "transpose of Matrix", snippetType="autosnippet" },
    fmta(
      [[
    <>^\intercal <>
    ]],
      {
        i(1,"A"),
        i(0)
      }
    ),
    { condition = tex_utils.in_mathzone }
  ),  
  s({ trig = "norm", dscr = "matrix norm" },
    fmta(
      [[
      \norm{<>}
      ]],
      {
        i(1)
      }
    ),
    { condition = tex_utils.in_mathzone}
  ), 
  

-- Cases and matrices
  s({ trig = "(%d?)cases", name = "cases", dscr = "cases", regTrig = true, hidden = true, snippetType="autosnippet" },
    fmta(
    [[
    \begin{cases}
    <>
    \end{cases}
    ]],
      { d(1, tex_utils.generate_cases) }),
  { condition = tex_utils.in_mathzone, show_condition = tex_utils.in_mathzone }
  ),  
         
s({trig = "([bBpvV])mat(%d+)x(%d+)([ar])", name = "[bBpvV]matrix", dscr = "matrices", regTrig = true, trigEngine = "pattern"},
  fmta([[
    \begin{<>}<>
    <>
    \end{<>}]],
    {f(function(_, snip)
      return snip.captures[1] .. "matrix"
    end),
      f(function(_, snip)
        if snip.captures[4] == "a" then
          out = string.rep("c", tonumber(snip.captures[3]) - 1)
          return "[" .. out .. "|c]"
        end
        return ""
      end),
      d(1, tex_utils.generate_matrix),
      f(function(_, snip)
        return snip.captures[1] .. "matrix"
      end)
    }),
  { condition = tex_utils.in_mathzone, show_condition = tex_utils.in_mathzone }),
}
--  s({ trig = "(%d?)mat", dscr = "description" },
--    fmta(
--    snippet
--    )
--  ),  
-- Auto backslash snippets from evesdropper


local auto_backslash_specs = {
  -- trigonometry
  "arcsin",
  "sin",
  "arccos",
  "cos",
  "arctan",
  "tan",
  "cot",
  "csc",
  "sec",
  -- logs and exponentials
  "log",
  "ln",
  "exp",
  -- symbols in math envs
  "ast", -- asterisk
  "star",
  "perp",
  "sup",
  "infty",
  "det",
  "max",
  "min",
  "argmax",
  "argmin",
  "deg",
  "angle",
  "pi",
  "sum",
  -- alternate character/symbol calls
  "gamma",
  "Gamma",
  "Delta",
  "lambda",
  "Lambda",
  "sigma",
  "Sigma",
  "int",
  "diff",
  "times",
  "prime"


}
local auto_backslash_snippets = {}
for _, v in ipairs(auto_backslash_specs) do
  table.insert(auto_backslash_snippets, tex_utils.auto_backslash_snippet({ trig = v }, { condition = tex_utils.in_mathzone }))
end
vim.list_extend(M, auto_backslash_snippets)
local greek_specs = {
  alpha = { context = { name = "α" }, command = [[\alpha]] },
  beta = { context = { name = "β" }, command = [[\beta]] },
  gam = { context = { name = "γ" }, command = [[\gamma]] },
  Gam = { context = { name = "Γ" }, command = [[\Gamma]] },
  delta = { context = { name = "δ" }, command = [[\delta]] },
  DD = { context = { name = "Δ" }, command = [[\Delta]] },
  eps = { context = { name = "ε" , priority = 500 }, command = [[\epsilon]] },
  veps = { context = { name = "ε" }, command = [[\varepsilon]] },
  zeta = { context = { name = "ζ" }, command = [[\zeta]] },
  eta = { context = { name = "η" , priority = 500}, command = [[\eta]] },
  theta = { context = { name = "θ" }, command = [[\theta]] },
  Theta = { context = { name = "Θ" }, command = [[\Theta]] },
  iota = { context = { name = "ι" }, command = [[\iota]] },
  kappa = { context = { name = "κ" }, command = [[\kappa]] },
  lmbd = { context = { name = "λ" }, command = [[\lambda]] },
  Lmbd = { context = { name = "Λ" }, command = [[\Lambda]] },
  mu = { context = { name = "μ" }, command = [[\mu]] },
  nu = { context = { name = "ν" }, command = [[\nu]] },
  xi = { context = { name = "ξ" }, command = [[\xi]] },
  pi = { context = { name = "π" }, command = [[\pi]] },
  rho = { context = { name = "ρ" }, command = [[\rho]] },
  sig = { context = { name = "σ" }, command = [[\sigma]] },
  Sig = { context = { name = "Σ" }, command = [[\Sigma]] },
  tau = { context = { name = "τ" }, command = [[\tau]] },
  ups = { context = { name = "υ" }, command = [[\upsilon]] },
  phi = { context = { name = "φ" }, command = [[\phi]] },
  vphi = { context = { name = "φ" }, command = [[\varphi]] },
  chi = { context = { name = "χ" }, command = [[\chi]] },
  psi = { context = { name = "Ψ" }, command = [[\psi]] },
  omega = { context = { name = "ω" }, command = [[\omega]] },
  Omega = { context = { name = "Ω" }, command = [[\Omega]] },
}
-- Greek character symbol snippets
local greek_snippets = {}
for k, v in pairs(greek_specs) do
  table.insert(
    greek_snippets,
    tex_utils.symbol_snippet(vim.tbl_deep_extend("keep", { trig = k }, v.context), v.command, { condition = tex_utils.in_mathzone })
  )
end
vim.list_extend(M, greek_snippets)

local symbol_specs = {
  -- operators
  ['ll'] = { context = { name = 'less than' }, command = [[\ll]] },
  ['gg'] = { context = { name = 'greater than' }, command = [[\gg]] },
  ['sim'] = { context = { name = 'similar' }, command = [[\sim]] },
  ['approx'] = { context = { name = 'approx' }, command = [[\approx]] },
  ['cong'] = { context = { name = 'congruent to' }, command = [[\cong]] },
  [':='] = { context = { name = ':=' }, command = [[\coloneq]] },
  ['cdot'] = { context = { name = '.' }, command = [[\cdot]] },
  ["%.%.%."] = { context = {name = '...'}, command = [[\dots]]},
  -- ['xx'] = { context = { name = '\\times' }, command = [[\times]] },
  -- ['!+'] = { context = { name = '⊕' }, command = [[\oplus]] },
  -- ['!*'] = { context = { name = '⊗' }, command = [[\otimes]] },
  -- set notations
  ['NN'] = { context = { name = '\\mathbb{N}' }, command = [[\mathbb{N}]] },
  ['ZZ'] = { context = { name = '\\mathbb{Z}' }, command = [[\mathbb{Z}]] },  
  QQ = { context = { name = "ℚ" }, command = [[\mathbb{Q}]] },
  RR = { context = { name = "ℝ" }, command = [[\mathbb{R}]] },
  CC = { context = { name = "ℂ" }, command = [[\mathbb{C}]] },
  OO = { context = { name = "∅" }, command = [[\emptyset]] },
  pwr = { context = { name = "P" }, command = [[\powerset]] },
  cc = { context = { name = "⊂" }, command = [[\subset]] },
  cq = { context = { name = "⊆" }, command = [[\subseteq]] },
  qq = { context = { name = "⊃" }, command = [[\supset]] },
  qc = { context = { name = "⊇" }, command = [[\supseteq]] },
  Nn = { context = { name = "∩" }, command = [[\cap]] },
  UU = { context = { name = "∪" }, command = [[\cup]] },
  ["::"] = { context = { name = ":" }, command = [[\colon]] },
  -- logic and quantifier symbols
  AA = { context = { name = "∀" }, command = [[\forall]] },
  EE = { context = { name = "∃" }, command = [[\exists]] },
  -- isin = { context = { name = "∈" }, command = [[\in]] },
  -- notin = { context = { name = "∉" }, command = [[\not\in]] },
  -- ["!-"] = { context = { name = "¬" }, command = [[\lnot]] },
  VV = { context = { name = "∨" }, command = [[\lor]] },
  WW = { context = { name = "∧" }, command = [[\land]] },
  -- ["!!"] = { context = {name = "neg"}, command = [[\neg]] },
  -- ["!W"] = { context = { name = "∧" }, command = [[\bigwedge]] },
  -- ["=>"] = { context = { name = "⇒" }, command = [[\implies]] },
  -- ["=<"] = { context = { name = "⇐" }, command = [[\impliedby]] },
  iff = { context = { name = "⟺" }, command = [[\iff]] },
  ["to"] = { context = { name = "→", priority = 250 }, command = [[\to]] },
  -- ["!>"] = { context = { name = "→" }, command = [[\mapsto]] },
  -- ["<-"] = { context = { name = "←", priority = 250}, command = [[\gets]] },
  -- differentials 
  -- dd = { context = { name = "⇒" }, command = [[\dl]] },
  dp = { context = { name = "∂" }, command = [[\partial]] },
  -- arrows
  rarl = { context = { name = "⟶", priority = 500 }, command = [[\longrightarrow]] },
  lrar = { context = { name = "↔", priority = 500 }, command = [[\leftrightarrow]] },
  rrar = { context = { name = "⇉", priority = 400 }, command = [[\rightrightarrows]] },
  upar = { context = { name = "↑" }, command = [[\uparrow]] },
  dnar = { context = { name = "↓" }, command = [[\downarrow]] },
  -- etc
  ['inf'] = { context = { name = 'infinity' }, command = [[\infty]] },
  ['ell'] = { context = { name = 'special l symbol' }, command = [[\ell]] },
  -- ['+-'] = { context = { name = 'plusminus' }, command = [[\pm]] },
  -- ['-+'] = { context = { name = 'minusplus' }, command = [[\mp]] },
}

local symbol_snippets = {}
for k, v in pairs(symbol_specs) do
  table.insert(
    symbol_snippets,
    tex_utils.symbol_snippet(vim.tbl_deep_extend("keep", { trig = k }, v.context), v.command, { condition = tex_utils.in_mathzone })
  )
end
vim.list_extend(M, symbol_snippets)





-- END LIST --
return M


-- Snippets focussing on creation and manipulation of mathematical and logical figures
-- such as graphs, diagrams, flowcharts and the like
local tex_utils = require("tex.utils")

return {
  s({ trig = "fig", dscr = "Figure environment" },
    fmta(
    [[
    \begin{figure}[<>]
      \centering
      \includegraphics[width=0.8\textwidth]{<>}
      \caption{<>}
      \label{fig:<>}
    \end{figure}
    ]],
      {
        c(1, {
          t("h"),
          t("t"),
          t("b"),
          t("p"),
        }),
        i(2,"image_file"),
        d(3, function(args)
          return sn(nil, {
            i(2, args[1])     -- copy contents of node i(2)
          })
        end,
          {1}),
        t("figure_test")
      }

    )
  ),
  s({ trig = "tzs", dscr = "create new tikz style" },
    fmta(
      [[
      \tikzstyle{<>}      = [<>]
      ]],
      {
        i(1),
        i(2)
      }
    )
  ),  
}

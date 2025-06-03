return {
  "neovim/nvim-lspconfig",

  opts = {
    -- make sure mason installs the server
    servers = {
      -- denols = {
      --   filetypes = { "typescript", "typescriptreact" },
      --   root_dir = function(...)
      --     return vim.fs.root(0, { "deno.json", "deno.jsonc" })
      --   end,
      -- },
      vtsls = {
        root_dir = function()
          return not vim.fs.root(0, { "deno.json", "deno.jsonc" })
            and vim.fs.root(0, {
              "tsconfig.json",
              "jsconfig.json",
              "package.json",
              ".git",
            })
        end,
        single_file_support = false,
        settings = {
          javascript = {
            preferences = {
              importModuleSpecifier = "non-relative",
            },
          },
          typescript = {
            preferences = {
              importModuleSpecifier = "non-relative",
            },
          },
        },
      },
    },

    setup = {
      tailwindcss = function(_, opts)
        local tw = LazyVim.lsp.get_raw_config("tailwindcss")
        opts.filetypes = opts.filetypes or {}

        -- Add default filetypes
        vim.list_extend(opts.filetypes, tw.default_config.filetypes)

        -- Remove excluded filetypes
        --- @param ft string
        opts.filetypes = vim.tbl_filter(function(ft)
          return not vim.tbl_contains(opts.filetypes_exclude or {}, ft)
        end, opts.filetypes)

        -- Additional settings for Phoenix projects
        opts.settings = {
          tailwindCSS = {
            includeLanguages = {
              elixir = "html-eex",
              eelixir = "html-eex",
              heex = "html-eex",
            },

            experimental = {
              classRegex = {
                { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
                { "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
                { "cn\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
                { "([a-zA-Z0-9\\-:]+)" },
              },
            },
          },
        }

        -- Add additional filetypes
        vim.list_extend(opts.filetypes, opts.filetypes_include or {})
      end,
    },

    inlay_hints = { enabled = false },
  },
}

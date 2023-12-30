return {
  "neovim/nvim-lspconfig",
  opts = {
    -- make sure mason installs the server
    servers = {
      ---@type lspconfig.options.tsserver
      tsserver = {
        settings = {
          typescript = {
            preferences = {
              importModuleSpecifierPreference = "non-relative",
              importModuleSpecifier = "non-relative",
              importModuleSpecifierEnding = "minimal",
            },
          },
          javascript = {
            preferences = {
              importModuleSpecifierPreference = "non-relative",
              importModuleSpecifier = "non-relative",
              importModuleSpecifierEnding = "minimal",
            },
          },
        },
      },
    },
  },
}

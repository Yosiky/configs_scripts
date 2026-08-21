return {
    {
        "olimorris/codecompanion.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            -- "nvim-treesitter/nvim-treesitter",
        },
        opts = {
            adapters = {
                ollama = function()
                    return require("codecompanion.adapters").extend("ollama", {
                        schema = {
                            model = {
                                default = "codegemma", -- Укажите вашу модель, например: deepseek-coder, qwen2.5-coder
                            },
                            num_ctx = {
                                default = 8192, -- Размер контекстного окна (зависит от модели)
                            },
                        },
                    })
                end,
            },
            strategies = {
                chat = {
                    adapter = "ollama",
                },
                inline = {
                    adapter = "ollama",
                },
            },
        },
    }
}

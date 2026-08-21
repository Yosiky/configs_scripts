return {
    {
        "Civitasv/cmake-tools.nvim",
        ft = { "c", "cpp", "cmake" },
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            cmake_use_preset = true,
            cmake_regenerate_on_save = true,
        },
        keys = {
            { "<leader>cg", "<cmd>CMakeGenerate<cr>", desc = "CMake configure" },
            { "<leader>cb", "<cmd>CMakeBuild<cr>", desc = "CMake build" },
            { "<leader>cr", "<cmd>CMakeRun<cr>", desc = "CMake run" },
            { "<leader>ct", "<cmd>CMakeRunTest<cr>", desc = "CMake tests" },
        },
    },
}

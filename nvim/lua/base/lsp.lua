vim.lsp.config['clangd'] = {
    cmd = {'clangd'},
    filetypes = {"c", "cpp", "objc", "objcpp", "cuda"},
    root_markers = {
        ".clangd", ".clang-tidy", ".clang-format",
        "compile_commands.json", "compile_flags.txt", "configure.ac",
        ".git", "build"
    },
    cpapbilities = {
        offsetEncoding = {"utf-8", "utf-16"},
        textDocument = {
            completion = { editsNearCursor = true }
        }
    }
}
vim.lsp.enable('clangd')

vim.lsp.config['cmake'] = {
    cmd = {"cmake-language-server"},
    filetypes = {"cmake"}, 
    init_options = {
        buildDirectory = "build"
    },
    root_markers = { "CMakePresets.json", "CTestConfig.cmake", ".git", "build", "cmake" }
}
vim.lsp.enable('cmake')

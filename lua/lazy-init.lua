local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    -- Clone the plugin
    local cmd = {
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    }

    -- Run the command
    vim.fn.system(cmd)
    -- Check for errors
    -- vim.v.shell_error contains the exit code of the last shell command
    if vim.v.shell_error ~= 0 then
        vim.notify(
            "Failed to clone lazy.nvim. Git command failed with exit code: " .. vim.v.shell_error,
            vim.log.levels.ERROR
        )
        return
    end
end

-- Add the lazy.nvim to the runtime path
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
    { import = "plugins" },
    { import = "plugins.lsp" }
}, {
    checker = {
        enabled = true,
        notify = false,
    },
    change_detection = {
        notify = false,
    },
})

-- Enable line numbers and relative numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Remember last cursor position when reopening files
vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = "*",
    callback = function()
        vim.api.nvim_exec2('silent! normal! g`"zv',{output = false})
    end,
})

-- Enable system clipboard
vim.opt.clipboard = "unnamedplus"

-- Set leader key to space (useful for plugins)
vim.g.mapleader = " "

-- Use incremental search with highlight
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Enable mouse support
vim.opt.mouse = "a"

-- Function to prompt for opening a new file or restoring previous session
vim.api.nvim_create_autocmd("VimEnter", {
    pattern = "*",
    callback = function()
        -- Check if there's a session file
        local session_file = vim.fn.expand("~/.nvim_session")
        if vim.fn.filereadable(session_file) == 1 then
            -- Ask if user wants to restore session
            local choice = vim.fn.input("Restore previous session? (y/n): ")
            if choice == "y" then
                print("Resuming previous session")
                vim.cmd("silent! source " .. session_file)
            else
                print("Starting a new file.")
            end
        else
            print("No session file found. Starting a new file.")
        end
    end,
})

-- Save session on VimLeave (when quitting Neovim)
vim.api.nvim_create_autocmd("VimLeave", {
    pattern = "*",
    command = "mksession! ~/.nvim_session"
})

local dap = require('dap')
local dapui = require('dapui')

require('nvim-dap-virtual-text').setup()

dap.adapters.python = {
    type = 'executable',
    command = '/usr/bin/python',
    args = {'-m', 'debugpy.adapter'}
}
dap.configurations.python = {
    {
        type = 'python',
        request = 'launch',
        name = "Launch file",
        program = "${file}",
        pythonPath = function()
            local cwd = vim.fn.getcwd()
            if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
                return cwd .. '/venv/bin/python'
            else
                return '/usr/bin/python'
            end
        end
    }
}

dap.adapters.go = function(callback, config)
    local stdout = vim.loop.new_pipe(false)
    local handle
    local pid_or_err
    local port = 38697
    local opts = {
        stdio = {nil, stdout},
        args = {"dap", "-l", "127.0.0.1:" .. port},
        detached = true
    }
    handle, pid_or_err = vim.loop.spawn("dlv", opts, function(code)
        stdout:close()
        handle:close()
        if code ~= 0 then print('dlv exited with code', code) end
    end)
    assert(handle, 'Error running dlv: ' .. tostring(pid_or_err))
    stdout:read_start(function(err, chunk)
        assert(not err, err)
        if chunk then
            vim.schedule(function() require('dap.repl').append(chunk) end)
        end
    end)
    -- Wait for delve to start
    vim.defer_fn(function()
        callback({type = "server", host = "127.0.0.1", port = port})
    end, 100)
end
-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
dap.configurations.go = {
    {type = "go", name = "Debug", request = "launch", program = "${file}"}, {
        type = "go",
        name = "Debug test", -- configuration for debugging test files
        request = "launch",
        mode = "test",
        program = "${file}"
    }, -- works with go.mod packages and sub packages
    {
        type = "go",
        name = "Debug test (go.mod)",
        request = "launch",
        mode = "test",
        program = "./${relativeFileDirname}"
    }
}

dap.adapters.dart = {
    type = "executable",
    command = "node",
    args = {
        os.getenv("HOME") .. "/prog/custom-builds/Dart-Code/out/dist/debug.js",
        "flutter"
    }
}
dap.configurations.dart = {
    {
        type = "dart",
        request = "launch",
        name = "Launch flutter",
        dartSdkPath = "/opt/flutter/bin/cache/dart-sdk",
        flutterSdkPath = "/opt/flutter",
        program = "${workspaceFolder}/lib/main.dart",
        cwd = "${workspaceFolder}"
    }
}

dap.listeners.after.event_initialized['dapui_config'] =
    function() dapui.open() end
dap.listeners.before.event_terminated['dapui_config'] =
    function() dapui.close() end
dap.listeners.before.event_exited['dapui_config'] = function() dapui.close() end

dapui.setup()

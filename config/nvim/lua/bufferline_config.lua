vim.opt.termguicolors = true
require('bufferline').setup {
    options = {
        mode = "buffers",
        numbers = "none",
        close_command = nil,
        right_mouse_command = nil,
        left_mouse_command = nil,
        middle_mouse_command = nil,
        max_name_length = 18,
        max_prefix_length = 15,
        tab_size = 18,
        diagnostics = false,
        diagnostics_update_in_insert = false,
        diagnostics_indicator = nil,
        color_icons = true,
        show_buffer_icons = true,
        show_buffer_close_icons = false,
        show_buffer_default_icon = true,
        show_close_icon = false,
        show_tab_indicators = true,
        persist_buffer_sort = true,
        -- separator_style = "slant" | "thick" | "thin" | {'any', 'any'},
        -- enforce_regular_tabs = false | true,
        always_show_bufferline = true,
        sort_by = 'insert_at_end'
    }
}

local gl = require('galaxyline')
local colors = require('galaxyline.theme').default
local condition = require('galaxyline.condition')
local utils = require 'core.utils'
local cl = require 'modules.ui.colors'

local gls = gl.section
local u = utils.u

gl.short_line_list = {'NvimTree', 'vista', 'dbui', 'packer'}

local mode_map = {
    ['n'] = {'NORMAL', cl.normal},
    ['i'] = {'INSERT', cl.insert},
    ['R'] = {'REPLACE', cl.replace},
    ['v'] = {'VISUAL', cl.visual},
    ['V'] = {'V-LINE', cl.visual},
    ['c'] = {'COMMAND', cl.command},
    ['s'] = {'SELECT', cl.visual},
    ['S'] = {'S-LINE', cl.visual},
    ['t'] = {'TERMINAL', cl.terminal},
    [''] = {'V-BLOCK', cl.visual},
    [''] = {'S-BLOCK', cl.visual},
    ['Rv'] = {'VIRTUAL'},
    ['rm'] = {'--MORE'}
}

local function highlight(group, fg, bg, gui)
    local cmd = string.format('highlight %s guifg=%s guibg=%s', group, fg, bg)
    if gui ~= nil then
        cmd = cmd .. ' gui=' .. gui
    end
    vim.cmd(cmd)
end

local function mode_hl()
    return mode_map[vim.fn.mode()][2] or cl.none
end

local function mode_label()
    return mode_map[vim.fn.mode()][1] or 'N/A'
end

local function wide_enough()
    local squeeze_width = vim.fn.winwidth(0)
    if squeeze_width > 80 then
        return true
    end
    return false
end

local icons = {
    locker = u 'f023',
    unsaved = u 'f693',
    dos = u 'e70f',
    unix = u 'f17c',
    mac = u 'f179',
    lsp_warn = u 'f071',
    lsp_error = u 'f46e'
}

gls.left[1] = {
    RainbowRed = {
        provider = function()
            return '▊ '
        end,
        highlight = {colors.blue, colors.bg}
    }
}
gls.left[2] = {
    ViMode = {
        provider = function()
            local modehl = mode_hl()
            highlight('GalaxyViMode', cl.bg, modehl, 'bold')
            highlight('GalaxyViModeInv', modehl, cl.bg, 'bold')
            return string.format('  %s ', mode_label())
        end
    }
}
gls.left[3] = {
    FileSize = {
        provider = 'FileSize',
        condition = condition.buffer_not_empty,
        highlight = {colors.fg, colors.bg}
    }
}
gls.left[4] = {
    FileIcon = {
        provider = 'FileIcon',
        condition = condition.buffer_not_empty,
        highlight = {require('galaxyline.provider_fileinfo').get_file_icon_color, colors.bg}
    }
}

gls.left[5] = {
    FileName = {
        provider = function()
            local fname
            if wide_enough() then
                fname = vim.fn.fnamemodify(vim.fn.expand '%', ':~:.')
            else
                fname = vim.fn.expand '%:t'
            end
            if #fname == 0 then
                return ''
            end
            if vim.bo.readonly then
                fname = fname .. ' ' .. icons.locker
            end
            if vim.bo.modified then
                fname = fname .. ' ' .. icons.unsaved
            end
            return ' ' .. fname .. ' '
        end,
        condition = condition.buffer_not_empty,
        highlight = {colors.fg, colors.bg, 'bold'}
    }
}

gls.left[6] = {
    LineInfo = {
        provider = 'LineColumn',
        separator = ' ',
        separator_highlight = {'NONE', colors.bg},
        highlight = {colors.fg, colors.bg}
    }
}

gls.left[7] = {
    PerCent = {
        provider = 'LinePercent',
        separator = ' ',
        separator_highlight = {'NONE', colors.bg},
        highlight = {colors.fg, colors.bg, 'bold'}
    }
}

gls.left[8] = {
    DiagnosticError = {
        provider = 'DiagnosticError',
        icon = '  ',
        highlight = {colors.red, colors.bg}
    }
}
gls.left[9] = {
    DiagnosticWarn = {
        provider = 'DiagnosticWarn',
        icon = '  ',
        highlight = {colors.yellow, colors.bg}
    }
}

gls.left[10] = {
    DiagnosticHint = {
        provider = 'DiagnosticHint',
        icon = '  ',
        highlight = {colors.cyan, colors.bg}
    }
}

gls.left[11] = {
    DiagnosticInfo = {
        provider = 'DiagnosticInfo',
        icon = '  ',
        highlight = {colors.blue, colors.bg}
    }
}

gls.mid[1] = {
    ShowLspClient = {
        provider = 'GetLspClient',
        condition = function()
            local tbl = {
                ['dashboard'] = true,
                [''] = true
            }
            if tbl[vim.bo.filetype] then
                return false
            end
            return true
        end,
        icon = ' LSP:',
        highlight = {colors.yellow, colors.bg, 'bold'}
    }
}

gls.right[1] = {
    FileEncode = {
        provider = 'FileEncode',
        condition = condition.hide_in_width,
        separator = ' ',
        separator_highlight = {'NONE', colors.bg},
        highlight = {colors.green, colors.bg, 'bold'}
    }
}

gls.right[2] = {
    FileFormat = {
        provider = 'FileFormat',
        condition = condition.hide_in_width,
        separator = ' ',
        separator_highlight = {'NONE', colors.bg},
        highlight = {colors.green, colors.bg, 'bold'}
    }
}

gls.right[3] = {
    GitIcon = {
        provider = function()
            return '  '
        end,
        condition = condition.check_git_workspace,
        separator = ' ',
        separator_highlight = {'NONE', colors.bg},
        highlight = {colors.violet, colors.bg, 'bold'}
    }
}

gls.right[4] = {
    GitBranch = {
        provider = 'GitBranch',
        condition = condition.check_git_workspace,
        highlight = {colors.violet, colors.bg, 'bold'}
    }
}

gls.right[5] = {
    DiffAdd = {
        provider = 'DiffAdd',
        condition = condition.hide_in_width,
        icon = '  ',
        highlight = {colors.green, colors.bg}
    }
}
gls.right[6] = {
    DiffModified = {
        provider = 'DiffModified',
        condition = condition.hide_in_width,
        icon = ' ~ ',
        highlight = {colors.orange, colors.bg}
    }
}
gls.right[7] = {
    DiffRemove = {
        provider = 'DiffRemove',
        condition = condition.hide_in_width,
        icon = '  ',
        highlight = {colors.red, colors.bg}
    }
}

gls.right[8] = {
    RainbowBlue = {
        provider = function()
            return ' ▊'
        end,
        highlight = {colors.blue, colors.bg}
    }
}

gls.short_line_left[1] = {
    BufferType = {
        provider = 'FileTypeName',
        separator = ' ',
        separator_highlight = {'NONE', colors.bg},
        highlight = {colors.blue, colors.bg, 'bold'}
    }
}

gls.short_line_left[2] = {
    SFileName = {
        provider = 'SFileName',
        condition = condition.buffer_not_empty,
        highlight = {colors.fg, colors.bg, 'bold'}
    }
}

gls.short_line_right[1] = {
    BufferIcon = {
        provider = 'BufferIcon',
        highlight = {colors.fg, colors.bg}
    }
}


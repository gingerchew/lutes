local colors = require 'ansicolors'

local symbols = {
    error = 'x',
    error_start = '%{cyan}┌%{red}x',
    start = '%{cyan}┌',
    wall = '%{cyan}│',
    entry = '%{cyan}├»',
    entry_error = '%{cyan}├%{red}x',
    entry_final = '%{cyan}└»',
    entry_error_final = '%{cyan}└%{red}x',
    space = '',
}

function symbols:icon(key)
    return colors(self[key]..' ')
end

return symbols
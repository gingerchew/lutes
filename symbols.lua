local colors = require 'ansicolors'

local symbols = {
    error = 'x',
    error_start = '%{bright}%{cyan}┌%{red}x%{reset}',
    start = '%{bright}%{cyan}┌',
    wall = '%{bright}%{cyan}│',
    entry = '%{bright}%{cyan}├»',
    entry_error = '%{bright}%{cyan}├%{red}x%{reset}',
    entry_final = '%{bright}%{cyan}└»',
    entry_error_final = '%{bright}%{cyan}└%{red}x%{reset}',
    space = '',
}

function symbols:icon(key)
    return colors(self[key]..' ')
end

return symbols
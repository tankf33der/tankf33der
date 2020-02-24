local config = import("micro/config")
local shell = import("micro/shell")

function runme(bp)
    local buf = bp.Buf -- The current buffer
    buf:Save()
    if buf:FileType() == "python" then
        shell.RunInteractiveShell("python3 " .. buf.Path, true, false)
    elseif buf:FileType() == "myrddin" then
        shell.RunInteractiveShell("mbld -R " .. buf.Path, true, false)
    elseif buf:FileType() == "picolisp" then
        shell.RunInteractiveShell("pil " .. buf.Path .. " +", true, false)
    elseif buf:FileType() == "verifpal" then
        shell.RunInteractiveShell("verifpal verify " .. buf.Path, true, false)
    elseif buf:FileType() == "ruby" then
        shell.RunInteractiveShell("ruby " .. buf.Path, true, false)
    elseif buf:FileType() == "vlang" then
        shell.RunInteractiveShell("v run " .. buf.Path, true, false)
    end

end
function ixio(bp)
    local buf = bp.Buf
    buf:Save()
    shell.RunInteractiveShell("curl -F 'f:1=@" .. buf.Path .. "' ix.io", true, false)
end

function init()
    config.TryBindKey("CtrlR", "lua:initlua.runme", true)
    config.TryBindKey("Alt-l", "lua:initlua.ixio", true)
end


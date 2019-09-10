function runme()
    local buf = CurView().Buf -- The current buffer
	buf:Save()
    if buf:FileType() == "picolisp" then
    	HandleShellCommand("pil " .. buf.Path .. " +", true, true)
    end
    if buf:FileType() == "verifpal" then
		HandleShellCommand("verifpal verify .. " buf.Path, true, true)
    end
end
function ixio()
	local buf = CurView().Buf
	buf:Save()
	HandleShellCommand("curl -F 'f:1=@" .. buf.Path .. "' ix.io", true, true)
	end
BindKey("AltL", "init.ixio") -- AltShift+L
BindKey("CtrlR", "init.runme")

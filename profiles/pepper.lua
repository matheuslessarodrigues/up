mapn("qq", ":quit()<c-m>")
mapn("<c-s>", ":save()<c-m>")
maps("c", "di")

function fzf_conhost()
	local client_arg = "--as-client " .. client_index()
	local command = [["fzf | xargs -rI FILE pepper ]] .. client_arg .. [[ \"FILE\"]]
	spawn("conhost", {"sh", "-c", command})
end
function fzf_windows_terminal()
	pipe("sh", {"-c", "pwd > ~/pepperdir"})
	command = [[Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait("^+%p")]]
	spawn("powershell", {"-noprofile", "-nologo", "-noninteractive", "-command", command})
end
function fzf()
	fzf_conhost()
end
mapn("<c-p>", ":fzf()<c-m>")

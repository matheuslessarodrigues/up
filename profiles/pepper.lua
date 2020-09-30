keymap.normal("qq", ":quit()<enter>")
keymap.normal("<c-s>", ":save()<enter>")

function fzf_conhost()
	local client_arg = "--as-client " .. client.index()
	local command = [[fzf | xargs -rI FILE pepper ]] .. client_arg .. [[ FILE]]
	process.spawn("conhost", {"sh", "-c", command})
end
function fzf_windows_terminal()
	command = [[Add-Type -AssemblyName System.Windows.Forms; "$pwd" | out-file -encoding ASCII "$home/pepperdir"; [System.Windows.Forms.SendKeys]::SendWait("^+%p")]]
	process.spawn("powershell", {"-noprofile", "-nologo", "-noninteractive", "-command", command})
end
function fzf()
	--fzf_conhost()
	fzf_windows_terminal()
end
keymap.normal("<c-o>", ":fzf()<enter>")

-- c#
local keywords = {"abstract", "as", "base", "break", "case", "catch", "checked", "class", "const", "continue", "default", "delegate", "do", "else", "enum", "event", "explicit", "extern", "finally", "fixed", "for", "foreach", "goto", "if", "implicit", "in", "interface", "internal", "is", "lock", "namespace", "new", "operator", "out", "override", "params", "private", "protected", "public", "readonly", "ref", "return", "sealed", "sizeof", "stackalloc", "static", "struct", "switch", "throw", "try", "typeof", "unchecked", "unsafe", "using", "virtual", "volatile", "while", "add", "alias", "ascending", "async", "await", "by", "descending", "dynamic", "equals", "from", "get", "global", "group", "into", "join", "let", "nameof", "notnull", "on", "orderby", "partial", "remove", "select", "set", "unmanaged", "value", "var", "when", "where", "yield"}
for i,k in ipairs(keywords) do
	syntax.rule("cs", "keyword", k)
end

local symbols = {"%(", "%)", "%[", "%]", "%{", "%}", ":", ";", ",", "=", "<", ">", "+", "-", "/", "*", "%%", "%.", "%!", "?", "&", "|", "@"}
for i,k in ipairs(symbols) do
	syntax.rule("cs", "symbol", k)
end

local types = {"bool", "byte", "char", "decimal", "double", "float", "int", "long", "object", "sbyte", "short", "string", "uint", "ulong", "ushort", "void"}
for i,k in ipairs(types) do
	syntax.rule("cs", "type", k)
end
syntax.rule("cs", "type", "%u{%w}");

syntax.rule("cs", "comment", "//{.}");
syntax.rule("cs", "comment", "/*{!(*/).$}");

for i,k in ipairs({"null", "this", "true", "false"}) do
	syntax.rule("cs", "literal", k);
end

syntax.rule("literal", "%d{%w%._}");
syntax.rule("string", "'{(\\')!'.}");
syntax.rule("string", "\"{(\\\")!\".}");

syntax.rule("cs", "text", "%a{%w_}")
syntax.rule("cs", "text", "_{%w_}")

-- javascript
local keywords = {"break", "export", "super", "case", "extends", "switch", "catch", "finally", "class", "for", "throw", "const", "function", "try", "continue", "if", "typeof", "debugger", "import", "var", "default", "in", "void", "delete", "instanceof", "while", "do", "new", "with", "else", "return", "yield", "enum", "implements", "package", "public", "interface", "private", "static", "let", "protected", "yield", "await", "abstract", "float", "synchronized", "boolean", "goto", "throws", "byte", "int", "transient", "char", "long", "volatile", "double", "native", "final", "short", "arguments", "get", "set"}
for i,k in ipairs(keywords) do
	syntax.rule("js", "keyword", k)
end

local symbols = {"%(", "%)", "%[", "%]", "%{", "%}", ":", ";", ",", "=", "<", ">", "+", "-", "/", "*", "%%", "%.", "%!", "?", "&", "|", "@"}
for i,k in ipairs(symbols) do
	syntax.rule("js", "symbol", k)
end

syntax.rule("js", "type", "%u{%w}");

syntax.rule("js", "comment", "//{.}");
syntax.rule("js", "comment", "/*{!(*/).$}");

for i,k in ipairs({"null", "undefined",  "true", "false"}) do
	syntax.rule("js", "literal", k);
end

syntax.rule("js", "literal", "%d{%w%._}");
syntax.rule("js", "string", "'{(\\')!'.}");
syntax.rule("js", "string", "\"{(\\\")!\".}");

syntax.rule("js", "text", "%a{%w_}")
syntax.rule("js", "text", "_{%w_}")

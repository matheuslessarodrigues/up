@echo off

set HOME=%HOMEDRIVE%%HOMEPATH%
set FZF_DEFAULT_COMMAND=fd -tf --path-separator / .

prompt $E[30;43m$P$E[00m$S$E]9;9;$P$E\

doskey /exename=cmd.exe clip=copycat $*
doskey /exename=cmd.exe fd=fd --path-separator / $*
doskey /exename=cmd.exe rg=rg --no-ignore-global --path-separator / $*
doskey /exename=cmd.exe pp=pepper --config "%HOME%/pepper-config/config.ini" --try-config project.ini $*

doskey /exename=cmd.exe ls=dir $*
doskey /exename=cmd.exe rm=del $*
doskey /exename=cmd.exe mv=move $*
doskey /exename=cmd.exe cp=copy $*
doskey /exename=cmd.exe cat=type $*
doskey /exename=cmd.exe which=where $*
doskey /exename=cmd.exe ps=tasklist $*
doskey /exename=cmd.exe kill=taskkill $*

@echo off

prompt $E[30;43m$P$E[00m$E]9;9;$P$E\$S

doskey /exename=cmd.exe clip=copycat $*
doskey /exename=cmd.exe fd=fd --path-separator / $*
doskey /exename=cmd.exe rg=rf --no-ignore-global --path-separator / $*
doskey /exename=cmd.exe pp=pepper --config "%HOMEDRIVE%%HOMEPATH%/pepper-config/init.pp" --try-config project.pp $*
doskey /exename=cmd.exe ls=ls -AphX --color=auto $*

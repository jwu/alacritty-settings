;= @echo off
;= rem Call DOSKEY and use this file as the macrofile
;= %SystemRoot%\system32\doskey /listsize=1000 /macrofile=%0%
;= rem In batch mode, jump to the end of the file
;= goto:eof
;============ Add aliases below here ============
e.=explorer .
ls=ls --show-control-chars -F --color $*
pwd=cd
clear=cls
vi=vim $*
gl=git log --oneline --all --graph --decorate  $*
lsd=lsd --config-file %AL_SETTINGS%\lsd.yaml $*

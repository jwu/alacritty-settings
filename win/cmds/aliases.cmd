;= @echo off
;= rem ls=ls --show-control-chars -F --color $*
;= rem Call DOSKEY and use this file as the macrofile
;= %SystemRoot%\system32\doskey /listsize=1000 /macrofile=%0%
;= rem In batch mode, jump to the end of the file
;= goto:eof
;============ Add aliases below here ============
e.=explorer .
clear=cls
vi=nvim $*
gl=git log --oneline --all --graph --decorate  $*
ls=lsd --icon never $*
l=lsd -l --icon never $*
la=lsd -a --icon never $*
lla=lsd -la --icon never $*
lt=lsd --tree --icon never $*
mv=coreutils mv $*
rm=coreutils rm $*
cp=coreutils cp $*
pwd=coreutils pwd

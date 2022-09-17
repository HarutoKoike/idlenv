args = COMMAND_LINE_ARGS(COUNT=count)
vdir = args[0]

;
;*---------- make directory  ----------*
;
IF SIZE(vdir, /TYPE) EQ 7 THEN $
  FILE_MKDIR, vdir

IF ~SIZE(vdir, /TYPE) EQ 7 THEN $
  PRINT, 'Argument must be STRING'


;
;*---------- configuration file  ----------*
;
CD, CURRENT=cdir
config  = FILEPATH('.config', ROOT=cdir, SUBDIR=vdir)
version = !VERSION.RELEASE
;
OPENW, 1, config
PRINTF, 1, 'version = ' + version
CLOSE, 1


; create directory for virtual environment and
; copy the activate file
;

PRO idlenv, vdir
;
;*---------- make directory  ----------*
;
IF SIZE(vdir, /TYPE) EQ 7 THEN $
  FILE_MKDIR, vdir

IF SIZE(vdir, /TYPE) NE 7 THEN BEGIN
  PRINT, '% Argument must be STRING'
  RETURN
ENDIF


;
;*---------- configuration file  ----------*
;
CD, CURRENT=cdir
config  = FILEPATH('idlenv.cfg', ROOT=cdir, SUBDIR=vdir)
version = !VERSION.RELEASE
;
OPENW, 1, config
PRINTF, 1, 'version = ' + version
CLOSE, 1


;
;*---------- copy .activate file  ----------*
;
dest   = FILEPATH('', ROOT=cdir, SUBDIR=vdir)
source = FILEPATH('.activate', ROOT=!PACKAGE_PATH, SUBDIR='idlenv')
FILE_COPY, source, dest

END
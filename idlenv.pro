;===========================================================+
; ++ NAME ++
PRO idlenv, vdir
;
; ++ PURPOSE ++
;  --> create directory for virtual environment and
;  --> copy the activate file
;
; ++ POSITIONAL ARGUMENTS ++
;  --> vdir(STRING): directory name 
;
; ++ KEYWORDS ++
; -->
;
; ++ CALLING SEQUENCE ++
;  --> idlenv, 'venv' (IDL command line)
;  --> idl -e 'idlenv, "directory name"' 
;
; ++ AUTHOR ++
;  H.Koike 09/17, 2022
;
;===========================================================+
;
;
;*---------- make directory  ----------*
;
IF SIZE(vdir, /TYPE) EQ 7 THEN $
  FILE_MKDIR, vdir

IF SIZE(vdir, /TYPE) NE 7 THEN BEGIN
  MESSAGE, '% Argument must be STRING'
ENDIF


;
;*---------- copy activate file  ----------*
;
CD, CURRENT=cdir
dest   = FILEPATH('', ROOT=cdir, SUBDIR=vdir)
source = FILEPATH('bin', ROOT=selfpath(/path))
FILE_COPY, source, dest, /RECURSIVE 


;
;*---------- configuration file  ----------*
;
config  = FILEPATH('.idlenvcfg', ROOT=cdir, SUBDIR=vdir)
version = !VERSION.RELEASE
; 
self_dir = FILE_DIRNAME(ROUTINE_FILEPATH())
;
OPENW, lun, config, /GET_LUN
PRINTF, lun, self_dir
PRINTF, lun, 'version = ' + version
FREE_LUN, lun

END

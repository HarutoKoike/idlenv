;===========================================================+
; ++ NAME ++
PRO exclude_path, epath, recursive=recursive, absolute=absolute
;
; ++ PURPOSE ++
;  --> exclude a specified directory from IDL PATH
;
; ++ POSITIONAL ARGUMENTS ++
;  --> epath : 1-element string of relative path to be excluded
;
; ++ KEYWORDS ++
; -->  recursive : set this keyword to exclude recursively
; ->>  absolute  : set this keyword if argument is absolute path
;
; ++ CALLING SEQUENCE ++
;  --> exclude_path, 'dir1', /recursive
;
; ++ HISTORY ++
;  2023/02/20
;===========================================================+


path = STRSPLIT(!PATH, ':', /EXTRACT)
CD, CURRENT=current
;
IF N_ELEMENTS(epath) GT 1 THEN $
    MESSAGE, 'argument must be 1-element'
IF SIZE(epath, /TYPE) NE 7 THEN $
    MESSAGE, 'argument must be string'


;
ep = EXPAND_PATH(epath)
IF ~KEYWORD_SET(absolute) THEN ep = FILEPATH(ep, ROOT=current)
IF KEYWORD_SET(recursive) THEN ep = '+' + ep
;
ep = STRSPLIT(ep, ':', /EXTRACT)
;


FOR i = 0, N_ELEMENTS(ep) - 1 DO $
    path[WHERE(STRMATCH(path, ep[i]), /NULL)] = ''


!PATH = STRJOIN(path, ':')
END

;===========================================================+
; ++ NAME ++
PRO import, path, recursive=recursive
;
; ++ PURPOSE ++
;  --> add new library path to !PATH system variable
;
; ++ POSITIONAL ARGUMENTS ++
;  --> path(STRING): absolute path to library
;
; ++ KEYWORDS ++
; -->  recursive(BOOLEAN): set this keyword to include sub-directy recursively
;
; ++ CALLING SEQUENCE ++
;  --> import, '~/mylib', /recursive
;
; ++ HISTORY ++
;   09/2022, H.Koike
;===========================================================+
;
COMPILE_OPT IDL2

;
path_full = path

IF ~FILE_TEST(path) THEN $
  MESSAGE, 'Directory "' + path + '" not found.'

; recursive include
IF KEYWORD_SET(recursive) THEN BEGIN
  path_full = '+' + path_full
  path_full = EXPAND_PATH(path_full)
ENDIF


;
;*---------- add new path  ----------*
;
!PATH = !PATH + ':' + path_full
RETURN

END

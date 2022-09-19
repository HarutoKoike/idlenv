;===========================================================+
; ++ NAME ++
;  --> test.pro
;
; ++ PURPOSE ++
;  -->
;
; ++ POSITIONAL ARGUMENTS ++
;  -->
;
; ++ KEYWORDS ++
; -->
;
; ++ CALLING SEQUENCE ++
;  -->
;
; ++ HISTORY ++
;  H.Koike 1/9,2021
;===========================================================+

PRO freeze


dir      = FILEPATH('*', ROOT=!PACKAGE_PATH)
packages = FILE_SEARCH(dir)

requirements = FILEPATH('.requirements', ROOT=FILE_DIRNAME(!PACKAGE_PATH))

OPENW, lun, requirements, /GET_LUN
FOREACH pkg, packages DO BEGIN
  fn   = FILEPATH('idlpackage.json', ROOT=pkg)
  json = JSON_PARSE(fn, /DICT)
  ;

ENDFOREACH
FREE_LUN, lun

END

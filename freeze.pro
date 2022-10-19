;===========================================================+
; ++ NAME ++
PRO freeze
;
; ++ PURPOSE ++
;  --> write package list into 'requirements.csv' 
;  --> output file will be placed on !PACKAGE_PATH 
;
; ++ POSITIONAL ARGUMENTS ++
;  -->
;
; ++ KEYWORDS ++
; -->
;
; ++ CALLING SEQUENCE ++
;  --> freeze
;
; ++ HISTORY ++
;  H.Koike 9/17,2022
;===========================================================+


; list up package directory
dir      = FILEPATH('*', ROOT=!PACKAGE_PATH)
packages = FILE_SEARCH(dir)


; package info
names    = []
url      = []
versions = []


; read json file
FOREACH pkg, packages DO BEGIN

  fn   = FILEPATH('idlpackage.json', ROOT=pkg)
  json = JSON_PARSE(fn, /DICT)
  ;
  dum = WHERE( STRMATCH(json.Keys(), 'Name', /FOLD_CASE), name_exists)
  dum = WHERE( STRMATCH(json.Keys(), 'URL', /FOLD_CASE), url_exists)
  dum = WHERE( STRMATCH(json.Keys(), 'Version', /FOLD_CASE), version_exists)
  
  IF ~name_exists THEN CONTINUE
  names = [names, json.name]

  IF url_exists THEN BEGIN
      url = [url, json.url]
  ENDIF ELSE BEGIN
      url = [url, ''] 
  ENDELSE
  ;
  IF version_exists THEN BEGIN 
      versions = [versions, json.version]
  ENDIF ELSE BEGIN
      versions = [versions, '']
  ENDELSE

ENDFOREACH


; write csv 
;
requirements = FILEPATH('requirements.csv', ROOT=FILE_DIRNAME(!PACKAGE_PATH))
;
header = ['Name', 'URL', 'Version'] 
WRITE_CSV, requirements, names, url, versions, HEADER=header

END

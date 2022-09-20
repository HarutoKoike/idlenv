;===========================================================+
; ++ NAME ++
PRO install_pkg, requirements
;
; ++ PURPOSE ++
;  --> install packages  
;
; ++ POSITIONAL ARGUMENTS ++
;  --> requirements : file name of package list (.csv) 
;
; ++ KEYWORDS ++
; -->
;
; ++ CALLING SEQUENCE ++
;  --> install_pkg, 'requirements.csv'
;
; ++ HISTORY ++
;  H.Koike 9/20, 2022
;===========================================================+

IF ~ISA(requirements) THEN $
    requirements = DIALOG_PICKFILE(FILTER='*.csv')

is_csv = STRMATCH(requirements, '*.csv')
IF ~ISA(requirements, 'STRING') OR ~is_csv THEN BEGIN
    PRINT, '% Argument must be STRING of requirements file(.csv)'
    RETURN
ENDIF
;
;
IF ~FILE_TEST(requirements) THEN BEGIN
    PRINT, '% ' + requirements + ' does not exist.'
    RETURN
ENDIF


pkglist = READ_CSV(requirements, COUNT=count)

names   = pkglist.FIELD1
url     = pkglist.FIELD2
version = pkglist.FIELD3

FOR i = 1, count - 1 DO BEGIN   ; line=0 : header
    IF STRLEN(url[i]) EQ 0 THEN CONTINUE 
    IPM, /INSTALL, url[i], VERSION=version[i]
ENDFOR


END


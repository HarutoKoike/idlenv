;===========================================================+
; ++ NAME ++
FUNCTION selfpath, path=path, filename=filename
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
;  H.Koike
;===========================================================+
;
HELP, /LEVEL, OUT=out
;
str   = ''
dummy = 'taiofajrwaevaewrjagarjfvsearrjajlcaawe'
;
for i = 0, n_elements(out) - 1 do begin
    initial = strmid(out[i], 0, 1)
    if initial ne '%' then $
        str += out[i]
    if initial eq '%' then $
        str += dummy + out[i]
endfor
;
str  = strcompress(str, /remove_all)
str  = strsplit(str, dummy + '%', /extract, /regex)

match = 'AtSELFPATH*selfpath.pro'
idx   = where( strmatch(str, match), count) + 1

info = str[idx]

;
;*----------   ----------*
;
info = strsplit(info, path_sep(), /extract)
root = path_sep() + info[1]
sub  = info[2:-2]
fn   = info[-1]
;
if keyword_set(path) then $
    return, filepath('', root=root, sub=sub)
if keyword_set(filename) then $
    return, fn

return, filepath(fn, root=root, sub=sub)
end

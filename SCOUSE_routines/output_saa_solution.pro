;+
;
; PROGRAM NAME:
;   OUTPUT SAA SOLUTION
;
; PURPOSE:  
;   Output the best-fitting solution to the current SAA
;   
;------------------------------------------------------------------------------;
; REVISION HISTORY:
;   Written by Jonathan D. Henshaw, 2015
;
;-

PRO OUTPUT_SAA_SOLUTION, SolnArr, OutFile, dir=dir, indx=indx, x=x, y=y, PRINT_RESID=PR, SAVE_FIG=SF
Compile_Opt idl2

;------------------------------------------------------------------------------;
; OUTPUT SOLUTIONS
;------------------------------------------------------------------------------;

; Write to output file

OPENW,1, OutFile, width = 200, /append
FOR i = 0, N_ELEMENTS(SolnArr[*,0])-1 DO BEGIN
    PRINTF,1, SolnArr[i,0],$
              SolnArr[i,1],SolnArr[i,2],$
              SolnArr[i,3],SolnArr[i,4],$
              SolnArr[i,5],SolnArr[i,6],$
              SolnArr[i,7],SolnArr[i,8],$
              SolnArr[i,9],SolnArr[i,10],$
              SolnArr[i,11],SolnArr[i,12],SolnArr[i,13],SolnArr[i,14],$
              SolnArr[i,15],SolnArr[i,16],$
              format = '((F10.2, x), 2(F12.5, x), 14(F10.3, x))'
ENDFOR
CLOSE,1

;------------------------------------------------------------------------------;

If (KEYWORD_SET(PR) && (N_ELEMENTS(dir) NE 0) && (N_ELEMENTS(indx) NE 0) && (N_ELEMENTS(x) NE 0) && (N_ELEMENTS(y) NE 0)) THEN BEGIN
  OPENW, 1, dir+'residual_'+STRING(indx, format = '(I03)')+'.dat'
  FOR i = 0, N_ELEMENTS(x)-1 DO BEGIN
    PRINTF, 1, x[i], y[i]
  ENDFOR
  CLOSE,1 
ENDIF

If (KEYWORD_SET(SF) && (N_ELEMENTS(dir) NE 0) && (N_ELEMENTS(indx) NE 0)) THEN BEGIN
  screenDump = cgSnapShot(FILENAME=dir+'best_fit_spec_'+STRING(indx, format = '(I03)')+'.png')
ENDIF

END

; OPTIONAL ADDITIONAL CODE

;------------------------------------------------------------------------------;
; PRINT RESIDUALS
;------------------------------------------------------------------------------;

;OPENW,1, datadirectory+filename+'/STAGE_2/SAA_residuals/residual_'+string(indx, format = '(I03)')+'.dat'
;FOR j = 0, N_ELEMENTS(ResArr)-1 DO BEGIN
;  PRINTF, 1, x[j], ResArr[j]
;ENDFOR
;CLOSE,1

;-----------------------------------------------------------------------------;


;-----------------------------------------------------------------------------;
; CREATE FIGURES
;-----------------------------------------------------------------------------;

;printing = 'no'
;
;PRINT, ''
;READ, printing, PROMPT = 'Would you like to create a hard copy of this fit (yes/no)? '
;
;IF printing EQ 'yes' THEN screenDump = cgSnapshot(filename=datadirectory+filename+'/FIGURES/best_fit_spec_'+string(indx, format = '(I03)'), /jpeg)
;

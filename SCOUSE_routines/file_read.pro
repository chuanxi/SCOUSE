FUNCTION FILE_READ, datadirectory, fitsfile, x_axis=x_axis, y_axis=y_axis, $
                    z_axis=z_axis, HDR_DATA = HDR_DATA
;------------------------------------------------------------------------------;
; Copyright (c) 2015 Jonathan D. Henshaw
; CONTACT: j.d.henshaw@ljmu.ac.uk
;
; PROGRAM NAME:
;   FILE READ
;   
; PURPOSE:
;   This program is used to read a FITS file and create the axes
;------------------------------------------------------------------------------;
; REVISION HISTORY:
;   Written by Jonathan D. Henshaw, 2015
;   
;------------------------------------------------------------------------------;
Compile_Opt idl2
;------------------------------------------------------------------------------;
; READ FITS
;------------------------------------------------------------------------------;

image = MRDFITS(datadirectory+fitsfile, 0, HDR_DATA)

; Generic properties

naxis     = SXPAR(HDR_DATA,'NAXIS') ; Number of axes 
beam_maj  = SXPAR(HDR_DATA,'BMAJ') ; Beam size major axis
beam_min  = SXPAR(HDR_DATA,'BMIN') ; Beam size minor axis
beam_pa   = SXPAR(HDR_DATA,'BPA') ; Beam position angle
bunit = sxpar(HDR_DATA,'BUNIT') ; Units for data
restfreq = sxpar(HDR_DATA,'RESTFREQ') ; Rest frequency in Hz

if naxis eq 2.0 then begin ; Continuum data
  
  naxis1 = SXPAR(HDR_DATA,'NAXIS1') ; Number of x-axis pixels
  crpix1 = SXPAR(HDR_DATA,'CRPIX1') ; Reference x-axis pixel
  cdelt1 = SXPAR(HDR_DATA,'CDELT1') ; Step size in x-axis 
  crval1 = SXPAR(HDR_DATA,'CRVAL1') ; Coord value for x-axis reference pixel 
  ctype1 = SXPAR(HDR_DATA,'CTYPE1') ; Co-ordinate system for x-axis
  naxis2 = SXPAR(HDR_DATA,'NAXIS2') ; Number of y-axis pixels
  crpix2 = SXPAR(HDR_DATA,'CRPIX2') ; Reference y-axis pixel
  cdelt2 = SXPAR(HDR_DATA,'CDELT2') ; Step size in y-axis
  crval2 = SXPAR(HDR_DATA,'CRVAL2') ; Coord value for y-axis reference pixel
  ctype2 = SXPAR(HDR_DATA,'CTYPE2') ; Co-ordinate system for y-axis
  
  x_axis = (cdelt1*(findgen(naxis1)+1-crpix1))+crval1 ; Create the axes
  y_axis = (cdelt2*(findgen(naxis2)+1-crpix2))+crval2
  z_axis = -1
  
endif else begin ; Spectral line data

  naxis1 = SXPAR(HDR_DATA,'NAXIS1') 
  crpix1 = sxpar(HDR_DATA,'CRPIX1') 
  cdelt1 = sxpar(HDR_DATA,'CDELT1')
  crval1 = sxpar(HDR_DATA,'CRVAL1') 
  ctype1 = sxpar(HDR_DATA,'CTYPE1') 
  naxis2 = sxpar(HDR_DATA,'NAXIS2') 
  crpix2 = sxpar(HDR_DATA,'CRPIX2') 
  cdelt2 = sxpar(HDR_DATA,'CDELT2') 
  crval2 = sxpar(HDR_DATA,'CRVAL2') 
  ctype2 = sxpar(HDR_DATA,'CTYPE2') 
  naxis3 = sxpar(HDR_DATA,'NAXIS3') ; Number of velocity axis pixels
  crpix3 = sxpar(HDR_DATA,'CRPIX3') ; Reference velocity axis pixel
  cdelt3 = sxpar(HDR_DATA,'CDELT3') ; Step size in velocity axis 
  crval3 = sxpar(HDR_DATA,'CRVAL3') ; Value for velocity axis reference pixel 
  ctype3 = sxpar(HDR_DATA,'CTYPE3') ; Co-ordinate system for z-axis 

  x_axis = (cdelt1*(findgen(naxis1)+1-crpix1))+crval1 ; Create the axes
  y_axis = (cdelt2*(findgen(naxis2)+1-crpix2))+crval2
  z_axis = (cdelt3*(findgen(naxis3)+1-crpix3))+crval3
endelse

;------------------------------------------------------------------------------;
; END PROCESS
;------------------------------------------------------------------------------;
return, image

END



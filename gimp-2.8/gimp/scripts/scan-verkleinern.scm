(define (skript-fu-scan-verkleinern filename seitenlaenge farbanzahl)

;neues bild erzeugen
(let* ((outfile (string-append(car (strbreakup filename "."))".png"))

      (image (car (gimp-file-load RUN-NONINTERACTIVE filename filename)))
      (drawable (car (gimp-image-get-active-layer image)))
      (cur-width  (car (gimp-image-width image)))
      (cur-height (car (gimp-image-height image)))
      (ratio      (min (/ seitenlaenge cur-width) (/ seitenlaenge cur-height)))
      (width      (* ratio cur-width))
      (height     (* ratio cur-height))
)
;die folgenden schritte werden für alle skripts gemacht

(gimp-levels drawable HISTOGRAM-VALUE 70 200 1 0 255)
(plug-in-sharpen RUN-NONINTERACTIVE
                                   image drawable 40)
(gimp-image-scale-full image width height INTERPOLATION-LANCZOS)

(gimp-image-convert-indexed image FSLOWBLEED-DITHER MAKE-PALETTE farbanzahl FALSE TRUE "")

(file-png-save RUN-NONINTERACTIVE
                             image drawable outfile outfile 0 9 0 0 0 0 0)
))

;skript registrieren
(script-fu-register
"skript-fu-scan-verkleinern"
"<Toolbox>/Xtns/Script-Fu/Logos (PH)/Hallo..."
"Verkleinert und verbessert Scans"
"Markus Bader"
"Markus Bader"
"25.12.2015"
""
SF-IMAGE "image" 0
SF-VALUE "Image Size" "1980"
)

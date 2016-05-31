(define (bild-verkleinern pattern seitenlaenge)
  (let* ((filelist (cadr (file-glob pattern 1))))
    (while (not (null? filelist))
      (let* (  (filename (car filelist))
               (outfile (string-append filename ".png"))
		       (image (car (gimp-file-load RUN-NONINTERACTIVE filename filename)))
               (drawable (car (gimp-image-get-active-layer image)))

               (cur-width  (car (gimp-image-width image)))
               (cur-height (car (gimp-image-height image)))
               (ratio      (min (/ seitenlaenge cur-width) (/ seitenlaenge cur-height)))
               (width      (* ratio cur-width))
               (height     (* ratio cur-height))
            )

	        (plug-in-sharpen RUN-NONINTERACTIVE image drawable 25)

            (gimp-image-scale-full image width height INTERPOLATION-LANCZOS)

            (plug-in-sharpen RUN-NONINTERACTIVE image drawable 20)

            (file-jpeg-save RUN-NONINTERACTIVE image drawable filename filename 1 0 1 0 "" 2 0 0 2)

      )

            (set! filelist (cdr filelist))
    )
  )
)
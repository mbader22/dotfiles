  (define (batch-surface-sharpen-facebook2 pattern)
  (let* ((filelist (cadr (file-glob pattern 1))))
    (while (not (null? filelist))
           (let* (	(filename (car filelist))
(outfile (string-append filename ".png"))
		        (image (car (gimp-file-load RUN-NONINTERACTIVE
		                                      filename filename)))
		        (drawable (car (gimp-image-get-active-layer image)))
			(wval (car (gimp-image-width image)))
			(hval (car (gimp-image-height image)))
	   	 )
	   (plug-in-sharpen RUN-NONINTERACTIVE
                                   image drawable 25)

  (if (> wval hval)            ; check if verti
            (gimp-image-scale-full image 2048 673 INTERPOLATION-LANCZOS)
       )
   (if (< wval hval)            ; check if hori
            (gimp-image-scale-full image 673 2048 INTERPOLATION-LANCZOS)
       )
	   (plug-in-sharpen RUN-NONINTERACTIVE
                                   image drawable 20)
             (file-jpeg-save RUN-NONINTERACTIVE
                             image drawable filename filename 1 0 1 0 "" 2 0 0 2)
             (gimp-image-delete image))
           (set! filelist (cdr filelist)))))
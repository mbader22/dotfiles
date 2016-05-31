  (define (batch-surface-wavelet-sharpen pattern)
  (let* ((filelist (cadr (file-glob pattern 1))))
    (while (not (null? filelist))
           (let* (	(filename (car filelist))
		        (image (car (gimp-file-load RUN-NONINTERACTIVE
		                                      filename filename)))
		        (drawable (car (gimp-image-get-active-layer image)))
			(wval (car (gimp-image-width image)))
			(hval (car (gimp-image-height image)))
	   	 )
	   (plug-in-wavelet-sharpen RUN-NONINTERACTIVE
                                   image drawable 0.8 0.3 1)

  (if (> wval hval)            ; check if verti
            (gimp-image-scale-full image 1024 768 INTERPOLATION-LANCZOS)
       )
   (if (< wval hval)            ; check if hori
            (gimp-image-scale-full image 768 1024 INTERPOLATION-LANCZOS)
       )
             (file-jpeg-save RUN-NONINTERACTIVE
                             image drawable filename filename 1 0 1 0 "" 2 0 0 2)
             (gimp-image-delete image))
           (set! filelist (cdr filelist)))))
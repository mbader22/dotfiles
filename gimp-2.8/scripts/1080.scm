  (define (batch-1080-sharpen pattern foldername)
  (let* ((filelist (cadr (file-glob pattern 1))))
    (while (not (null? filelist))
           (let* (	(filename (car filelist))
		        (image (car (gimp-file-load RUN-NONINTERACTIVE
		                                      filename filename)))
		        (drawable (car (gimp-image-get-active-layer image)))
			(wval (car (gimp-image-width image)))
			(hval (car (gimp-image-height image)))
	   	 )
	   (plug-in-sharpen RUN-NONINTERACTIVE
                                   image drawable 25)

  (if (> wval hval)            ; check if verti
            (gimp-image-scale-full image 1920 1080 INTERPOLATION-LANCZOS)
       )
   (if (< wval hval)            ; check if hori
            (gimp-image-scale-full image 1080 1920 INTERPOLATION-LANCZOS)
       )
	   (plug-in-sharpen RUN-NONINTERACTIVE
                                   image drawable 10)
(file-jpeg-save RUN-NONINTERACTIVE
                             image drawable (string-append foldername filename) (string-append foldername filename) 1 0 1 0 "" 2 0 0 2)
           )
           (set! filelist (cdr filelist)))))

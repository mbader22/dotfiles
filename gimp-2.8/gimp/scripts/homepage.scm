  (define (batch-homepage-sharpen pattern maxwidth maxheight widthm heightm widths heigts)
  (let* ( (filelistl (cadr (file-glob pattern 1)))
          (filelistm (cadr (file-glob pattern 1)))
          (filelists (cadr (file-glob pattern 1)))
  )
  
    (while (not (null? filelistl))
           (let* (	(filename (car filelistl))
		        (image (car (gimp-file-load RUN-NONINTERACTIVE
		                                      filename filename)))
		        (drawable (car (gimp-image-get-active-layer image)))
			(wval (car (gimp-image-width image)))
			(hval (car (gimp-image-height image)))
			(newfilename (string-append "phoca_thumb_l_" filename))
	   	 )
	   (plug-in-sharpen RUN-NONINTERACTIVE
                                   image drawable 25)
(if (< (/ wval hval) (/ maxwidth maxheight))
  
    (begin
      (gimp-image-scale-full image (* maxheight (/ wval hval)) maxheight INTERPOLATION-LANCZOS)
    )
    (gimp-image-scale-full image maxwidth (* maxwidth (/ hval wval)) INTERPOLATION-LANCZOS)
 )
 
	   (plug-in-sharpen RUN-NONINTERACTIVE
                                   image drawable 10)

             (file-jpeg-save RUN-NONINTERACTIVE
                             image drawable (string-append "thumbs/" newfilename) (string-append "thumbs/" newfilename) 1 0 1 0 "" 2 0 0 2)
           (set! filelistl (cdr filelistl))))
           
           
           
           
       (while (not (null? filelistm))
           (let* (	(filename (car filelistm))
		        (image (car (gimp-file-load RUN-NONINTERACTIVE
		                                      filename filename)))
		        (drawable (car (gimp-image-get-active-layer image)))
			(wval (car (gimp-image-width image)))
			(hval (car (gimp-image-height image)))
			(newfilename (string-append "phoca_thumb_m_" filename))
	   	 )
	   (plug-in-sharpen RUN-NONINTERACTIVE
                                   image drawable 25)

  (if (> wval hval) 
  
            (gimp-image-crop image hval hval (/ (- wval hval) 2) 0)
   
            (gimp-image-crop image wval wval 0 (/ (- hval wval) 2))

   )
   
   (gimp-image-scale-full image widthm heightm INTERPOLATION-LANCZOS)
   
	   (plug-in-sharpen RUN-NONINTERACTIVE
                                   image drawable 10)

             (file-jpeg-save RUN-NONINTERACTIVE
                             image drawable (string-append "thumbs/" newfilename) (string-append "thumbs/" newfilename) 1 0 1 0 "" 2 0 0 2)
           (set! filelistm (cdr filelistm))))
           
           
           
      (while (not (null? filelists))
           (let* (	(filename (car filelists))
		        (image (car (gimp-file-load RUN-NONINTERACTIVE
		                                      filename filename)))
		        (drawable (car (gimp-image-get-active-layer image)))
			(wval (car (gimp-image-width image)))
			(hval (car (gimp-image-height image)))
			(newfilename (string-append "phoca_thumb_s_" filename))
	   	 )
	   (plug-in-sharpen RUN-NONINTERACTIVE
                                   image drawable 25)

  (if (> wval hval) 
  
            (gimp-image-crop image hval hval (/ (- wval hval) 2) 0)
   
            (gimp-image-crop image wval wval 0 (/ (- hval wval) 2))

   )
   
   (gimp-image-scale-full image widths widths INTERPOLATION-LANCZOS)
   
	   (plug-in-sharpen RUN-NONINTERACTIVE
                                   image drawable 10)

             (file-jpeg-save RUN-NONINTERACTIVE
                             image drawable (string-append "thumbs/" newfilename) (string-append "thumbs/" newfilename) 1 0 1 0 "" 2 0 0 2)
           (set! filelists (cdr filelists))))  
           
           
           
           
           
           ))
           
           
         


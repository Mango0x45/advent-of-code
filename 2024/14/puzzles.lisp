#!/usr/bin/sbcl --script

;; START PART 2
(require :sb-posix)
;; END PART 2

(defconstant +width+  101)
(defconstant +height+ 103)

(defconstant +quadrant-bounds+
  (make-array '(4 4) :initial-contents
              (let* ((x +width+)
                     (y +height+)
                     (x/2 (floor x 2))
                     (y/2 (floor y 2)))
                `((0 0 ,x/2 ,y/2)
                  (,(1+ x/2) 0 ,x ,y/2)
                  (0 ,(1+ y/2) ,x/2 ,y)
                  (,(1+ x/2) ,(1+ y/2) ,x ,y)))))

(defparameter *chart*
  (make-array (list +height+ +width+)))

(defstruct robot
  (position nil :type (cons integer integer))
  (velocity nil :type (cons integer integer)))

(defun main (filename)
  (let ((robots (parse-robots filename)))
    ;; START PART 1
    (loop for robot in robots
          do (plot-on-chart (location-after-n-seconds 100 robot))
          finally (return (* (sum-for-quadrant 0)
                             (sum-for-quadrant 1)
                             (sum-for-quadrant 2)
                             (sum-for-quadrant 3))))
    ;; END PART 1 START PART 2
    (handler-case (sb-posix:mkdir "charts" #o755)
      (sb-posix:syscall-error ()))      ; EEXIST
    (loop for i from 0 below 10000
          do (setq *chart* (make-array (list +height+ +width+)))
          (loop for robot in robots
                do (plot-on-chart (location-after-n-seconds i robot))
                finally (save-chart-to-bmp i)))
    ;; END PART 2
    ))

(defun parse-robots (filename)
  (with-open-file (stream filename)
    (loop for line = (read-line stream nil)
          while line
          for numbers = (extract-numbers-from-string line)
          collect (make-robot :position (cons (aref numbers 0)
                                              (aref numbers 1))
                              :velocity (cons (aref numbers 2)
                                              (aref numbers 3))))))

(defun extract-numbers-from-string (string)
  (loop with number-count = 4
        with numbers = (make-array number-count)
        for i from 0 below number-count
        for start = (position-if #'integer-char-p string)
        for end = (position-if-not #'integer-char-p string :start start)
        do (setf (aref numbers i) (parse-integer (subseq string start end))
                 string (subseq string (or end (length string))))
        finally (return numbers)))

(defun location-after-n-seconds (seconds robot)
  (cons (mod (+ (car (robot-position robot))
                (* seconds (car (robot-velocity robot))))
             +width+)
        (mod (+ (cdr (robot-position robot))
                (* seconds (cdr (robot-velocity robot))))
             +height+)))

(defun plot-on-chart (position)
  (incf (aref *chart* (cdr position) (car position))))

(defun sum-for-quadrant (quadrant)
  (loop with q1 = (aref +quadrant-bounds+ quadrant 0)
        with q2 = (aref +quadrant-bounds+ quadrant 1)
        with q3 = (aref +quadrant-bounds+ quadrant 2)
        with q4 = (aref +quadrant-bounds+ quadrant 3)
        for x from q1 below q3
        sum (loop for y from q2 below q4
                  sum (aref *chart* y x))))

(defun integer-char-p (char)
  (or (digit-char-p char) (char= char #\-)))

;; START PART 2
(defun save-chart-to-bmp (i)
  (with-open-file (stream (format nil "charts/~4,'0d.bmp" i)
                          :direction :output
                          :if-exists :supersede
                          :element-type '(unsigned-byte 8))
    (let* ((row-size (ceiling +width+ 8))
           (padding (mod (- 4 (mod row-size 4)) 4))
           (pixel-data-size (* +height+ (+ row-size padding)))
           (pixel-data-offset (+ 14 12 6))
           (file-size (+ pixel-data-offset pixel-data-size)))
      ;; Bitmap file header
      (write-sequence '(#x42 #x4D) stream) ; ‘BM’
      (write-uint file-size 4 stream)
      (write-uint 0 4 stream)           ; Reserved bytes
      (write-uint pixel-data-offset 4 stream)

      ;; Bitmap information header (BITMAPCOREHEADER)
      (write-uint 12 4 stream)
      (write-uint +width+ 2 stream)
      (write-uint +height+ 2 stream)
      (write-uint 1 2 stream)           ; Number of color panes
      (write-uint 1 2 stream)           ; Bits per pixel

      ;; Color table
      (write-sequence '(#x00 #x00 #x00) stream) ; Black
      (write-sequence '(#xFF #xFF #xFF) stream) ; White

      ;; Pixel data
      (dotimes (y +height+)
        (let ((row-data (make-array row-size :element-type '(unsigned-byte 8))))
          (dotimes (x +width+)
            (let ((bit (min (aref *chart* y x) 1)))
              (multiple-value-bind (q r) (floor x 8)
                (setf (aref row-data q)
                      (logior (aref row-data q)
                              (ash bit (- 7 r)))))))
          (write-sequence row-data stream))
        (dotimes (_ padding)
          (write-byte 0 stream))))))

(defun write-uint (number size stream)
  (dotimes (i size)
    (write-byte (ldb (byte 8 (* 8 i)) number) stream)))
;; END PART 2

;; START PART 1
(format t "~d~%" (main "input"))
;; END PART 1 START PART 2
(main "input")
;; END PART 2
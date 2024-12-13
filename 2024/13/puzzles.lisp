#!/usr/bin/sbcl --script

(defun main (filename)
  (loop for numbers in (parse-input filename)
        sum (solve numbers)))

(defun parse-input (filename)
  (with-open-file (stream filename)
    (let ((contents (make-string (file-length stream))))
      (read-sequence contents stream)
      (loop for paragraph in (split-string contents (format nil "~%~%"))
            collect (extract-numbers-from-string paragraph)))))

(defun extract-numbers-from-string (string)
  (loop with number-count = 6
        with numbers = (make-array number-count)
        for i from 0 below number-count
        for start = (position-if #'digit-char-p string)
        for end = (position-if-not #'digit-char-p string :start start)
        do (setf (aref numbers i) (parse-integer (subseq string start end))
                 string (subseq string (or end 0)))
        finally (return numbers)))

(defun split-string (string delimiter)
  (loop with delimiter-length = (length delimiter)
        for end = (search delimiter string)
        unless (eq end 0)
          collect (subseq string 0 end) into parts
        unless end
          return parts
        do (setq string (subseq string (+ end delimiter-length)))))

(defun solve (numbers)
  ;; ⎡ a0 b0 ⎢ c0 ⎤
  ;; ⎣ a1 b1 ⎢ c1 ⎦
  (let* ((a0 (aref numbers 0))
         (a1 (aref numbers 1))
         (b0 (aref numbers 2))
         (b1 (aref numbers 3))
         (c0 (aref numbers 4))
         (c1 (aref numbers 5))
         ;; START PART 2
         (c0 (+ 10000000000000 c0))
         (c1 (+ 10000000000000 c1))
         ;; END PART 2
         (D-bar  (determinant a0 b0 a1 b1))
         (Dx-bar (determinant c0 b0 c1 b1))
         (Dy-bar (determinant a0 c0 a1 c1))
         (x (/ Dx-bar D-bar))
         (y (/ Dy-bar D-bar)))
    (if (and (integerp x)
             (integerp y))
        (+ (* x 3) y)
        0)))

(defun determinant (a b c d)
  (- (* a d)
     (* b c)))

(format t "~d~%" (main "input"))
#!/usr/bin/sbcl --script

(defparameter *memo* (make-hash-table :test 'equal))

(defun main (filename blink-count)
  (let ((stones (read-stones filename)))
    (loop for stone in stones
          sum (count-stones stone blink-count))))

(defun read-stones (filename)
  (with-open-file (stream filename)
    (let ((contents (make-string (file-length stream))))
      (read-sequence contents stream)
      (read-from-string (concatenate 'string "(" contents ")")))))

(defun count-stones (stone blink-count)
  (or (gethash (cons stone blink-count) *memo*)
      (setf (gethash (cons stone blink-count) *memo*)
            (cond ((= (decf blink-count) -1)
                   1)
                  ((= stone 0)
                   (count-stones 1 blink-count))
                  ((evenp (integer-digit-count stone))
                   (let ((hi-lo (integer-split stone)))
                     (+ (count-stones (car hi-lo) blink-count)
                        (count-stones (cdr hi-lo) blink-count))))
                  (:else
                   (count-stones (* 2024 stone) blink-count))))))

(defun integer-digit-count (x)
  (loop with n = 0
        while (/= x 0)
        do (progn (incf n) (setq x (floor x 10)))
        finally (return n)))

(defun integer-split (x)
  (let* ((n (floor (integer-digit-count x) 2))
         (m (expt 10 n)))
    (cons (floor x m)
          (mod x m))))

;; START PART 1
(format t "~d~%" (main "input" 25))
;; END PART 1 START PART 2
(format t "~d~%" (main "input" 75))
;; END PART 2
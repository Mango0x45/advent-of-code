#!/usr/bin/sbcl --script

(defparameter *memo* (make-hash-table :test 'equal))

(defun main (filename blink-count)
  (loop for stone in (read-stones filename)
        sum (count-stones stone blink-count)))

(defun read-stones (filename)
  (with-open-file (stream filename)
    (let ((contents (make-string (file-length stream))))
      (read-sequence contents stream)
      (read-from-string (concatenate 'string "(" contents ")")))))

(defun count-stones (stone blink-count)
  (let ((stone+blink-count (cons stone blink-count)))
    (or (gethash stone+blink-count *memo*)
        (setf (gethash stone+blink-count *memo*)
              (cond ((minusp (decf blink-count))
                     1)
                    ((zerop stone)
                     (count-stones 1 blink-count))
                    ((evenp (integer-digit-count stone))
                     (multiple-value-bind (hi lo) (integer-split stone)
                       (+ (count-stones hi blink-count)
                          (count-stones lo blink-count))))
                    (:else
                      (count-stones (* 2024 stone) blink-count)))))))

(defun integer-digit-count (x)
  (1+ (truncate (log x 10))))

(defun integer-split (x)
  (floor x (expt 10 (floor (integer-digit-count x) 2))))

;; START PART 1
(format t "~d~%" (main "input" 25))
;; END PART 1 START PART 2
(format t "~d~%" (main "input" 75))
;; END PART 2

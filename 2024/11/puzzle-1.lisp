#!/usr/bin/sbcl --script

(defparameter *numbers*
  '())

(defun main (filename)
  (setq *numbers* (read-stones filename))
  (loop repeat 25
        do (blink)
        finally (return (length *numbers*))))

(defun read-stones (filename)
  (with-open-file (stream filename)
    (let ((contents (make-string (file-length stream))))
      (read-sequence contents stream)
      (read-from-string (concatenate 'string "(" contents ")")))))

(defun blink ()
  (setq *numbers*
        (loop for number in *numbers*
              for after-blink = (stone-change-or-split number)
              if (listp after-blink)
                append after-blink
              else
                collect after-blink
              finally (setq *numbers* after-blink))))

(defun stone-change-or-split (number)
  (cond ((= number 0)
         1)
        ((evenp (digit-count number))
         (number-split number))
        (:else
         (* 2024 number))))

(defun digit-count (number)
  (loop with x = 0
        while (/= number 0)
        do (progn
             (incf x)
             (setq number (floor number 10)))
        finally (return x)))

(defun number-split (number)
  (let* ((length (digit-count number))
         (string (write-to-string number))
         (half (/ length 2)))
    (list (parse-integer (subseq string 0 half))
          (parse-integer (subseq string half (length string))))))

(format t "~d~%" (main "input"))
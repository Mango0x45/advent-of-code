#!/usr/bin/sbcl --script

(load "machine.lisp")

(defun main (filename)
  (multiple-value-call #'machine:run (parse filename)))

(defun parse (filename)
  (with-open-file (stream filename)
    (let ((contents (make-string (file-length stream))))
      (read-sequence contents stream)
      (extract-numbers-from-string contents))))

(defun extract-numbers-from-string (string)
  (let (numbers)
    (loop do
      (let* ((beg (position-if #'digit-char-p string))
             (end (position-if-not #'digit-char-p string :start (or beg 0))))
        (unless beg
          (loop-finish))
        (push (parse-integer (subseq string beg end)) numbers)
        (setq string (subseq string (or end (length string))))))
    (setq numbers (nreverse numbers))
    (values
     (coerce (cdddr numbers) 'vector)
     (first  numbers)
     (second numbers)
     (third  numbers))))

(loop with output = (main "input")
      for number in output
      for i upfrom 1
      do (format t "~d~c" number (if (= i (length output))
                                     #\Newline #\,)))
#!/usr/bin/sbcl --script

(load "../interpreter.lisp")

(defun main (filename)
  (let ((stdin (make-string-input-stream
                ;; START PART 1
                "1"
                ;; END PART 1 START PART 2
                "5"
                ;; END PART 2
                ))
        (stdout (make-string-output-stream)))
    (intcode:run (intcode:parse "input") stdin stdout)
    (parse-integer (last-line (get-output-stream-string stdout)))))

(defun last-line (string)
  (let* ((nl-e (position #\Newline string :from-end t))
         (nl-b (position #\Newline string :from-end t :end nl-e)))
    (subseq string (1+ (or nl-b -1)) nl-e)))

(format t "~d~%" (main "input"))
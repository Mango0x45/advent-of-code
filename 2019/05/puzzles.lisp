#!/usr/bin/sbcl --script

(load "../interpreter.lisp")

(defun main (filename)
  (let (result)
    (intcode:run (intcode:parse filename)
                 (lambda () (if (= +puzzle-part+ 1) 1 5))
                 (lambda (x) (setq result x)))
    result))

(format t "~d~%" (main "input"))
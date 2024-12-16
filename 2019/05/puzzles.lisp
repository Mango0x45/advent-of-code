#!/usr/bin/sbcl --script

(load "../interpreter.lisp")

(format t "~a~%" (car (last (intcode:run (intcode:parse "input")
                                         ;; START PART 1
                                         '(1)
                                         ;; END PART 1 START PART 2
                                         '(5)
                                         ;; END PART 2
                                         ))))
#!/usr/bin/sbcl --script

(load "../interpreter.lisp")

(intcode:run (intcode:parse "input")
             (lambda () +puzzle-part+)
             (lambda (x) (format t "~d~%" x)))
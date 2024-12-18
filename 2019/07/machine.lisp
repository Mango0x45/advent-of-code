#!/usr/bin/sbcl --script

(load "../interpreter.lisp")

(intcode:run (intcode:parse "input")
             (lambda ()
               (parse-integer
                (if (rest *posix-argv*)
                    (first (setf *posix-argv* (rest *posix-argv*)))
                    (read-line))))
             (lambda (x) (format t "~d~%" x)))
#!/usr/bin/sbcl --script

(load "../interpreter.lisp")

(intcode:run (intcode:parse "input") *standard-input* *standard-output*
             :initial-arguments (mapcar #'parse-integer (cdr *posix-argv*)))
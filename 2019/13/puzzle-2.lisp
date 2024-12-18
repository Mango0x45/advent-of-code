#!/usr/bin/sbcl --script

(load "../interpreter.lisp")

(defun sign (x)
  (cond ((minusp x) -1)
        ((plusp  x) +1)
        (:else       0)))

(defun main (filename)
  (let ((program (intcode:parse filename))
        (part 0) score
        ball-x paddle-x
        msg-x msg-y msg-z)
    (setf (aref program 0) 2)
    (intcode:run
     program
     (lambda ()
       (sign (- ball-x paddle-x)))
     (lambda (msg)
       (ecase part
         (0 (setq msg-x msg))
         (1 (setq msg-y msg))
         (2 (case msg
              (3 (setq paddle-x msg-x))
              (4 (setq ball-x msg-x))
              (otherwise
               (when (and (= msg-x -1) (= msg-y 0))
                 (setq score msg))))))
       (setq part (mod (1+ part) 3))))
    score))

(format t "~d~%" (main "input"))
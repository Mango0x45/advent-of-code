#!/usr/bin/sbcl --script

(load "../interpreter.lisp")

(defun run-with-noun-and-verb (noun verb ram)
  (setf (aref ram 1) noun
        (aref ram 2) verb)
  (intcode:run ram)
  (aref ram 0))

;; START PART 1
(let ((program (intcode:parse "input")))
  (format t "~d~%" (run-with-noun-and-verb 12 2 program)))
;; END PART 1 START PART 2
(let* ((program (intcode:parse "input"))
       (ram (make-array (length program))))
  (dotimes (noun 100)
    (dotimes (verb 100)
      (loop for i from 0 below (length program)
            do (setf (aref ram i) (aref program i)))
      (when (= (run-with-noun-and-verb noun verb ram) 19690720)
        (format t "~d~%" (+ (* 100 noun) verb))
        (quit)))))
;; END PART 2
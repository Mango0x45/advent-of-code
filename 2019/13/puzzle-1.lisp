#!/usr/bin/sbcl --script

(load "../interpreter.lisp")

(defun main (filename)
  (let ((blocks (make-hash-table))
        parts)
    (intcode:run (intcode:parse "input") nil
                 (lambda (msg)
                   (if (< (length parts) 2)
                       (push msg parts)
                       (let ((y (first  parts))
                             (x (second parts)))
                         (when (= msg 2)
                           (setf (gethash (complex x y) blocks) t))
                         (setq parts nil)))))
    (hash-table-count blocks)))

(format t "~d~%" (main "input"))
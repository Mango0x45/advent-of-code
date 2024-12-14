(defpackage #:intcode
  (:use :cl)
  (:export :run :parse))

(in-package #:intcode)

;;; Interpreter

(defun run (ram)
  (let ((ip 0))
    (loop
     (let ((opcode (aref ram ip))
           (arg-1 (try-aref ram (+ ip 1)))
           (arg-2 (try-aref ram (+ ip 2)))
           (arg-3 (try-aref ram (+ ip 3))))
       (case opcode
         (1
          (setf (aref ram arg-3)
                (+ (aref ram arg-1)
                   (aref ram arg-2))))
         (2
          (setf (aref ram arg-3)
                (* (aref ram arg-1)
                   (aref ram arg-2))))
         (99
          (return-from run))
         (otherwise
          (error (format nil "Invalid opcode ‘~d’" opcode)))))
     (incf ip 4))))

;;; Input Parsing

(defun parse (filename)
  (with-open-file (stream filename)
    (let ((contents (make-string (file-length stream))))
      (read-sequence contents stream)
      (extract-numbers-from-string contents))))

(defun extract-numbers-from-string (string)
  (loop for comma-pos = (position-if #'commap string)
        collect (parse-integer (subseq string 0 comma-pos)) into numbers
        unless comma-pos
          return (coerce numbers 'vector)
        do (setq string (subseq string (1+ comma-pos)))))

;;; Helper Functions

(defun commap (char)
  (char= char #\,))

(defun try-aref (array &rest subscripts)
  (loop for i in subscripts
        for j in (array-dimensions array)
        unless (< -1 i j)
          return nil
        finally (return (apply #'aref array subscripts))))
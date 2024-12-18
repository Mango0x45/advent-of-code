(defpackage #:intcode
  (:use :cl)
  (:export :run :parse))

(in-package #:intcode)

;;; Interpreter

(defstruct (machine (:conc-name mach-)
                    (:constructor make-machine
                        (program stdin stdout))
                    (:type (vector t)))
  (ip        0 :type integer)
  (program nil :type array)
  (stdin   nil :type (or null stream))
  (stdout  nil :type (or null stream)))

(defstruct (instruction (:conc-name instr-)
                        (:constructor make-instruction
                            (opcode param-count param-modes last-outputs-p))
                        (:type (vector t)))
  (opcode         nil :type integer)
  (param-count    nil :type integer)
  (param-modes    nil :type array)
  last-outputs-p)

(defconstant +op-add+   1)
(defconstant +op-mul+   2)
(defconstant +op-set+   3)
(defconstant +op-out+   4)
(defconstant +op-jt+    5)
(defconstant +op-jn+    6)
(defconstant +op-le+    7)
(defconstant +op-eq+    8)
(defconstant +op-quit+ 99)

(defparameter *handlers* (make-array 100))

(define-condition machine-sysjump (error) ())
(define-condition machine-sysexit (error) ())

(defun run (program &optional stdin stdout)
  (loop with mach = (make-machine program stdin stdout) do
    (let* ((instr (decode-next-instr mach))
           (opcode (instr-opcode instr))
           (handler (aref *handlers* opcode))
           (arguments (fetch-arguments instr mach))
           (ip-shift (1+ (instr-param-count instr))))
      (handler-case (apply handler mach arguments)
        (machine-sysjump (c)
          (declare (ignore c))
          (decf (mach-ip mach) ip-shift))
        (machine-sysexit (c)
          (declare (ignore c))
          (return-from run)))
      (incf (mach-ip mach) ip-shift))))

(defun decode-next-instr (mach)
  (let* ((raw-instr
           (aref (mach-program mach) (mach-ip mach)))
         (opcode
           (mod raw-instr 100))
         (param-count
           (ecase opcode
             (#.+op-add+  3)
             (#.+op-mul+  3)
             (#.+op-set+  1)
             (#.+op-out+  1)
             (#.+op-jt+   2)
             (#.+op-jn+   2)
             (#.+op-le+   3)
             (#.+op-eq+   3)
             (#.+op-quit+ 0)))
         (param-modes
           (make-array 3 :initial-contents
                       (list (mod (floor raw-instr   100) 10)
                             (mod (floor raw-instr  1000) 10)
                             (mod (floor raw-instr 10000) 10))))
         (last-outputs-p
           (member opcode '(#.+op-add+ #.+op-mul+ #.+op-set+
                            #.+op-le+ #.+op-eq+))))
    (make-instruction opcode param-count param-modes last-outputs-p)))

(defun fetch-arguments (instr mach)
  (when (instr-last-outputs-p instr)
    (setf (aref (instr-param-modes instr)
                (1- (instr-param-count instr)))
          1))
  (loop with program = (mach-program mach) with ip = (mach-ip mach)
        for i from 1 to (instr-param-count instr)
        collect (ecase (aref (instr-param-modes instr) (1- i))
                  (0 (aref program (aref program (+ ip i))))
                  (1               (aref program (+ ip i))))))

;;; Instructions

(defmacro definstruction (name (&rest params) &body forms)
  (let ((instr (intern (format nil "+OP-~:@(~a~)+" name))))
    `(setf (aref *handlers* ,instr) (lambda ,params ,@forms))))

(definstruction add (mach x y dst)
  (setf (aref (mach-program mach) dst) (+ x y)))

(definstruction mul (mach x y dst)
  (setf (aref (mach-program mach) dst) (* x y)))

(definstruction set (mach dst)
  (setf (aref (mach-program mach) dst)
        (parse-integer (read-line (mach-stdin mach)))))

(definstruction out (mach x)
  (format (mach-stdout mach) "~d~%" x))

(definstruction jt (mach x addr)
  (unless (zerop x)
    (setf (mach-ip mach) addr)
    (error 'machine-sysjump)))

(definstruction jn (mach x addr)
  (when (zerop x)
    (setf (mach-ip mach) addr)
    (error 'machine-sysjump)))

(definstruction le (mach x y dst)
  (setf (aref (mach-program mach) dst) (bool-to-int (< x y))))

(definstruction eq (mach x y dst)
  (setf (aref (mach-program mach) dst) (bool-to-int (= x y))))

(definstruction quit (mach)
  (declare (ignore mach))
  (error 'machine-sysexit))

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

(defun bool-to-int (bool)
  (if bool 1 0))

(defun try-aref (array &rest subscripts)
  (loop for i in subscripts
        for j in (array-dimensions array)
        unless (< -1 i j)
          return nil
        finally (return (apply #'aref array subscripts))))
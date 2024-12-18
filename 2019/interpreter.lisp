(defpackage #:intcode
  (:use :cl)
  (:export :run :parse))

(in-package #:intcode)

;;; Interpreter

(defstruct (machine (:conc-name mach-)
                    (:constructor make-machine
                        (mem input-handler output-handler)))
  (ip 0 :type integer)
  (rel-base 0 :type integer)
  (mem nil :type array)
  (ext-mem (make-hash-table) :type hash-table)
  (input-handler nil :type (or null function))
  (output-handler nil :type (or null function)))

(defstruct (instruction (:conc-name instr-)
                        (:constructor make-instruction
                            (opcode param-count param-modes)))
  (opcode      nil :type integer)
  (param-count nil :type integer)
  (param-modes nil :type array))

(defconstant +op-add+   1)
(defconstant +op-mul+   2)
(defconstant +op-set+   3)
(defconstant +op-out+   4)
(defconstant +op-jt+    5)
(defconstant +op-jn+    6)
(defconstant +op-le+    7)
(defconstant +op-eq+    8)
(defconstant +op-rel+   9)
(defconstant +op-quit+ 99)

(defparameter *handlers* (make-array 100))

(define-condition machine-sysjump (error) ())
(define-condition machine-sysexit (error) ())

(defun run (program &optional input-handler output-handler)
  (loop with mach = (make-machine program input-handler output-handler) do
    (let* ((instr (decode-next-instr mach))
           (opcode (instr-opcode instr))
           (handler (aref *handlers* opcode))
           (ip-shift (1+ (instr-param-count instr))))
      (handler-case (funcall handler mach instr)
        (machine-sysjump (c)
          (declare (ignore c))
          (decf (mach-ip mach) ip-shift))
        (machine-sysexit (c)
          (declare (ignore c))
          (return-from run)))
      (incf (mach-ip mach) ip-shift))))

(defun decode-next-instr (mach)
  (let* ((raw-instr
           (memref mach (mach-ip mach)))
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
             (#.+op-rel+  1)
             (#.+op-quit+ 0)))
         (param-modes
           (make-array 3 :initial-contents
                       (list (mod (floor raw-instr   100) 10)
                             (mod (floor raw-instr  1000) 10)
                             (mod (floor raw-instr 10000) 10)))))
    (make-instruction opcode param-count param-modes)))

(defun memref (mach i)
  (let ((mem (mach-mem mach)))
    (if (< i (length mem))
        (aref mem i)
        (gethash i (mach-ext-mem mach) 0))))

(defun (setf memref) (value mach i)
  (let ((mem (mach-mem mach)))
    (if (< i (length mem))
        (setf (aref mem i) value)
        (setf (gethash i (mach-ext-mem mach)) value))))

(defun fetch-param (mach i in-out mode)
  (let* ((ip (mach-ip mach))
         (rel-base (mach-rel-base mach))
         (argptr (+ ip i)))
    (ecase in-out
      (in (ecase mode
            (0 (memref mach (memref mach argptr)))
            (1 (memref mach argptr))
            (2 (memref mach (+ (memref mach argptr) rel-base)))))
      (out (ecase mode
             (0 (memref mach argptr))
             (2 (+ (memref mach argptr) rel-base)))))))

;;; Instructions

(defmacro definstruction (name (&rest params) &body forms)
  (let ((op-symbol (intern (format nil "+OP-~:@(~a~)+" name))))
    `(setf (aref *handlers* ,op-symbol)
           (lambda (mach instr)
             (let ((ptype 'in)
                   (i 0)
                   in out)
               (dolist (param ',(cdr params))
                 (if (eq param '&out)
                     (setq ptype 'out)
                     (let ((pval (fetch-param
                                  mach (1+ i) ptype
                                  (aref (instr-param-modes instr) i))))
                       (if (eq ptype 'in)
                           (push pval in)
                           (push pval out))
                       (incf i))))
               (apply (lambda ,(remove-if (lambda (sym) (eq sym '&out)) params)
                        ,@forms)
                      mach (append (reverse in) (reverse out))))))))

(definstruction add (mach x y &out dst)
  (setf (memref mach dst) (+ x y)))

(definstruction mul (mach x y &out dst)
  (setf (memref mach dst) (* x y)))

(definstruction set (mach &out dst)
  (setf (memref mach dst) (funcall (mach-input-handler mach))))

(definstruction out (mach x)
  (funcall (mach-output-handler mach) x))

(definstruction jt (mach x addr)
  (unless (zerop x)
    (setf (mach-ip mach) addr)
    (error 'machine-sysjump)))

(definstruction jn (mach x addr)
  (when (zerop x)
    (setf (mach-ip mach) addr)
    (error 'machine-sysjump)))

(definstruction le (mach x y &out dst)
  (setf (memref mach dst) (bool-to-int (< x y))))

(definstruction eq (mach x y &out dst)
  (setf (memref mach dst) (bool-to-int (= x y))))

(definstruction rel (mach x)
  (incf (mach-rel-base mach) x))

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
          return (make-array (length numbers)
                             :initial-contents numbers
                             :fill-pointer t)
        do (setq string (subseq string (1+ comma-pos)))))

;;; Helper Functions

(defun commap (char)
  (char= char #\,))

(defun bool-to-int (bool)
  (if bool 1 0))
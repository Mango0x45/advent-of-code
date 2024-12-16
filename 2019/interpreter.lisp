(defpackage #:intcode
  (:use :cl)
  (:export :run :parse))

(in-package #:intcode)

;;; Interpreter

(defstruct opcode
  instr
  param-count
  param-modes
  last-outputs-p)

(defconstant +instr-add+   1)
(defconstant +instr-mul+   2)
(defconstant +instr-set+   3)
(defconstant +instr-out+   4)
(defconstant +instr-jt+    5)
(defconstant +instr-jn+    6)
(defconstant +instr-le+    7)
(defconstant +instr-eq+    8)
(defconstant +instr-quit+ 99)

(defparameter *handlers* (make-array 100))

;; Interpreter State
(defparameter *ip* 0)
(defparameter *inputs* nil)
(defparameter *outputs* nil)
(defparameter *ram* nil)

(defun run (ram &optional inputs)
  (setq *ip* 0 *inputs* inputs *outputs* nil *ram* ram)
  (loop
    (let* ((opcode (decode-next-opcode))
           (handler (aref *handlers* (opcode-instr opcode))))
      (when (eq (apply handler (fetch-arguments opcode)) 'quit)
        (return-from run (nreverse *outputs*))))))

(defun decode-next-opcode ()
  (let* ((opcode
           (aref *ram* *ip*))
         (instr
           (mod opcode 100))
         (param-count
           (ecase instr
             (#.+instr-add+  3)
             (#.+instr-mul+  3)
             (#.+instr-set+  1)
             (#.+instr-out+  1)
             (#.+instr-jt+   2)
             (#.+instr-jn+   2)
             (#.+instr-le+   3)
             (#.+instr-eq+   3)
             (#.+instr-quit+ 0)))
         (param-modes
           (make-array 3 :initial-contents
                       (list (mod (floor opcode   100) 10)
                             (mod (floor opcode  1000) 10)
                             (mod (floor opcode 10000) 10))))
         (last-outputs-p
           (member instr '(#.+instr-add+ #.+instr-mul+ #.+instr-set+
                           #.+instr-le+ #.+instr-eq+))))
    (make-opcode :instr instr
                 :param-count param-count
                 :param-modes param-modes
                 :last-outputs-p last-outputs-p)))

(defun fetch-arguments (opcode)
  (when (opcode-last-outputs-p opcode)
    (setf (aref (opcode-param-modes opcode)
                (1- (opcode-param-count opcode)))
          1))
  (loop for i from 1 to (opcode-param-count opcode)
        collect (ecase (aref (opcode-param-modes opcode) (1- i))
                  (0 (aref *ram* (aref *ram* (+ *ip* i))))
                  (1             (aref *ram* (+ *ip* i))))))

;;; Instructions

(defmacro definstruction (name (&rest params) &body forms)
  (let ((instr (intern (format nil "+INSTR-~:@(~a~)+" name))))
    `(setf (aref *handlers* ,instr)
           (lambda ,params
             (case (progn ,@forms)
               ('jumpedp nil)
               ('quit 'quit)
               (otherwise (incf *ip* ,(1+ (length params)))))))))

(definstruction add (x y dst)
  (setf (aref *ram* dst) (+ x y)))

(definstruction mul (x y dst)
  (setf (aref *ram* dst) (* x y)))

(definstruction set (dst)
  (setf (aref *ram* dst) (car *inputs*))
  (setq *inputs* (cdr *inputs*)))

(definstruction out (x)
  (push x *outputs*))

(definstruction jt (x addr)
  (unless (zerop x)
    (setq *ip* addr)
    'jumpedp))

(definstruction jn (x addr)
  (when (zerop x)
    (setq *ip* addr)
    'jumpedp))

(definstruction le (x y dst)
  (setf (aref *ram* dst) (bool->int (< x y))))

(definstruction eq (x y dst)
  (setf (aref *ram* dst) (bool->int (= x y))))

(definstruction quit ()
  'quit)

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

(defun bool->int (bool)
  (if bool 1 0))

(defun try-aref (array &rest subscripts)
  (loop for i in subscripts
        for j in (array-dimensions array)
        unless (< -1 i j)
          return nil
        finally (return (apply #'aref array subscripts))))
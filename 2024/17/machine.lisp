(defpackage #:machine
  (:use :cl)
  (:export :run))

(in-package #:machine)

;;; Interpreter

(defconstant +op-adv+ 0)
(defconstant +op-bxl+ 1)
(defconstant +op-bst+ 2)
(defconstant +op-jnz+ 3)
(defconstant +op-bxc+ 4)
(defconstant +op-out+ 5)
(defconstant +op-bdv+ 6)
(defconstant +op-cdv+ 7)

(defun run (program A B C)
  (let ((ip 0)
        output)
    (flet ((fetch-oprand (oprand)
             (case oprand
               (4 A) (5 B) (6 C)
               (otherwise oprand)))
           (xdv (oprand)
             (floor A (ash 2 (1- oprand)))))
      (loop while (< ip (length program)) do
        (let* ((opcode (aref program ip))
               (oprand-lit (aref program (1+ ip)))
               (oprand (fetch-oprand oprand-lit)))
          (ecase opcode
            (#.+op-bxl+
             (setq B (logxor B oprand-lit)))
            (#.+op-bst+
             (setq B (logand oprand #b111)))
            (#.+op-jnz+
             (unless (zerop A)
               (setq ip (- oprand-lit 2))))
            (#.+op-bxc+
             (setq B (logxor B C)))
            (#.+op-out+
             (push (logand oprand #b111) output))
            (#.+op-adv+ (setq A (xdv oprand)))
            (#.+op-bdv+ (setq B (xdv oprand)))
            (#.+op-cdv+ (setq C (xdv oprand))))
          (incf ip 2))))
    (nreverse output)))
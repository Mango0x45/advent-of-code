#!/usr/bin/emacs --script

(defsubst char-to-number (char)
  (declare (pure t) (side-effect-free t))
  (- char ?0))

(defun first-nil (vector start)
  (cl-loop for i from (1+ start) below (length vector)
           when (null (aref vector i))
           return i
           finally return (length vector)))

(defun last-number (vector start)
  (cl-loop for i from (1- start) downto 0
           when (aref vector i)
           return i
           finally return 0))

(defun solve (input-file)
  (let* ((input (with-temp-buffer
                  (insert-file-contents-literally input-file)
                  (buffer-string)))
         (nums (mapcar #'char-to-number input))
         (vector (make-vector (apply #'+ nums) nil))
         (i 0) (j 0))

    ;; Populate ‘vector’
    (dolist (num nums)
      (when (cl-evenp i)
        (dotimes (k num)
          (aset vector (+ j k) (/ i 2))))
      (cl-incf i)
      (cl-incf j num))

    ;; Swap elements
    (setq i (first-nil vector 0)
          j (last-number vector (length vector)))
    (while (< i j)
      (let ((x (aref vector i))
            (y (aref vector j)))
        (aset vector i y)
        (aset vector j x))
      (setq i (first-nil vector i))
      (setq j (last-number vector j)))

    ;; Compute checksum
    (cl-loop for i from 0 below (length vector)
             for x = (aref vector i)
             while x sum (* i x))))

(message "%d" (solve "input"))
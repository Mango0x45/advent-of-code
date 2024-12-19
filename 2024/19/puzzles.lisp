#!/usr/bin/sbcl --script

(defun main (filename)
  (multiple-value-bind (towels stream) (parse filename)
    (loop for pattern = (read-line stream nil)
          while pattern
          ;; START PART 1
          count (plusp (nconstructions pattern towels))
          ;; END PART 1 START PART 2
          sum (nconstructions pattern towels)
          ;; END PART 2
          finally (close stream))))

(defparameter *memo*
  (let ((map (make-hash-table :test #'equal)))
    (setf (gethash "" map) 1)
    map))

(defun nconstructions (pattern towels)
  (multiple-value-bind (count existsp) (gethash pattern *memo*)
    (when existsp
      (return-from nconstructions count)))
  (let ((count 0))
    (dolist (towel towels)
      (when (string-prefix-p towel pattern)
        (incf count (nconstructions (subseq pattern (length towel)) towels))))
    (setf (gethash pattern *memo*) count)))

(defun string-prefix-p (prefix string)
  (and (<= (length prefix) (length string))
       (string= prefix (subseq string 0 (length prefix)))))

(defun parse (filename)
  (let* ((stream (open filename))
         (towels (parse-strings (read-line stream))))
    (read-line stream)                  ; Consume empty line
    (values towels stream)))

(defun parse-strings (string)
  (loop for end = (position-if-not #'alpha-char-p string)
        collect (subseq string 0 end) into strings
        unless end
          return strings
        do (setq string (subseq string (+ 2 end)))))

(format t "~d~%" (main "input"))
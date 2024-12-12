#!/usr/bin/sbcl --script

(defun main (filename)
  (loop with lines = (read-file-to-lines filename)
        with dimensions = (array-dimensions lines)
        for i from 0 below (first dimensions)
        sum (loop for j from 0 below (second dimensions)
                  when (char= #\0 (aref lines i j))
                  sum (score-for-trail-head lines i j))))

(defun read-file-to-lines (filename)
  (with-open-file (stream filename)
    (let ((lines (loop for line = (read-line stream nil)
                       while line
                       collect (coerce line 'array))))
      (make-array (list (length lines)
                        (length (first lines)))
                  :initial-contents lines))))

(defun score-for-trail-head (lines i j)
  (let* ((positions (positions-of-nines lines i j))
         ;; START PART 1
         (positions (remove-duplicates positions :test 'equal))
         ;; END PART 1
         )
    (length positions)))

(defun positions-of-nines (lines i j)
  (let ((char (aref lines i j)))
    (if (char= #\9 char)
        (list (cons i j))
        (loop with needs = (code-char (1+ (char-code char)))
              with dimensions = (array-dimensions lines)
              for (i . j) in (list (cons (1- i) j) (cons i (1- j))
                                   (cons (1+ i) j) (cons i (1+ j)))
              if (and (< -1 i (first dimensions))
                      (< -1 j (second dimensions))
                      (char= (aref lines i j) needs))
              append (positions-of-nines lines i j)))))

(format t "~d~%" (main "input"))
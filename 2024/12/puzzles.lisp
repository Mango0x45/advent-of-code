#!/usr/bin/sbcl --script

(defparameter *seen*
  (make-hash-table :test #'equal))

(defconstant +farm+
  (with-open-file (stream "input")
    (let ((lines (loop for line = (read-line stream nil)
                       while line
                       collect (coerce line 'array))))
      (make-array (list (length lines)
                        (length (first lines)))
                  :initial-contents lines))))

(defun main ()
  (loop with dimensions = (array-dimensions +farm+)
        for i from 0 below (first dimensions)
        sum (loop for j from 0 below (second dimensions)
                  sum (multiple-value-call #'* (flood-fill i j)))))

(defun flood-fill (i j)
  (flood-fill-1 (aref +farm+ i j) i j))

(defun flood-fill-1 (char i j)
  (block nil
    (let ((pos (cons i j)))
      (when (gethash pos *seen*)
        (return (values 0 0)))
      (setf (gethash pos *seen*) t))

    (when (char/= char (try-aref i j))
      (return (values 0 0)))

    (loop with neighbors = (locate-neighbors char i j)
          with a = 1
          ;; START PART 1
          with c = (- 4 (length neighbors))
          ;; END PART 1 START PART 2
          with c = (corner-count char neighbors i j)
          ;; END PART 2
          for (i . j) in neighbors
          do (multiple-value-bind (a1 c1) (flood-fill-1 char i j)
               (incf a a1)
               (incf c c1))
          finally (return (values a c)))))

(defun locate-neighbors (char i j)
  (loop for (i . j) in (list (cons (1- i) j) (cons i (1- j))
                             (cons (1+ i) j) (cons i (1+ j)))
        if (char= char (try-aref i j))
        collect (cons i j)))

;; START PART 2
(defun corner-count (char neighbors i j)
  ;; Figuring out how many corners the current chunk of the farm has is a
  ;; bit tricky.  If the chunk has less than 2 neighbors then the number
  ;; of corners is fixed.  When there are 2 neighbors then if the three
  ;; chunks form a line there are no corners, and if they form an ‘L’
  ;; then there may be 1 or 2 corners.  When there are 4 neighbors then
  ;; there are as many corners as there aren’t diagonal neighbors.
  ;; Finally the trickiest is 3 neighbors.  In this case we need to
  ;; figure out which 2 diagonal-neighbors would turn our ‘T’ shape into
  ;; a rectangle, and use them to determine how many corners we have.
  (let ((n (length neighbors)))
    (case n
      (0 4)
      (1 2)
      (2 (let* ((l (first  neighbors))
                (r (second neighbors))
                (li (car l)) (ri (car r))
                (lj (cdr l)) (rj (cdr r)))
           (cond
             ((or (= li ri i) (= lj rj j)) 0)
             ((char= char (try-aref
                           (if (= li i) ri li)
                           (if (= lj j) rj lj)))
              1)
             (:else 2))))
      (3 (let ((wart (loop for n in neighbors
                           if (/= (car n) i)
                             collect n into odd-one-out-i
                           else
                             collect n into odd-one-out-j
                           finally (return
                                     (first (if (= 1 (length odd-one-out-i))
                                                odd-one-out-i
                                                odd-one-out-j))))))
           (loop for n in neighbors
                 count (not (or (equal n wart)
                                (char= char (try-aref
                                             (if (= (car n) i)
                                                 (car wart)
                                                 (car n))
                                             (if (= (cdr n) j)
                                                 (cdr wart)
                                                 (cdr n)))))))))
      (4 (loop for (i . j) in (list (cons (1- i) (1- j)) (cons (1- i) (1+ j))
                                    (cons (1+ i) (1- j)) (cons (1+ i) (1+ j)))
               count (char/= (try-aref i j) char))))))
;; END PART 2

(defun try-aref (i j)
  (let ((dimensions (array-dimensions +farm+)))
    (if (and (< -1 i (first dimensions))
             (< -1 j (second dimensions)))
        (aref +farm+ i j)
        #\Nul)))

(format t "~d~%" (main))
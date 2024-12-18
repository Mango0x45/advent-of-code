#!/usr/bin/sbcl --script

(defconstant +end-pos+ #C(70 70))

(load "../heap.lisp")

(defun main (filename)
  ;; START PART 1
  (dijkstra (parse filename 1024))
  ;; END PART 1 START PART 2
  (loop for i upfrom 0
        while (dijkstra (parse filename i))
        finally (return (nth-line i filename)))
  ;; END PART 2
  )

(defun dijkstra (corrupted)
  (let ((to-visit (heap:make-heap :priority-function #'car))
        (seen (make-hash-table)))
    (flet ((enqueue (dist pos)
             (setf (gethash pos seen) t)
             (heap:enqueue (cons dist pos) to-visit)))
      (enqueue 0 0)
      (loop until (heap:emptyp to-visit) do
        (destructuring-bind (dist . pos) (heap:dequeue to-visit)
          (when (= pos +end-pos+)
            (return-from dijkstra dist))
          (dolist (new-pos (list (+ pos #C(0 +1)) (+ pos #C(0 -1))
                                 (+ pos #C(+1 0)) (+ pos #C(-1 0))))
            (when (valid-step-p new-pos corrupted seen)
              (enqueue (1+ dist) new-pos))))))))

(defun valid-step-p (pos corrupted seen)
  (and (<= 0 (realpart pos) (realpart +end-pos+))
       (<= 0 (imagpart pos) (imagpart +end-pos+))
       (null (gethash pos seen))
       (null (gethash pos corrupted))))

(defun parse (filename limit)
  (let ((corrupted (make-hash-table)))
    (with-open-file (stream filename)
      (loop repeat limit
            for line = (read-line stream nil)
            for pos = (parse-pos line)
            do (setf (gethash pos corrupted) t)))
    corrupted))

(defun parse-pos (string)
  (let* ((comma (position #\, string))
         (x (parse-integer (subseq string 0 comma)))
         (y (parse-integer (subseq string (1+ comma)))))
    (complex x y)))

(defun nth-line (n filename)
  (with-open-file (stream filename)
    (dotimes (i (1- n))
      (read-line stream))
    (read-line stream)))

(format t "~a~%" (main "input"))
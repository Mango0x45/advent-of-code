#!/usr/bin/sbcl --script

(load "heap.lisp")

(defstruct dnode
  (x    nil :type integer)
  (y    nil :type integer)
  (dir  nil :type integer)
  (seen nil :type list))

(defun main (filename)
  (multiple-value-call #'dijkstra (parse-maze filename)))

(defun dijkstra (maze beg end)
  (let* ((directions #2A((0 -1) (+1 0) (0 +1) (-1 0)))
         (cost-table (make-hash-table :test #'dnode=))
         (to-visit (heap:make-heap :priority-function #'cdr))
         (lowest-score most-positive-fixnum)
         seen-tiles)
    (flet ((get-cost (node) (or (gethash node cost-table)
                                most-positive-fixnum)))
      (heap:enqueue (cons (make-dnode :x (car beg) :y (cdr beg)
                                      :dir 1 :seen (list beg))
                          0)
                    to-visit)
      (loop
        (let* ((pair (heap:dequeue to-visit))
               (node (car pair))
               (cost (cdr pair))
               (dir  (dnode-dir node))
               (seen (dnode-seen node)))
          (when (> cost lowest-score)
            ;; START PART 1
            (return-from dijkstra cost)
            ;; END PART 1 START PART 2
            (return-from dijkstra (length seen-tiles))
            ;; END PART 2
            )
          (unless (< (get-cost node) cost)
            (setf (gethash node cost-table) cost)
            (dolist (d (list dir (mod (1- dir) 4) (mod (1+ dir) 4)))
              (let* ((x (+ (dnode-x node) (aref directions d 0)))
                     (y (+ (dnode-y node) (aref directions d 1)))
                     (nseen (adjoin (cons x y) seen :test #'equal))
                     (nnode (make-dnode :x x :y y :dir d :seen nseen))
                     (ncost (+ cost (if (= d dir) 1 1001))))
                (when (and (<= ncost (get-cost nnode))
                           (dnode-pos-valid-p nnode maze))
                  (if (equal (cons x y) end)
                      (setq lowest-score ncost
                            seen-tiles (union seen-tiles nseen :test #'equal))
                      (progn
                        (setf (gethash nnode cost-table) ncost)
                        (heap:enqueue (cons nnode ncost) to-visit))))))))))))

(defun dnode= (x y)
  (and (= (dnode-x x) (dnode-x y))
       (= (dnode-y x) (dnode-y y))
       (= (dnode-dir x) (dnode-dir y))))

(defun sxhash-dnode (node)
  (sxhash (list (dnode-x node)
                (dnode-y node)
                (dnode-dir node))))

(define-hash-table-test dnode= sxhash-dnode)

(defun dnode-pos-valid-p (node maze)
  (destructuring-bind (my mx) (array-dimensions maze)
    (let ((nx (dnode-x node))
          (ny (dnode-y node)))
      (and (< -1 nx mx)
           (< -1 ny my)
           (char/= #\# (aref maze ny nx))))))

(defun parse-maze (filename)
  (with-open-file (stream filename)
    (multiple-value-bind (lines line-count beg end)
        (loop with beg = 0
              with end = 0
              for line = (read-line stream nil)
              for line-count upfrom 0
              while line
              for s-pos = (position #\S line)
              for e-pos = (position #\E line)
              if s-pos
                do (setq beg (cons s-pos line-count))
              if e-pos
                do (setq end (cons e-pos line-count))
              collect line into lines
              finally (return (values lines line-count beg end)))
      (values
       (make-array (list line-count (length (first lines)))
                   :element-type 'character
                   :initial-contents lines)
       beg end))))

(format t "~d~%" (main "input"))
(defpackage #:heap
  (:use :cl)
  (:export :dequeue :emptyp :enqueue :make-heap))

(in-package #:heap)

(defun make-heap (&key (priority-function #'identity))
  (cons (make-array 0 :fill-pointer t) priority-function))

(defun enqueue (item heap)
  (let ((heap-vec (car heap)))
    (vector-push-extend item heap-vec)
    (%sift-down heap 0 (1- (length heap-vec)))))

(defun dequeue (heap)
  (let* ((heap-vec (car heap))
         (last-item (vector-pop heap-vec)))
    (if (zerop (length heap-vec))
        last-item
        (prog1
            (aref heap-vec 0)
          (setf (aref heap-vec 0) last-item)
          (%sift-up heap 0)))))

(defun emptyp (heap)
  (zerop (length (car heap))))

(defun %sift-down (heap start-pos pos)
  (let* ((heap-vec (car heap))
         (heap-fn (cdr heap))
         (new-item (aref heap-vec pos)))
    (loop while (> pos start-pos) do
      (let* ((parent-pos (ash (1- pos) -1))
             (parent (aref heap-vec parent-pos)))
        (unless (< (funcall heap-fn new-item)
                   (funcall heap-fn parent))
          (loop-finish))
        (setf (aref heap-vec pos) parent)
        (setq pos parent-pos)))
    (setf (aref heap-vec pos) new-item)))

(defun %sift-up (heap pos)
  (let* ((heap-vec (car heap))
         (heap-fn (cdr heap))
         (end-pos (length heap-vec))
         (start-pos pos)
         (new-item (aref heap-vec pos))
         (child-pos (1+ (* 2 pos))))
    (loop while (< child-pos end-pos) do
      (let ((right-pos (1+ child-pos)))
        (when (and (< right-pos end-pos)
                   (>= (funcall heap-fn (aref heap-vec child-pos))
                       (funcall heap-fn (aref heap-vec right-pos))))
          (setq child-pos right-pos))
        (setf (aref heap-vec pos) (aref heap-vec child-pos))
        (setq pos child-pos
              child-pos (1+ (* 2 pos)))))
    (setf (aref heap-vec pos) new-item)
    (%sift-down heap start-pos pos)))
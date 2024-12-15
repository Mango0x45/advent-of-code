#!/usr/bin/sbcl --script

(defparameter *map*       nil)
(defparameter *moves*     nil)
(defparameter *robot-pos* nil)

(defun main (filename)
  (parse-input filename)
  (mapc #'handle-move *moves*)
  (loop with (my mx) = (array-dimensions *map*)
        for y from 0 below my
        sum (loop for x from 0 below mx
                  if (char= (aref *map* y x) #\O)
                    sum (+ x (* 100 y)))))

(defun handle-move (v⃗)
  (when (can-move-p v⃗)
    (map-setf *robot-pos* #\.)
    (setq *robot-pos* (vec2+ *robot-pos* v⃗))
    (when (char= #\O (aref-vec2 *map* *robot-pos*))
      (loop for pos = *robot-pos* then (vec2+ v⃗ pos)
            if (char= #\. (aref-vec2 *map* pos))
              do (map-setf pos #\O)
                 (loop-finish)))
    (map-setf *robot-pos* #\@)))

(defun can-move-p (v⃗)
  (let ((obstacles (loop for pos = *robot-pos* then (vec2+ v⃗ pos)
                         while (in-map-bounds-p pos)
                         collect (aref-vec2 *map* pos))))
    (loop for obs in obstacles
          until (char= obs #\#)
          if (char= obs #\.)
            return t)))

(defun in-map-bounds-p (pos)
  (destructuring-bind (y x) (array-dimensions *map*)
    (and (< -1 (car pos) x)
         (< -1 (cdr pos) y))))

(defun vec2+ (v⃗ u⃗)
  (cons (+ (car v⃗) (car u⃗))
        (+ (cdr v⃗) (cdr u⃗))))

(defun aref-vec2 (array v⃗)
  (aref array (cdr v⃗) (car v⃗)))

(defun map-setf (pos val)
  (setf (aref *map* (cdr pos) (car pos)) val))

;;; Parsing

(defun parse-input (filename)
  (with-open-file (stream filename)
    (let ((contents (make-string (file-length stream))))
      (read-sequence contents stream)
      (destructuring-bind (map moves)
          (split-string contents (format nil "~%~%"))
        (multiple-value-bind (map start-pos) (parse-map map)
          (setq *map* map
                *moves* (parse-moves moves)
                *robot-pos* start-pos))))))

(defun parse-map (string)
  (let* ((first-newline (position #\Newline string))
         (line-length (1+ first-newline))
         (line-count (/ (1+ (length string)) line-length))
         (map (make-array (list line-count first-newline)
                          :element-type 'character))
         start-pos)
    (dotimes (y line-count)
      (loop with start = (* y line-length)
            for char across (subseq string start (+ start first-newline))
            for x upfrom 0
            if (char= char #\@)
              do (setq start-pos (cons x y))
            do (setf (aref map y x) char)))
    (values map start-pos)))

(defun parse-moves (string)
  (loop for char across string
        unless (char= char #\Newline)
          collect (ecase char
                    (#\^ '(0 . -1))
                    (#\v '(0 . +1))
                    (#\< '(-1 . 0))
                    (#\> '(+1 . 0)))))

(defun split-string (string delimiter)
  (loop with delimiter-length = (length delimiter)
        for end = (search delimiter string)
        unless (eq end 0)
          collect (subseq string 0 end) into parts
        unless end
          return parts
        do (setq string (subseq string (+ end delimiter-length)))))

(format t "~d~%" (main "input"))
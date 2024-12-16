#!/usr/bin/sbcl --script

(defun usage (&optional option)
  (when option
    (format *error-output* "puzzle-2.lisp: invalid option -- `~a'~%" option))
  (format *error-output* "Usage: puzzle-2.lisp [-s]~%")
  (quit :unix-status 1))

(defparameter *map*       nil)
(defparameter *moves*     nil)
(defparameter *robot-pos* nil)

(defparameter *sflag*
  (case (length *posix-argv*)
    (1
     nil)
    (2
     (let ((arg (nth 1 *posix-argv*)))
       (unless (or (string= arg "-s")
                   (string= arg "--simulate"))
         (usage arg)))
     t)
    (otherwise
     (usage (nth 2 *posix-argv*)))))

(defun main (filename)
  (parse-input filename)
  (if *sflag*
      (loop for move in *moves*
            do (print-map)
               (sleep 0.0001)
               (handle-move move)
            finally (print-map))
      (mapc #'handle-move *moves*))
  (loop with (my mx) = (array-dimensions *map*)
        for y from 0 below my
        sum (loop for x from 0 below mx
                  if (box-at-pos-p (cons x y))
                    sum (+ x (* 100 y)))))

(defun print-map ()
  (format t "~C[2J" #\Esc)
  (loop with (my mx) = (array-dimensions *map*)
        for y from 0 below my
        append (loop for x from 0 below mx
                     append (ecase (aref *map* y x)
                              (#\@ '(#\Esc #\[ #\9 #\2 #\m #\@ #\Esc #\[ #\m))
                              (#\# '(#\Esc #\[ #\9 #\1 #\m #\# #\Esc #\[ #\m))
                              (#\. '(#\.))
                              (#\[ '(#\Esc #\[ #\3 #\4 #\m #\[ #\Esc #\[ #\m))
                              (#\] '(#\Esc #\[ #\3 #\4 #\m #\] #\Esc #\[ #\m))))
          into string
        collect #\Newline into string
        finally (format t "~a" (coerce string 'string))))

(defun handle-move (v⃗)
  (when (can-move-p v⃗)
    (map-setf *robot-pos* #\.)
    (setq *robot-pos* (vec2+ *robot-pos* v⃗))
    (let ((dest-char (aref-vec2 *map* *robot-pos*)))
      (case dest-char
        (#\[ (handle-box-move *robot-pos* v⃗))
        (#\] (handle-box-move (left-of *robot-pos*) v⃗))))
    (map-setf *robot-pos* #\@)))

(defun handle-box-move (pos v⃗)
  (cond
    ((equal v⃗ '(+1 . 0))
     (let ((next-box-pos (right-of pos 2)))
       (when (box-at-pos-p next-box-pos)
         (handle-box-move next-box-pos v⃗)))
     (map-setf (right-of pos 1) #\[)
     (map-setf (right-of pos 2) #\]))
    ((equal v⃗ '(-1 . 0))
     (let ((next-box-pos (left-of pos 2)))
       (when (box-at-pos-p next-box-pos)
         (handle-box-move next-box-pos v⃗)))
     (map-setf pos #\])
     (map-setf (left-of pos) #\[))
    (:else                 ; (or (equal v⃗ '(0 . +1)) (equal v⃗ '(0 . -1)))
     (let* ((dy (cdr v⃗))
            (charl (aref-vec2 *map* (vec2+ pos (cons 0 dy))))
            (charr (aref-vec2 *map* (vec2+ pos (cons 1 dy)))))
       (when (char= charl #\[)
         (handle-box-move (vec2+ pos v⃗) v⃗))
       (when (char= charl #\])
         (handle-box-move (vec2+ pos (cons -1 dy)) v⃗))
       (when (char= charr #\[)
         (handle-box-move (vec2+ pos (cons +1 dy)) v⃗))
       (map-setf pos #\.)
       (map-setf (right-of pos) #\.)
       (map-setf (vec2+ pos (cons 0 dy)) #\[)
       (map-setf (vec2+ pos (cons 1 dy)) #\])))))

(defun box-at-pos-p (pos)
  (char= (aref-vec2 *map* pos) #\[))

(defun can-move-p (v⃗)
  (let ((pos (vec2+ *robot-pos* v⃗)))
    (ecase (aref-vec2 *map* pos)
      (#\. t)
      (#\# nil)
      (#\[ (can-move-box-p pos v⃗))
      (#\] (can-move-box-p (left-of pos) v⃗)))))

(defun can-move-box-p (pos v⃗)
  (cond
    ((equal v⃗ '(1 . 0))
     (let ((next-box-pos (right-of pos 2)))
       (ecase (aref-vec2 *map* next-box-pos)
         (#\. t)
         (#\# nil)
         (#\[ (can-move-box-p next-box-pos v⃗)))))
    ((equal v⃗ '(-1 . 0))
     (ecase (aref-vec2 *map* (left-of pos))
       (#\. t)
       (#\# nil)
       (#\[
        (print *map*)
        (quit))
       (#\] (can-move-box-p (left-of pos 2) v⃗))))
    (:else                 ; (or (equal v⃗ '(0 . +1)) (equal v⃗ '(0 . -1)))
     (let* ((dy (cdr v⃗))
            (charl (aref-vec2 *map* (vec2+ pos (cons 0 dy))))
            (charr (aref-vec2 *map* (vec2+ pos (cons 1 dy)))))
       (cond ((char= #\. charl charr)
              t)
             ((or (char= #\# charl)
                  (char= #\# charr))
              nil)
             ((char= #\[ charl)
              (can-move-box-p (vec2+ pos v⃗) v⃗))
             (:else            ; (or (char= #\] charl) (char= #\[ charr))
              (and (or (char/= #\] charl)
                       (can-move-box-p (vec2+ pos (cons -1 dy)) v⃗))
                   (or (char/= #\[ charr)
                       (can-move-box-p (vec2+ pos (cons +1 dy)) v⃗)))))))))

(defun in-map-bounds-p (pos)
  (destructuring-bind (y x) (array-dimensions *map*)
    (and (< -1 (car pos) x)
         (< -1 (cdr pos) y))))

(defun aref-vec2 (array v⃗)
  (aref array (cdr v⃗) (car v⃗)))

(defun map-setf (pos val)
  (setf (aref *map* (cdr pos) (car pos)) val))

;;; 2D Vectors

(defun vec2+ (v⃗ u⃗)
  (cons (+ (car v⃗) (car u⃗))
        (+ (cdr v⃗) (cdr u⃗))))

(defun left-of (v⃗ &optional (n 1))
  (vec2+ v⃗ (cons (- n) 0)))

(defun right-of (v⃗ &optional (n 1))
  (vec2+ v⃗ (cons n 0)))

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
         (map (make-array (list line-count (* 2 first-newline))
                          :element-type 'character))
         start-pos)
    (dotimes (y line-count)
      (loop with start = (* y line-length)
            for char across (subseq string start (+ start first-newline))
            for x = 0 then (+ x 2)
            do (ecase char
                 (#\# (setf (aref map y (+ 0 x)) #\#
                            (aref map y (+ 1 x)) #\#))
                 (#\O (setf (aref map y (+ 0 x)) #\[
                            (aref map y (+ 1 x)) #\]))
                 (#\. (setf (aref map y (+ 0 x)) #\.
                            (aref map y (+ 1 x)) #\.))
                 (#\@ (setf (aref map y (+ 0 x)) #\@
                            (aref map y (+ 1 x)) #\.
                            start-pos (cons x y))))))
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
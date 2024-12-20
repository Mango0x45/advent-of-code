;;; -*- lexical-binding: t; -*-

(defun main (filename)
  (with-temp-buffer
    (insert-file-contents-literally filename)
    (let* ((width 25)
           (height 6)
           (area (* width height))
           (min-zeros most-positive-fixnum)
           answer)
      (while (not (eobp))
        (let* ((end (+ (point) area))
               (string (buffer-substring (point) end))
               (zeros (seq-count (make-= ?0) string)))
          (when (< zeros min-zeros)
            (setq min-zeros zeros
                  answer (* (seq-count (make-= ?1) string)
                            (seq-count (make-= ?2) string))))
          (goto-char end)))
      answer)))

(defun make-= (x)
  (lambda (y) (= x y)))

(message "%d" (main "input"))
;;; -*- lexical-binding: t; -*-

(defun main (filename)
  (let* ((string (with-temp-buffer
                   (insert-file-contents-literally filename)
                   (buffer-substring-no-properties (point-min) (point-max))))
         (width 25)
         (height 6)
         (area (* width height))
         (image (thread-last
                  (seq-partition string area)
                  (apply #'seq-mapn #'first-visible-pixel)
                  (apply #'string))))
    (switch-to-buffer "*Advent of Code — 2019 Day 8*")
    (save-excursion
      (insert image))
    (while (not (eobp))
      (goto-char (+ (point) width))
      (insert ?\n))))

(defun first-visible-pixel (&rest pixels)
  (pcase (seq-find (lambda (x) (/= x ?2)) pixels ?2)
    (?0 ?.)
    (?1 ?#)
    (?2 32)))

(main "input")
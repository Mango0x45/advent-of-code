(defun solve (input-file)
  (let ((nums (with-temp-buffer
                (insert-file-contents-literally input-file)
                (goto-char (point-min))
                (save-excursion
                  (insert ?\[)
                  (goto-char (point-max))
                  (insert ?\]))
                (read (current-buffer)))))
    (cl-loop for i from 0 below (length nums)
             for x = (aref nums i)
             if (cl-evenp i)
               collect x into xs
             else
               collect x into ys
             finally return (thread-last
                              (seq-mapn #'- (sort xs) (sort ys))
                              (mapcar #'abs)
                              (apply #'+)))))

(message "%d" (solve "input"))
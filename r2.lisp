;;;; r2.lisp

(in-package #:r2)

(defvar *file* *error-output*)

(defvar *PS1* "<<< ")
(defvar *PS2* "... ")

(defmacro prog3 (a b c &rest r)
  `(progn
     ,a
     ,b
     (let ((___3 ,c))
       ,@r
       ___3)))
	 
(defun cli ()
  (format *file* ">>> Hi!~%")
  (loop
    (handler-case
	(format *file* ">>> ~a~%"
		(prog3
		  (format *file* *PS1*)
		  (finish-output *file*)
		  (eval (read))
		  (fresh-line)
		  (finish-output)))
      (end-of-file (c)
	(format *file* "(uiop:quit)~%>>> Bye~%")
	(return-from cli c))
      (t (c)
	(format t "Condition:[~s] ~a" c c)))))

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

(defun repl (&aux x)
  (loop
    (handler-case
	(format *file* ">>> ~a~%"
		(progn
		  (format *file* *PS1*)
		  (finish-output *file*)
		  (setf x (eval (read)))
		  (fresh-line)
		  (finish-output)
		  x))
      (end-of-file ()
	(return-from repl x))
      (t (c)
	(format t "Condition:[~s] ~a" c c)))))

(defun cli ()
  (format *file* ">>> Hi!~%")
  (repl)
  (format *file* "(quit)~%>>> Bye!~%")
  )

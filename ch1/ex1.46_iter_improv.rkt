#lang sicp

;; First part of the exercise.
(define (square x)
  (* x x))

(define (average x y)
  (/ (+ x y) 2))

(define (iterative-improve guess-good? improve-guess)
  (define (iter guess)
    (if (guess-good? guess)
	guess
	(iter (improve-guess guess))))
  iter)

(define tolerance 0.00001)

(define (sqrt x)
  ((iterative-improve
    (lambda (guess) (< (abs (- (square guess) x)) tolerance))
    (lambda (guess) (average guess (/ x guess))))
   1.0))

(sqrt 4)

;; Second part: fixed point computation
(define (fixed-point f first-guess)
  ((iterative-improve
    (lambda (guess) (< (abs (- guess (f guess))) tolerance))
    f)
   first-guess))

(fixed-point sqrt 2.0)
(fixed-point cos 1.0)

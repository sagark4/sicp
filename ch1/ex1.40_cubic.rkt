#lang sicp

;; Fixed point computation
(define tolerance 0.00001)
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ([next (f guess)]) (if (close-enough? guess next) next (try next))))
  (try first-guess))

(define (sqrt x)
  (fixed-point (lambda (y) (average y (/ x y))) 1.0))

(define (average a b)
  (/ (+ a b) 2))

(define (average-damp f)
  (lambda (x) (average x (f x))))

(define (sqrt-reformulated x)
  (fixed-point (average-damp (lambda (y) (/ x y))) 1.0))

;; Newton's method
(define (deriv g)
  (lambda (x) (/ (- (g (+ x dx)) (g x)) dx)))

(define dx 0.00001)

(define (newton-transform g)
  (lambda (x) (- x (/ (g x) ((deriv g) x)))))

(define (newtons-method g guess)
  (fixed-point (newton-transform g) guess))

(define (sqrt-newton x)
  (newtons-method (lambda (y) (- (square y) x)) 1.0))

;; Further abstraction

(define (fixed-point-of-transform g transform guess)
  (fixed-point (transform g) guess))

;; Reformulating sqrt via the above abstraction
(define (sqrt-fptt x)
  (fixed-point-of-transform (lambda (y) (/ x y)) average-damp 1.0))

(define (sqrt-fptt-newton x)
  (fixed-point-of-transform (lambda (y) (- (square y) x)) newton-transform 1.0))

;; All the above code is copy-pasted from the book, and now I am ready to do the exercise.

(define (cube x)
  (* x x x))
(define (square x)
  (* x x))

(define (cubic a b c)
  (lambda (x) (+ (cube x) (* a (square x)) (* b x) c)))

(newtons-method (cubic 1 1 1) 1)

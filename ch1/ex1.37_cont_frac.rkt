#lang sicp

(define (cont-frac n d k)
  (define (cont-frac-h i)
    (if (> i k) 0 (/ (n i) (+ (d i) (cont-frac-h (+ i 1))))))
  (cont-frac-h 1))

(cont-frac (lambda (i) 1.0) (lambda (i) 1.0) 10)

(define (cont-frac-iter n d k)
  (define (cont-frac-iter-h i cur-sum)
    (if (= i 0) cur-sum (cont-frac-iter-h (- i 1) (/ (n i) (+ (d i) cur-sum)))))
  (cont-frac-iter-h k 0))

(cont-frac-iter (lambda (i) 1.0) (lambda (i) 1.0) 10)

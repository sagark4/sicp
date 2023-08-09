#lang sicp

(define (square x)
  (* x x))

(define (compose f g)
  (lambda (x) (f (g x))))

(define (repeated f n)
  (define (repeat-f acc count)
    (if (= count 0) acc (repeat-f (compose f acc) (- count 1))))
  (repeat-f f (- n 1)))

((repeated square 2) 5)

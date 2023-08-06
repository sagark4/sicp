#lang sicp

(define (accumulate combiner null-value term a next b)
  (if (> a b) null-value (combiner (term a) (accumulate combiner null-value term (next a) next b))))

(define (identity x)
  x)
(define (inc n)
  (+ n 1))
(define (sum-integers a b)
  (accumulate + 0 identity a inc b))
(sum-integers 1 10)

#lang sicp

(define (is_even n)
  (= (remainder n 2) 0))

(define (exp a b n)
  (cond
    [(= n 0) a]
    [(is_even n) (exp a (* b b) (/ n 2))]
    [else (exp (* a b) b (- n 1))]))

(exp 1 2.12 10)

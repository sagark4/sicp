#lang sicp

(define (f-rec n)
  (cond
    [(< n 3) n]
    [else (+ (f-rec (- n 1)) (* 2 (f-rec (- n 2))) (* 3 (f-rec (- n 3))))]))

(define (f-iter n)
  (cond
    [(< n 3) n]
    [else (f-iter-h 0 1 2 (- n 2))]))

(define (f-iter-h a b c rem-steps)
  (if (= 0 rem-steps) c (f-iter-h b c (+ c (* 2 b) (* 3 a)) (- rem-steps 1))))

; 0 1 2 4 11 25 ...

(f-rec 4)
(f-rec 5)

(f-iter 4)
(f-iter 5)

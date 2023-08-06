#lang sicp

(define (sum term a next b)
  (if (> a b) 0 (+ (term a) (sum term (next a) next b))))

(define (simpsons f a b n)
  (define (simp-term k)
    (* (/ (- b a) (* 3 n))
       (f (+ a (* (/ (- b a) n) k)))
       (cond
         [(or (= k 0) (= k n)) 1]
         [(even? k) 2]
         [else 4])))
  (define (inc n)
    (+ n 1))
  (sum simp-term 0 inc n))

(define (square x)
  (* x x))
(define (cube x)
  (* x x x))

(simpsons square 10 11 4)
(simpsons cube 0 1 4)

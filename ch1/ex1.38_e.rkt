#lang sicp

(define (cont-frac-iter n d k)
  (define (cont-frac-iter-h i cur-sum)
    (if (= i 0) cur-sum (cont-frac-iter-h (- i 1) (/ (n i) (+ (d i) cur-sum)))))
  (cont-frac-iter-h k 0))

(define (e k)
  (+ 2
     (cont-frac-iter (lambda (i) 1.0)
                     (lambda (i)
                       (cond
                         [(= i 1) 1]
                         [(= i 2) 2]
                         [(not (= (remainder i 3) 2)) 1]
                         [else (* 2 (/ (+ i 1) 3))]))
                     k)))

(e 100)

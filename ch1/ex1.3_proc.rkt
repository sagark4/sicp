#lang sicp

(define (square a)
  (* a a))

(define (sos a b)
  (+ (square a) (square b)))

(define (sos-max2 a b c)
  (cond ((and (< a b) (< a c)) (sos b c))
        ((and (< b c)) (sos a c))
        (else (sos a b))))

(if (= 0 (sos-max2 0 0 0)) (display "Passed for (sos-max2 0 0 0)\n") (display "Failed for (sos-max2 0 0 0)\n"))
(if (= 1 (sos-max2 0 0 1)) (display "Passed for (sos-max2 0 0 1)\n") (display "Failed for (sos-max2 0 0 1)\n"))
(if (= 4 (sos-max2 0 0 2)) (display "Passed for (sos-max2 0 0 2)\n") (display "Failed for (sos-max2 0 0 2)\n"))
(if (= 1 (sos-max2 0 1 0)) (display "Passed for (sos-max2 0 1 0)\n") (display "Failed for (sos-max2 0 1 0)\n"))
(if (= 2 (sos-max2 0 1 1)) (display "Passed for (sos-max2 0 1 1)\n") (display "Failed for (sos-max2 0 1 1)\n"))
(if (= 5 (sos-max2 0 1 2)) (display "Passed for (sos-max2 0 1 2)\n") (display "Failed for (sos-max2 0 1 2)\n"))
(if (= 4 (sos-max2 0 2 0)) (display "Passed for (sos-max2 0 2 0)\n") (display "Failed for (sos-max2 0 2 0)\n"))
(if (= 5 (sos-max2 0 2 1)) (display "Passed for (sos-max2 0 2 1)\n") (display "Failed for (sos-max2 0 2 1)\n"))
(if (= 8 (sos-max2 0 2 2)) (display "Passed for (sos-max2 0 2 2)\n") (display "Failed for (sos-max2 0 2 2)\n"))
(if (= 1 (sos-max2 1 0 0)) (display "Passed for (sos-max2 1 0 0)\n") (display "Failed for (sos-max2 1 0 0)\n"))
(if (= 2 (sos-max2 1 0 1)) (display "Passed for (sos-max2 1 0 1)\n") (display "Failed for (sos-max2 1 0 1)\n"))
(if (= 5 (sos-max2 1 0 2)) (display "Passed for (sos-max2 1 0 2)\n") (display "Failed for (sos-max2 1 0 2)\n"))
(if (= 2 (sos-max2 1 1 0)) (display "Passed for (sos-max2 1 1 0)\n") (display "Failed for (sos-max2 1 1 0)\n"))
(if (= 2 (sos-max2 1 1 1)) (display "Passed for (sos-max2 1 1 1)\n") (display "Failed for (sos-max2 1 1 1)\n"))
(if (= 5 (sos-max2 1 1 2)) (display "Passed for (sos-max2 1 1 2)\n") (display "Failed for (sos-max2 1 1 2)\n"))
(if (= 5 (sos-max2 1 2 0)) (display "Passed for (sos-max2 1 2 0)\n") (display "Failed for (sos-max2 1 2 0)\n"))
(if (= 5 (sos-max2 1 2 1)) (display "Passed for (sos-max2 1 2 1)\n") (display "Failed for (sos-max2 1 2 1)\n"))
(if (= 8 (sos-max2 1 2 2)) (display "Passed for (sos-max2 1 2 2)\n") (display "Failed for (sos-max2 1 2 2)\n"))
(if (= 4 (sos-max2 2 0 0)) (display "Passed for (sos-max2 2 0 0)\n") (display "Failed for (sos-max2 2 0 0)\n"))
(if (= 5 (sos-max2 2 0 1)) (display "Passed for (sos-max2 2 0 1)\n") (display "Failed for (sos-max2 2 0 1)\n"))
(if (= 8 (sos-max2 2 0 2)) (display "Passed for (sos-max2 2 0 2)\n") (display "Failed for (sos-max2 2 0 2)\n"))
(if (= 5 (sos-max2 2 1 0)) (display "Passed for (sos-max2 2 1 0)\n") (display "Failed for (sos-max2 2 1 0)\n"))
(if (= 5 (sos-max2 2 1 1)) (display "Passed for (sos-max2 2 1 1)\n") (display "Failed for (sos-max2 2 1 1)\n"))
(if (= 8 (sos-max2 2 1 2)) (display "Passed for (sos-max2 2 1 2)\n") (display "Failed for (sos-max2 2 1 2)\n"))
(if (= 8 (sos-max2 2 2 0)) (display "Passed for (sos-max2 2 2 0)\n") (display "Failed for (sos-max2 2 2 0)\n"))
(if (= 8 (sos-max2 2 2 1)) (display "Passed for (sos-max2 2 2 1)\n") (display "Failed for (sos-max2 2 2 1)\n"))
(if (= 8 (sos-max2 2 2 2)) (display "Passed for (sos-max2 2 2 2)\n") (display "Failed for (sos-max2 2 2 2)\n"))
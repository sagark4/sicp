# Structure and Interpretation of Computer Programs

by Abelson, Sussman, and Sussman, second edition (in Scheme)

I would add my notes/summaries in this readme. The repo is for exercises.

# Chapter 1. Building Abstractions with Procedures

Lisp seems like the minimalist language with emphasis on symbol
manipulation that is approriate for learning about computation. The
dialect _Scheme_ is used. I am planning to use the same. It has
interpreter and we can also write a script.

## 1.1 The Elements of Programming

* Primitive expressions
* Combining expressions
* Abstractions via compound procedures

Summary like notes

* Prefix notation: `(/ 10 5)`
* Variables and values: e.g. `(define size 2)`
* Procedure definitions: `(define (square x) (* x x))`
* The substitution model
  * The _applicative order_: first evaluate the operator, then operands, then apply. This is the order used by the interpreter.
  * The _normal order_: fully expand, then evaluate.
    #### Conditional expressions and predicates

```scheme
(define (abs x)
  (cond ((> x 0) x)
        ((= x 0) 0)
	((< x 0) (- x))))
```

or with an `else`

```scheme
(define (abs x)
  (cond ((< x 0) (-x))
  	(else x)))
```

**`cond` is short-circuiting!**

Using `if`

```scheme
(define (abs x)
  (if (< x 0)
      (- x)
      x))
```

Also `and`, `or`, and `not` can be used: `(and (< x 5) (> y 20) (= z 3))`

## Exercises

Exercises 1.1 and 1.2 skipped.

### Exercise 1.3
Sum of squares of two largest numbers from given three numbers.
```scheme
(define (square a)
  (* a a))

(define (sos a b)
  (+ (square a) (square b)))

(define (sos-max2 a b c)
  (cond
    ((and (< a b) (< a c)) (sos b c))
    ((and (< b c)) (sos a c))
    (else (sos a b))))
```

Exercise 1.4 is skipped.

### Exercise 1.5:

```scheme
(define (p)
  (p))

(define (test x y)
  (if (= x 0) (0) (y)))

(test 0 (p))
```

* Since normal order delays evaluation of operands, `(p)` will not be evaluated, which is basically an infinite loop. But the applicative order (the default) will cause an infinite loop.

### Exercise 1.6

Demonstrates that `if` is short-circuited, whereas a procedure-call is not.

### Exercise 1.7

Instead of stopping when the guess is close in the `sqrt` algorithm, asks to stop when the change in guess is a small fraction of the guess.

### Exercise 1.8

Using Newton's method for cube root.  Should be straightforward, so skipped.

### 1.1.8 Procedures as Black-Box Abstractions

- Essentially discussing procedures as algorithms using subproblems.
- Discussion on variable binding, local variables, scope, etc.
- **Local procedures!** Nesting of definitions is called _block structure_.
  - **Lexical scoping**: free variables in a procedure refer to the enclosing scope (cf. Crafting Interpreters).
- The idea of **block structure** originated in `Algol 60`.

## 1.2 Procedures and the Processes They Generate

> A procedure is a pattern for the _local evolution_ of a computational process.

### 1.2.1 Linear Recursion and Iteration

The following is recursive, because the return value of the recursive call is used to compute something before returning.
```scheme
(define (factorial n)
  (if (= n 1)
      1
	  (* n (factorial (- n 1)))))
```

But the following returns directly the value of the recursive call:
```scheme
(define (factorial n)
  (fact-iter 1 1 n))

(define (fact-iter product counter max-count)
  (if (> counter max-count)
      product
      (fact-iter (* product counter)
                 (+ counter 1)
                 max-count)))
```

Therefore, it is iterative.  The language implementation that implements above procedure in constant space is called _tail recursive_.

### Exercise 1.9

Demonstrates how processes evolve.

### Exercise 1.10

Ackermann's function.

### Exercise 1.11

A simple function to compute recursively and iteratively.

```scheme
(define (f-rec n)
  (cond
    ((< n 3) n)
    (else (+ (f-rec (- n 1)) (* 2 (f-rec (- n 2))) (* 3 (f-rec (- n 3)))))))

(define (f-iter n)
  (cond
    ((< n 3) n)
    (else (f-iter-h 0 1 2 (- n 2)))))

(define (f-iter-h a b c rem-steps)
  (if (= 0 rem-steps) c (f-iter-h b c (+ c (* 2 b) (* 3 a)) (- rem-steps 1))))
```

Exercise 1.12 and 1.13 skipped.

### 1.2.2 Tree Recursion

Fibonacci, recursive and iterative.

### 1.2.3 Orders of Growth

Big-O notation.

### Exercises 1.14 and 1.15 skipped (on orders of growth).

### 1.2.4 Exponentiation

Algorithm using the following relation: $b^n = (b^{n/2})^2$ if $n$ is even, and $b^n = b\cdot b^{n-1}$ otherwise.

### Exercise 1.16

I remember I was completely stumped by this exercise, because I did not really understand the question.  But as soon as I did, I solved it.  Apparently, the iterative solution with two calls is also tail-recursive according to [https://sicp-solutions.net/post/sicp-solution-exercise-1-16/](https://sicp-solutions.net/post/sicp-solution-exercise-1-16/).

### Exercises 1.17 and 1.18

Just implementation exercise for multiplication, equivalent to exponentiation.  Skipped.

### Exercises 1.19

This is Fibonacci using application of the specific Fibonacci transformation $n$ times.  Since this is a special case of $n$th power of a matrix, I thought I'd implement the general matrix power, but without a complex data structure, it got out of hand quickly, so just filled in the gaps in the given exercise.

```scheme
(define (fib n)
  (fib-iter 1 0 0 1 n))
(define (fib-iter a b p q count)
  (cond
    ((= count 0) b)
    ((even? count)
     (fib-iter a
               b
               ; compute p ′
               ; compute q ′
               (+ (* p p) (* q q))
               (+ (* 2 p q) (* q q))
               (/ count 2)))
    (else (fib-iter (+ (* b q) (* a q) (* a p)) (+ (* b p) (* a q)) p q (- count 1)))))
```

### 1.2.5 on GCD and 1.2.6 on primality skipped (also Exercises 1.21 to 1.28)

## 1.3 Formulating Abstractions with Higher-Order Procedures

Basically discussing how functions can be passed around.

### Exercise 1.29

Simpson's rule for integration.

```scheme
(define (simpsons f a b n)
  (define h (/ (- b a) n))
  (define (simp-term k)
    (* (/ h 3) (f (+ a (* h k)))
       (cond ((or (= k 0) (= k n)) 1)
	     ((even? k) 2)
	     (else 4))))
  (define (inc n) (+ n 1))
  (sum simp-term 0 inc n))
```

### Exercises 1.30
Filling in blanks to make the earlier `sum` procedure iterative.

```scheme
(define (sum term a next b)
  (define (iter a result)
    (if (> a b)
	result
	(iter (next a) (+ result (term a)))))
  (iter a 0))
```

Exercise 1.31 skipped


## Exercise 1.32

Generalizing the `sum` procedure even further.  (Only partial attempt.)

```scheme
(define (accumulate combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a) (accumulate combiner null-value term (next a) next b))))
(define (identity x) x)
(define (inc n) (+ n 1))
(define (sum-integers a b)
  (accumulate + 0 identity a inc b))
```
Exercise 1.33 skipped.

### 1.3.2 Constructing Procedures Using `Lambda`

Lambdas are basically anonymous procedures:

```scheme
(lambda (x) (* x x))
```

You can define a lambda and immediately apply it, but there is a special form for that called `let`.  E.g., the following function computes $f(x) = (1+x)^2$.

```scheme
(define (f x)
  (let ((y (+ 1 x)))
    (* y y)))
```

**Note** that the `let` is just syntactic sugar for the immediately applied lambda.  Which means

- the variables are bound locally, and
- the variables' values are computed outside the `let`, i.e., if you redefine a variable, say `x`, inside let, then in the variable definitions, on the RHS, `x` would still refer to the outer scope.  A concrete example:

```scheme
(define x 42)
(define (f)
  (let ((x 3) (y x))
    (+ x y)))
(f)
```
outputs `45`.

**NOTE** apparently, internal definitions are subtle and using them with procedures is okay for time being.  We should use `let` instead of `define` for local variables.

### Exercise 1.34

```scheme
(define (f g)
  (g 2))

(f f)
```
This will try to call `2` as a procedure and fail.

Exercises 1.35 and 1.36 skipped.

### Exercise 1.37

This was actually straightforward: this involves computing continued fractions iteratively and recursively.

```scheme
(define (cont-frac n d k)
  (define (cont-frac-h i)
    (if (> i k)
	0
	(/ (n i) (+ (d i) (cont-frac-h (+ i 1))))))
  (cont-frac-h 1))

(define (cont-frac-iter n d k)
  (define (cont-frac-iter-h i cur-sum)
    (if (= i 0)
	cur-sum
	(cont-frac-iter-h (- i 1) (/ (n i) (+ (d i) cur-sum)))))
  (cont-frac-iter-h k 0))
```

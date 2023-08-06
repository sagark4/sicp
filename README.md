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

# Structure and Interpretation of Computer Programs
by Abelson, Sussman, and Sussman, second edition (in Scheme)

I would add my notes/summaries in this readme.  The repo is for exercises.

## Chapter 1. Building Abstractions with Procedures

Lisp seems like the minimalist language with emphasis on symbol
manipulation that is approriate for learning about computation.  The
dialect _Scheme_ is used.  I am planning to use the same.  It has
interpreter and we can also write a script.

### 1.1 The Elements of Programming

 - Primitive expressions
 - Combining expressions
 - Abstractions via compound procedures

Summary like notes

 - Prefix notation: `(/ 10 5)`
 - Variables and values: e.g. `(define size 2)`
 - Procedure definitions: `(define (square x) (* x x))`
 - The substitution model
   - The _applicative order_: first evaluate the operator, then operands, then apply.  This is the order used by the interpreter.
   - The _normal order_: fully expand, then evaluate.
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

 
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

### 1.3.3 Procedures as General Methods

More examples of procedures as algorithms: 

- finding fixed points of functions (i.e., given $f(x)$ and an initial guess, find $a$ s.t. $f(a) = a$)
- finding zeros of functions (i.e., given $f(x)$ and two numbers with opposite signs for the $f$ value, find $a$ s.t. $f(a) = 0$)

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

### Exercise 1.38

Trivial using the `remainder` procedure.

```scheme
(define (e k)
  (+ 2 (cont-frac-iter (lambda (i) 1.0)
		       (lambda (i)
			 (cond ((= i 1) 1)
			       ((= i 2) 2)
			       ((not (= (remainder i 3) 2)) 1)
			       (else (* 2 (/ (+ i 1) 3)))
			       ))
		       k)))
```

Exercise 1.39 skipped; similar in spirit to earlier ones.

### 1.3.4 Procedures as Return Values

Demonstrates the usefulness of the ability to return procedures via Newton's method that finds a zero of $g(x)$ by computing a fixed point of $f(x) = x - g(x)/g'(x)$.

#### Abstractions and first-class procedures

> Some of the "rights and privileges" of the first-class elements of a programming language are

ability to be 

- named by variables, 
- passed as arguments, 
- returned as results, and 
- included in a data structure

In `Lisp`, procedures are first class.

### Exercise 1.40

```scheme
(define (cube x) (* x x x))
(define (square x) (* x x))

(define (cubic a b c)
  (lambda (x) (+ (cube x) (* a (square x)) (* b x) c)))
```

### Exercise 1.41

```scheme
(define (double f) (lambda (x) (f (f x))))
```

The result of `(((double (double double)) (lambda (x) (+ x 1))) 5)` is `21`.  (I actually guessed wrong; I thought it would be three times `double` but it's four times.)

### Exercise 1.42

```scheme
(define (compose f g) (lambda (x) (f (g x))))
```

### Exercise 1.43

```scheme
(define (repeated f n)
  (define (repeat-f acc count)
    (if (= count 0) acc (repeat-f (compose f acc) (- count 1))))
  (repeat-f f (- n 1)))
```

Exercises 1.44 and 1.45 are skipped (the ideas are quite clear to me).

### Exercise 1.46

This exercise is about returning a general function for iterative improvement.

```scheme
(define (iterative-improve guess-good? improve-guess)
  (define (iter guess)
    (if (guess-good? guess)
	guess
	(iter (improve-guess guess))))
  iter)
```
**Note**: I added parentheses around `iter` above, but that would mean a procedure call!  It kept complaining missing argument.

Then the `sqrt` procedure would be as follows:
```scheme
(define (sqrt x)
  ((iterative-improve
    (lambda (guess) (< (abs (- (square guess) x)) 0.00001))
    (lambda (guess) (average guess (/ x guess))))
   1.0))
```
Here, I missed the extra pair of parentheses around `(iterative-improve ...)`, so it was apparently interpreted as `(define (sqrt x) <something> 1.0)` and kept outputting `1.0`.

To elaborate:
```scheme
(define (f x) (lambda (n) (+ n 1)) x)
(f 3)
```
would output `3` and the following would output `4`, which is what we want.
```scheme
(define (f x) ((lambda (n) (+ n 1)) x))
(f 3)
```

And the `fixed-point` procedure would be:
```scheme
(define (fixed-point f first-guess)
  ((iterative-improve
    (lambda (guess) (< (abs (- guess (f guess))) tolerance))
    f)
   first-guess))
```

Final note for the chapter: major implementation cost of functional languages is that when returning procedures, space has to be made for free variables (even if it is not executing).

Chapter 1 done!  😀

# Chapter 2. Building Abstractions with Data

This chapter seems to be about lists mainly.  The motivation in the beginning is pretty much the same as that for object oriented languages.

## 2.1 Introduction to Data Abstraction
Again, trivial coming from OO concepts.

## Pairs: `cons`, `car`, and `cdr`

`(cons 4 42)` creates a pair with first part as `4` and second as `42`.  To extract the first part, you can use `car`, and `cdr` for the second part.

```scheme
(car (cons 4 42))
```
would output `4`.

- As you might expect, you can have `cons` of `cons`, e.g., `(cons 42 (cons 41 40))`
- Then rational number implementation with a unique representation by reducing them to lowest terms (using the GCD procedure that I skipped) is given.  I am happy to skip this part as well.
- Exercise 2.1 skipped. (It's about rational numbers.)
- Exercises 2.2 and 2.3 ask to implement data structures for line segments and rectangles.  Skipped.
- Section 2.1.3 demonstrates how one could implement `cons`, `car`, and `cdr` using procedures.
  - Exercise 2.4 is about implementing `cons` using `lambda` procedures.
  - Exercise 2.5 is about implementing `cons` (for nonnegative integers) using integers of form $2^a 3^b$.
  - TODO: Exercise 2.6 about implementing pairs using some fancy `lambda` magic.
- Section 2.1.4 is implementation of "interval arithmetic"
  - Exercises 2.7 to 2.16 are about that and are skipped.
  - One brief observation is that when you perform an arithmetic operation on two intervals where one interval is a point, then you don't lose any "information" after the operation.  Which means, when you provide a procedure on intervals, it is best to find a way to have as few of the interval arithmetic operations as possible.  This is all I'll say about this subsection.
  
## 2.2 Hierarchical Data and the Closure Property

- Talks about _box and pointer_ notation.
- _Closure_ property: when the result of a combination can be used further for the same kind of combination.
- This gives us a way to construct a _list_ using a bunch of `cons`es.

```scheme
(cons 1 (cons 2 (cons 3 (cons 4 nil))))
```
has a short-form in Scheme: `(list 1 2 3 4)`.

- `cadr` is short for `car` followed by `cdr`, i.e., `(car (cadr <something>))` is same as `(cadr <something>)`.
- `nil` is a contraction of _nihil_, which means "nothing" in Latin, which basically means empty list.
- In future, they will denote the empty list as `'()`, which will replace `nil`.
- `null?` tests whether the list is empty.  So `(null? nil)` returns true, as does `(null? '())`.
- `append` to append several lists.
- Indexing is $O(n)$.

Exercise 2.17 skipped

### Exercise 2.18

Reverse a list.

```scheme
(define (reverse lo)
  (define (reverse-h l prev)
    (if (null? l)
	prev
	(reverse-h (cdr l) (cons (car l) prev))))
  (reverse-h lo nil))
```

Incorrect first solution:
```scheme
(define (reverse l)
  (if (null? l)
      nil
      (cons (reverse (cdr l)) (car l))))
```
This attempt generated on `(list 1 2 3 4)` the output `((((() . 4) . 3) . 2) . 1)`, which is obviously not a list.

Exercise 2.19 skipped, as I skipped the "coin-change" problem section/exercises in the previous chapter on which it is based.

**Note**: The following exercise introduces the notation for accepting variable number of arguments.
`(define (f x y . z) <body>)`

### Exercise 2.20

This exercise was fun.  Compute a sublist that has the same parity as the first element (maintaining the order).

```scheme
(define (same-parity a . l)
  (define (same-parity-h li)
    (if (null? li)
	nil
	(let ((cur (car li)) (rem-list (cdr li)))
	  (if (= (remainder a 2) (remainder cur 2))
	      (cons cur (same-parity-h rem-list))
	      (same-parity-h rem-list)))))
  (cons a (same-parity-h l)))
```

`map` procedure: takes two types of arguments

- a procedure that accepts $n$ arguments followed by
- $n$ lists,

and returns a list whose $i$ th element is the procedure applied to all the $i$ th elements of the lists.

Exercise 2.21 is trivial; Exercise 2.22 is exactly the same issue I mentioned in Exercise 2.18.

### Exercise 2.23

An implementation of `for-each`.

```scheme
(define (for-each f l)
  (if (null? l)
      true
      ((lambda (_x _y) true)
       (f (car l))
       (for-each f (cdr l)))))
```

- `(cons (list 1 2) (list 3 4))` is `((1 2) 3 4)`.
- **Note** `pair?` tells whether argument is a pair.

Exercises 2.24 and 2.25 skipped; Exercise 2.26 was just mental exercise (solved correctly).

### Exercise 2.27

Deep-reverse a list.
```scheme
(define (deep-reverse lo)
  (define (deep-reverse-h l prev)
    (if (null? l)
	prev
	(deep-reverse-h (cdr l)
			(cons
			 (let ((cur (car l)))
			    (if (pair? cur)
				(deep-reverse-h cur nil)
				cur))
			 prev))))
  (deep-reverse-h lo nil))
```

### Exercise 2.28

Print leaves of the "tree" in order.  Crucial observation is that when solving the problem recursively (there are two subproblems), we cannot append the solution of the second subproblem after solving the first subproblem first due to the `nil` appearing in the end, so we have to solve the second subproblem first whose solution we need to append to the solutionof the first subproblem.  This is done by allowing a second argument to the procedure called `to-append`.

```scheme
(define (fringe lo)
  (define (fringe-h l to-append)
    (if (null? l)
	to-append
	(let ((cur (car l)) (rem-fringe (fringe-h (cdr l) to-append)))
	  (if (pair? cur)
	      (fringe-h cur rem-fringe)
	      (cons cur rem-fringe)))))
  (fringe-h lo nil))
```

Exercise 2.29 skipped (life is short).

Next mapping over trees is discussed and then exercises on that.  Exercise 2.30 is direct interpolation of the procedures given above it.

### Exercise 2.31

Almost the same as the `scale-tree` procedure from the text.
```scheme
(define (tree-map f tree)
  (map (lambda (sub-tree)
	 (if (pair? sub-tree)
	     (tree-map f sub-tree)
	     (f sub-tree)))
       tree))
```

Exercise 2.32 is skipped.

### 2.2.3 Sequences as Conventional Interfaces

This section is heavy on the functional paradigm, i.e., it motivates and gives implementation of `filter`, `accumulate`, and `enumerate` procedures and shows examples of two seemingly different algorithms implemented in very similar way using these procedures.

- `filter`, as the name suggests, filters the sequence given a predicate.
- `accumulate`, starting with a given initial value and a way to combine an element and the result of the accumulation to the sequence on the right collects the whole result.

### Exercise 2.33

Implementing `map`, `append`, and `length` using `accumulate`.

```scheme

(define (map p sequence)
  (accumulate (lambda (x y) (cons (p x) y)) nil sequence))

(define (append seq1 seq2)
  (accumulate cons seq2 seq1))

(define (length sequence)
  (accumulate (lambda (x y) (+ 1 y)) 0 sequence))
```

### Exercise 2.34

```scheme
(define (horner-eval x coefficient-sequence)
  (accumulate (lambda (this-coeff higher-terms) (+ this-coeff (* x higher-terms)))
              0
              coefficient-sequence))
```


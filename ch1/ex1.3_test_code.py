import itertools


def scheme_assert(ss, a, b, c):
    print(
        f"(if (= {ss} (sos-max2 {a} {b} {c}))"
        '(display "Passed for (sos-max2 {a} {b} {c})\\n")'
        '(display "Failed for (sos-max2 {a} {b} {c})\\n"))'
    )


for i, j, k in itertools.product(*[range(3)] * 3):
    l = [i, j, k]
    l.sort()
    ss = l[1] ** 2 + l[2] ** 2
    scheme_assert(ss, i, j, k)

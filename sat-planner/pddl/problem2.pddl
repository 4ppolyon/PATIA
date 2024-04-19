(define (problem problem02) (:domain robot)
    (:objects
        robot - robot
        r1 r2 r3 r4 r5 r6 r7 r8 r9 r10 - room
    )
    (:init
        (at robot r1)

        (next r1 r2)
        (next r2 r3)
        (next r3 r4)
        (next r3 r5)
        (next r4 r6)
        (next r5 r6)
        (next r6 r7)
        (next r7 r8)
        (next r8 r9)
        (next r9 r10)
    )
    (:goal (and
        (at robot r10)
    ))
)

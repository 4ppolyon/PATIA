(define (problem problem01) (:domain robot)
    (:objects
        robot - robot
        r1 r2 r3 r4 r5 r6 r7 - room
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
    )
    (:goal (and
        (at robot r7)
    ))
)

(define (problem h1)
    (:domain hanoi)
    (:objects
        A B C D - object
        T1 T2 T3 - tower
    )

    (:init
        (smaller C D)
        (smaller B C)
        (smaller A B)
        (ontower D T1)
        (on C D)
        (on B C)
        (on A B)
        (clear A)
        (handempty)
        (clear T2)
        (clear T3)
    )

    (:goal (and
        (ontower D T3)
        (clear T2)
        (clear T1)
        (on C D)
        (on B C)
        (on A B)
        (clear A)
    ))
)
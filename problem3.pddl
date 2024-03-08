(define (problem h1)
    (:domain hanoi)
    (:objects
        A B C - object ; the three disks
        T1 T2 T3 - tower ; the three towers
    )

    (:init
        (smaller B C) ; B is smaller than C
        (smaller A B) ; A is smaller than B
        (ontower C T1) ; C is on T1
        (on B C) ; B is on C
        (on A B) ; A is on B
        (clear A) ; A is at the top
        (handempty) ; hand is empty
        (clear T2) ; T2 is empty
        (clear T3) ; T3 is empty
    )

    (:goal (and
        (ontower C T3) ; C is on T3
        (clear T2) ; T2 is empty
        (clear T1) ; T1 is empty
        (on B C) ; B is on C
        (on A B) ; A is on B
        (clear A) ; A is at the top
    ))
)
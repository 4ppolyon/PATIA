(define (problem problem1)
    (:domain hanoi)

    ; 3 tours et 3 pièces
    ; Toutes les pièces sont sur la tour 1 et doivent aller sur la tour 3
    ; Pièces classées par taille croissante : A, B et C

    (:objects
        A B C - object
        T1 T2 T3 - tower
    )

    (:init
        (smaller B C)
        (smaller A B)
        (ontower C T1)
        (on B C)
        (on A B)
        (clear A)
        (handempty)
        (clear T2)
        (clear T3)
    )

    (:goal (and
        (ontower C T3)
        (clear T2)
        (clear T1)
        (on B C)
        (on A B)
        (clear A)
    ))
)
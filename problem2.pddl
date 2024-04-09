(define (problem problem2)
    (:domain hanoi)

    ; 3 tours et 4 pièces
    ; Toutes les pièces sont sur la tour 1 et doivent aller sur la tour 3
    ; Pièces classées par taille croissante : A, B, C et D

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
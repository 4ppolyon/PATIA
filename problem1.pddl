(define (problem problem1) (:domain BlocksWorld)

    ; Au départ tout les blocs sont posés sur la table

    ; L'objectif est d'obtenir la pile :
    ; D
    ; C
    ; B
    ; A

    (:objects D B A C - block)
    
    (:init 
        (clear C)
        (clear A)
        (clear B)
        (clear D)
        (ontable C)
        (ontable A)
        (ontable B)
        (ontable D)
        (handempty)
    )

    (:goal (AND 
        (clear D)
        (on D C)
        (on C B)
        (on B A)
        (ontable A)
    ))
)
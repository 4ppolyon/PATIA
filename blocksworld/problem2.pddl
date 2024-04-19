(define (problem problem2) (:domain BlocksWorld)

    ; Au départ il y a deux piles sur la table :
    ; Pile 1 :
    ; B
    ; A
    ; 
    ; Pile 2 :
    ; C
    ; D
    
    ; L'objectif est d'obtenir la pile :
    ; D
    ; C
    ; A
    ; B

    (:objects D B A C - block)
    (:init 
        (clear C)
        (clear B)
        (on B A)
        (on C D)
        (ontable A)
        (ontable D)
        (handempty)
    )

    (:goal (AND 
        (clear D)
        (on D C)
        (on C A)
        (on A B)
        (ontable B)
    ))
)
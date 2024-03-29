(define (domain NPuzzle)

(:requirements :strips :typing)

(:types case nombre direction
)

(:predicates
    ; Vrai pour la case vide
    (vide ?c - case)
    ; Vrai si le nombre n est sur la case c
    (sur ?n - nombre ?c - case)
    ; Vrai si la case a est adjacente à la case b dans la direction d (a vers b)
    (adjacente ?a ?b - case ?d - direction)
)

(:action deplacer
    :parameters (?a ?b - case ?d - direction ?n - nombre)
    :precondition (and (vide ?a) (sur ?n ?b) (adjacente ?a ?b ?d))
    :effect (and 
        (not (sur ?n ?b))
        (sur ?n ?a)
        (not (vide ?a))
        (vide ?b)
    )
)




)
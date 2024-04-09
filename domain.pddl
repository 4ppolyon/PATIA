(define (domain NPuzzle)

    (:requirements :strips :typing)

    (:types case nombre direction
    )

    (:predicates
        ; La case c est la case vide
        (vide ?c - case)
        ; Le nombre n est sur la case c
        (sur ?n - nombre ?c - case)
        ; La case a est adjacente à la case b dans la direction d (de a vers b)
        ; L'inverse n'est pas forcément vrai (de b vers a)
        (adjacente ?a ?b - case ?d - direction)
    )

    ; Déplace la case vide dans une direction
    ; Ce qui revient à permuter la case vide avec le nombre de la case adjacente à la case 
    ; qui est vide dans la direction souhaitée
    (:action deplacer
        :parameters (?a ?b - case ?d - direction ?n - nombre)
        :precondition (and (vide ?a) (sur ?n ?b) (adjacente ?a ?b ?d))
        :effect (and 
            (not (sur ?n ?b)) ; Le nombre n n'est plus sur la case b
            (sur ?n ?a) ; Le nombre n est sur la case a
            (not (vide ?a)) ; La case a n'est plus la case vide
            (vide ?b) ; La case b devient la case vide
        )
    )
)
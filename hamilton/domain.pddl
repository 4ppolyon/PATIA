(define (domain HamiltonCycle)

    (:requirements :strips :typing)

    (:types
        node edge
    )

    (:predicates
        ; Le noeud n est le noeud de départ
        (start ?n - node)
        ; On se trouve sur le noeud n
        (on ?n - node)
        ; Le noeud n a été visité
        (visited ?n - node)
        ; Le noeud n n'a pas encore été visité
        (leftToVisit ?n - node)
        ; Les noeuds n1 et n2 sont reliés par l'arrête e
        (connected ?n1 ?n2 - node ?e - edge)
    )

    ; Déplacement d'un noeud (visité ou non) vers un noeud qui reste à visiter
    (:action move
        :parameters (?from ?to - node ?e - edge)
        :precondition (and (connected ?from ?to ?e) (on ?from) (leftToVisit ?to))
        :effect (and 
            (not (on ?from))
            (on ?to)
            (not (leftToVisit ?to))
            (visited ?to)
        )
    )

    ; Retour au noeud de départ (la dernière action de chaque plan)
    (:action move_to_start
        :parameters (?from ?to - node ?e - edge)
        :precondition (and (connected ?from ?to ?e) (on ?from) (leftToVisit ?to) (start ?to))
        :effect (and 
            (not (on ?from))
            (on ?to)
            (not (leftToVisit ?to))
            (visited ?to)
        )
    )
)
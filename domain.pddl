(define (domain HamiltonCycle)

(:requirements :strips :typing)

(:types
    node edge
)

(:predicates
    ; Vrai si ce noeud est le noeud de départ
    (start ?n - node)
    ; Vrai si on se trouve sur ce noeud
    (on ?n - node)
    ; Vrai si un noeud a été visité
    (visited ?n - node)
    ; Vrai si un noeud n'a pas encore été visité
    (leftToVisit ?n - node)
    ; Vrai si les noeuds n1 et n2 sont reliés par l'arrête e
    (connected ?n1 ?n2 - node ?e - edge)
)

; On va vers un noeud pas encore visité   
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

; On retourne au noeud de départ
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
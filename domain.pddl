(define (domain GraphColoring)

(:requirements :strips :typing)

(:types noeud arrete couleur
)

(:predicates
    ; Vrai si le noeud n a la couleur c
    (aCouleur ?n - noeud ?c - couleur)
    ; Vrai si le noeud n n'est pas encore coloré
    (vide ?n - noeud)
    ; Vrai si les noeuds n1 et n2 sont sur l'arrête a (pas de symmétrie!)
    (sur ?n1 ?n2 - noeud ?a - arrete)
    ; Vrai si l'arrête a est marquée
    (marquee ?a - arrete)
    ; Vrai si deux couleurs sont différentes (OBLIGATOIRE)
    (diff ?c1 ?c2 - couleur)
)

; Colore deux noeuds et marque l'arrête qui les relie
(:action colore_2noeuds
    :parameters (?n1 ?n2 - noeud ?a - arrete ?c1 ?c2 - couleur)
    :precondition (and (vide ?n1) (vide ?n2) (sur ?n1 ?n2 ?a) (sur ?n2 ?n1 ?a) (diff ?c1 ?c2))
    :effect (and 
        (aCouleur ?n1 ?c1)
        (aCouleur ?n2 ?c2)
        (not (vide ?n1))
        (not (vide ?n2))
        (marquee ?a)
    )
)

; Colore un noeud sur une arrête où l'autre noeud est déjà colorié et marque l'arrête qui les relie
(:action colore_noeud
    :parameters (?n1 ?n2 - noeud ?a - arrete ?c1 ?c2 - couleur)
    :precondition (and (vide ?n1) (aCouleur ?n2 ?c2) (sur ?n1 ?n2 ?a) (sur ?n2 ?n1 ?a) (diff ?c1 ?c2))
    :effect (and 
        (aCouleur ?n1 ?c1)
        (not (vide ?n1))
        (marquee ?a)
    )
)

; Marque une arrête dont ses deux noeuds sont colorés
(:action marque_arrete
    :parameters (?n1 ?n2 - noeud ?a - arrete ?c1 ?c2 - couleur)
    :precondition (and (aCouleur ?n1 ?c1) (aCouleur ?n2 ?c2) (sur ?n1 ?n2 ?a) (sur ?n2 ?n1 ?a) (diff ?c1 ?c2))
    :effect (and
        (marquee ?a)
    )
)

; Colorie un noeud isolé
(:action colore_seul
    :parameters (?n - noeud ?c - couleur)
    :precondition (and (vide ?n))
    :effect (and 
        (not (vide ?n))
        (aCouleur ?n ?c)
    )
)


)
(define (domain GraphColoring)

    (:requirements :strips :typing)

    (:types noeud arrete couleur
    )

    (:predicates
        ; Le noeud n a la couleur c
        (aCouleur ?n - noeud ?c - couleur)
        ; Le noeud n n'est pas encore colorié
        (vide ?n - noeud)
        ; Les noeuds n1 et n2 sont sur l'arrête a (pas de symmétrie!)
        (sur ?n1 ?n2 - noeud ?a - arrete)
        ; L'arrête a est marquée (ses deux noeuds sont coloriés)
        (marquee ?a - arrete)
        ; Deux couleurs sont différentes (OBLIGATOIRE)
        (diff ?c1 ?c2 - couleur)
    )

    ; Colore deux noeuds et marque l'arrête qui les relie
    ; En attribuant une couleur différente pour chacun des deux noeuds
    (:action colore_2noeuds
        :parameters (?n1 ?n2 - noeud ?a - arrete ?c1 ?c2 - couleur)
        :precondition (and (vide ?n1) (vide ?n2) (sur ?n1 ?n2 ?a) (sur ?n2 ?n1 ?a) (diff ?c1 ?c2))
        :effect (and 
            (aCouleur ?n1 ?c1) ; Le noeud n1 à la couleur c1
            (aCouleur ?n2 ?c2) ; Le noeud n2 à la couleur c2
            (not (vide ?n1)) ; Le noeud n1 ne pourra plus être re-colorié
            (not (vide ?n2)) ; Le noeud n2 ne pourra plus être re-colorié
            (marquee ?a) ; L'arrête a est marquée
        )
    )

    ; Colore un noeud sur une arrête où le noeud opposé est déjà colorié
    ; Marque l'arrête qui les relie
    (:action colore_noeud
        :parameters (?n1 ?n2 - noeud ?a - arrete ?c1 ?c2 - couleur)
        :precondition (and (vide ?n1) (aCouleur ?n2 ?c2) (sur ?n1 ?n2 ?a) (sur ?n2 ?n1 ?a) (diff ?c1 ?c2))
        :effect (and 
            (aCouleur ?n1 ?c1) ; Le noeud n1 à la couleur c1
            (not (vide ?n1)) ; Le noeud n1 ne pourra plus être re-colorié
            (marquee ?a) ; L'arrête a est marquée
        )
    )

    ; Marque une arrête dont ses deux noeuds sont coloriés
    (:action marque_arrete
        :parameters (?n1 ?n2 - noeud ?a - arrete ?c1 ?c2 - couleur)
        :precondition (and (aCouleur ?n1 ?c1) (aCouleur ?n2 ?c2) (sur ?n1 ?n2 ?a) (sur ?n2 ?n1 ?a) (diff ?c1 ?c2))
        :effect (and
            (marquee ?a) ; L'arrête a est marquée
        )
    )

    ; Colorie un noeud isolé
    (:action colore_seul
        :parameters (?n - noeud ?c - couleur)
        :precondition (and (vide ?n))
        :effect (and 
            (not (vide ?n)) ; Le noeud n ne pourra plus être re-colorié
            (aCouleur ?n ?c) ; Le noeud n à la couleur c
        )
    )
)
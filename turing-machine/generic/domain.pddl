(define (domain TuringMachine)

    (:requirements :strips :typing)

    ; Le domaine pour simuler n'importe quelle machine de Turing

    (:types state cell symbol
    )

    (:predicates
        ; La machine est dans l'état z
        (inState ?z - state)
        ; La tête de lecture/écriture est sur la case c
        (headOn ?c - cell)
        ; Le symbole s est écrit sur la case c
        (hasSymbol ?s - symbol ?c - cell)
        ; La case a se trouve à gauche de la case b
        (atLeft ?a ?b -cell)
        ; La case a se trouve à droite de la case b
        (atRight ?a ?b - cell)

        ; Transition avec déplacement vers la gauche
        ; zc : état courant de la machine
        ; zd : état de destination de la machine
        ; sr : symbole lue sur la bande
        ; sw : symbole écrit sur la bande
        (transition_left ?zc ?zd - state ?sr ?sw - symbol)

        ; Transition avec déplacement vers la gauche
        ; zc : état courant de la machine
        ; zd : état de destination de la machine
        ; sr : symbole lue sur la bande
        ; sw : symbole écrit sur la bande
        (transition_right ?zc ?zd - state ?sr ?sw - symbol)

        ; Transition sans déplacement
        ; zc : état courant de la machine
        ; zd : état de destination de la machine
        ; sr : symbole lue sur la bande
        ; sw : symbole écrit sur la bande
        (transition_idle ?zc ?zd - state ?sr ?sw - symbol)
    )

    ; Une action qui déplace la tête de lecture vers la gauche
    (:action step_left
        :parameters (?zc ?zd - state ?sr ?sw - symbol ?c1 ?c2 - cell)
        :precondition (and (inState ?zc) (headOn ?c1) (hasSymbol ?sr ?c1) (atRight ?c1 ?c2) (transition_left ?zc ?zd ?sr ?sw))
        :effect (and 
            ; Changement d'état
            (not (inState ?zc))
            (inState ?zd)
            ; Ecriture du nouveau symbole
            (not (hasSymbol ?sr ?c1))
            (hasSymbol ?sw ?c1)
            ; Déplacement de la tête de lecture/écriture vers la gauche
            (not (headOn ?c1))
            (headOn ?c2)
        )
    )

    ; Une action qui déplace la tête de lecture vers la droite
    (:action step_right
        :parameters (?zc ?zd - state ?sr ?sw - symbol ?c1 ?c2 - cell)
        :precondition (and (inState ?zc) (headOn ?c1) (hasSymbol ?sr ?c1) (atLeft ?c1 ?c2) (transition_right ?zc ?zd ?sr ?sw))
        :effect (and 
            ; Changement d'état
            (not (inState ?zc))
            (inState ?zd)
            ; Ecriture du nouveau symbole
            (not (hasSymbol ?sr ?c1))
            (hasSymbol ?sw ?c1)
            ; Déplacement de la tête de lecture/écriture vers la droite
            (not (headOn ?c1))
            (headOn ?c2)
        )
    )

    ; Une action qui ne déplace pas la tête de lecture
    (:action step_idle
        :parameters (?zc ?zd - state ?sr ?sw - symbol ?c1 - cell)
        :precondition (and (inState ?zc) (headOn ?c1) (hasSymbol ?sr ?c1) (transition_idle ?zc ?zd ?sr ?sw))
        :effect (and 
            ; Changement d'état
            (not (inState ?zc))
            (inState ?zd)
            ; Ecriture du nouveau symbole
            (not (hasSymbol ?sr ?c1))
            (hasSymbol ?sw ?c1)
        )
    )
)
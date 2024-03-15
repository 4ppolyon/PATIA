(define (domain TuringMachine)

(:requirements :strips :typing)

(:types cell 
    z0 z1 zh - state
    blank zero one - symbol
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
)

; Dans l'état z0, lecture d'un blanc
(:action z0_blank
    :parameters (?z0 - z0 ?z1 - z1 ?c1 ?c2 - cell ?blank - blank)
    :precondition (and (inState ?z0) (headOn ?c1) (hasSymbol ?blank ?c1) (atRight ?c1 ?c2))
    :effect (and 
        ; Changement d'état
        (not (inState ?z0))
        (inState ?z1)
        ; Déplacement de la tête de lecture/écriture vers la gauche
        (not (headOn ?c1))
        (headOn ?c2)
    )
)

; Dans l'état z0, lecture d'un 0
(:action z0_0
    :parameters (?z0 - z0 ?c1 ?c2 - cell ?zero - zero)
    :precondition (and (inState ?z0) (headOn ?c1) (hasSymbol ?zero ?c1) (atLeft ?c1 ?c2))
    :effect (and 
        ; Déplacement de la tête de lecture/écriture vers la droite
        (not (headOn ?c1))
        (headOn ?c2)
    )
)

; Dans l'état z0, lecture d'un 1
(:action z0_1
    :parameters (?z0 - z0 ?c1 ?c2 - cell ?one - one)
    :precondition (and (inState ?z0) (headOn ?c1) (hasSymbol ?one ?c1) (atLeft ?c1 ?c2))
    :effect (and 
        ; Déplacement de la tête de lecture/écriture vers la droite
        (not (headOn ?c1))
        (headOn ?c2)
    )
)

; Dans l'état z1, lecture d'un blanc
(:action z1_blank
    :parameters (?z1 - z1 ?zh - zh ?c - cell ?blank - blank ?one - one)
    :precondition (and (inState ?z1) (headOn ?c) (hasSymbol ?blank ?c))
    :effect (and 
        ; Changement d'état
        (not (inState ?z1))
        (inState ?zh)
        ; Ecriture du nouveau symbole
        (not (hasSymbol ?blank ?c))
        (hasSymbol ?one ?c)
    )
)

; Dans l'état z1, lecture d'un 0
(:action z1_0
    :parameters (?z1 - z1 ?zh - zh ?c - cell ?zero - zero ?one - one)
    :precondition (and (inState ?z1) (headOn ?c) (hasSymbol ?zero ?c))
    :effect (and 
        ; Changement d'état
        (not (inState ?z1))
        (inState ?zh)
        ; Ecriture du nouveau symbole
        (not (hasSymbol ?zero ?c))
        (hasSymbol ?one ?c)
    )
)

; Dans l'état z1, lecture d'un 1
(:action z1_1
    :parameters (?z1 - z1 ?c1 ?c2 - cell ?zero - zero ?one - one)
    :precondition (and (inState ?z1) (headOn ?c1) (hasSymbol ?one ?c1) (atRight ?c1 ?c2))
    :effect (and 
        ; Ecriture du nouveau symbole
        (not (hasSymbol ?one ?c1))
        (hasSymbol ?zero ?c1)
        ; Déplacement de la tête de lecture/écriture vers la gauche
        (not (headOn ?c1))
        (headOn ?c2)
    )
)

)
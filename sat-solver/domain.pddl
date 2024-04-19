(define (domain SAT_Solver)

    (:requirements :strips :typing)

    (:types variable clause
    )

    (:predicates
        ; La variable v a pour valeur True
        (varIsTrue ?v - variable)
        ; La variable v a pour valeur False
        (varIsFalse ?v - variable)
        ; La variable v doit être vraie dans la clause c
        (varTrueIn ?v - variable ?c - clause)
        ; La variable v doit être fausse dans la clause c
        (varFalseIn ?v - variable ?c - clause)
        ; La clause c est vraie
        (clauseTrue ?c - clause)
        ; La variable n'a pas encore de valeur définie
        (hasNoValue ?v - variable)
    )

    ; La variable v prend pour valeur True et ne pourra pas prendre une autre valeur
    (:action set_var_true
        :parameters (?v - variable)
        :precondition (and (hasNoValue ?v))
        :effect (and 
            (not (varIsFalse ?v))
            (varIsTrue ?v)
            (not (hasNoValue ?v))
        )
    )

    ; La variable v prend pour valeur False et ne pourra pas prendre une autre valeur
    (:action set_var_false
        :parameters (?v - variable)
        :precondition (and (hasNoValue ?v))
        :effect (and 
            (not (varIsTrue ?v))
            (varIsFalse ?v)
            (not (hasNoValue ?v))
        )
    )

    ; La clause c devient est vraie car au moins une de ses variables devant être vraie à pour valeur True
    (:action set_clause_true
        :parameters (?c - clause ?v - variable)
        :precondition (and (varTrueIn ?v ?c) (varIsTrue ?v))
        :effect (and 
            (clauseTrue ?c)
        )
    )

    ; La clause c devient est vraie car au moins une de ses variables devant être fausse à pour valeur False
    (:action set_clause_true_var_neg
        :parameters (?c - clause ?v - variable)
        :precondition (and (varFalseIn ?v ?c) (varIsFalse ?v))
        :effect (and 
            (clauseTrue ?c)
        )
    )
)
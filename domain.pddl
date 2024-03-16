(define (domain SAT_Solver)

(:requirements :strips :typing)

(:types variable clause
)

(:predicates
    ; La variable v a pour valeur True
    (varIsTrue ?v - variable)
    ; La variable v a pour valeur False
    (varIsFalse ?v - variable)
    ; La variable v doit être vrai dans la clause c
    (varTrueIn ?v - variable ?c - clause)
    ; La variable v doit être fausse dans la clause c
    (varFalseIn ?v - variable ?c - clause)
    ; La clause c est vrai
    (clauseTrue ?c - clause)
    ; La variable n'a pas encore de valeur définie
    (hasNoValue ?v - variable)
)

(:action set_var_true
    :parameters (?v - variable)
    :precondition (and (hasNoValue ?v))
    :effect (and 
        (not (varIsFalse ?v))
        (varIsTrue ?v)
        (not (hasNoValue ?v))
    )
)

(:action set_var_false
    :parameters (?v - variable)
    :precondition (and (hasNoValue ?v))
    :effect (and 
        (not (varIsTrue ?v))
        (varIsFalse ?v)
        (not (hasNoValue ?v))
    )
)

(:action set_clause_true
    :parameters (?c - clause ?v - variable)
    :precondition (and (varTrueIn ?v ?c) (varIsTrue ?v))
    :effect (and 
        (clauseTrue ?c)
    )
)


(:action set_clause_true_var_neg
    :parameters (?c - clause ?v - variable)
    :precondition (and (varFalseIn ?v ?c) (varIsFalse ?v))
    :effect (and 
        (clauseTrue ?c)
    )
)




)
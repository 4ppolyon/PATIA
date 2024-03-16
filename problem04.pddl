(define (problem problem03) (:domain SAT_Solver)
(:objects
    a b c - variable
    c1 c2 c3 c4 c5 - clause
)

; Pas de solution

(:init
    (hasNoValue a)
    (hasNoValue b)
    (hasNoValue c)

    (varTrueIn a c1)
    (varTrueIn b c1)

    (varFalseIn a c2)
    (varFalseIn b c2)

    (varFalseIn a c3)
    (varTrueIn c c3)

    (varFalseIn b c4)
    (varTrueIn c c4)

    (varFalseIn c c5)
)

(:goal (and
    (clauseTrue c1)
    (clauseTrue c2)
    (clauseTrue c3)
    (clauseTrue c4)
    (clauseTrue c5)
))
)

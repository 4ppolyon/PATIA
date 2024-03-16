(define (problem problem01) (:domain SAT_Solver)
(:objects
    x1 x2 x3 x4 - variable
    c1 c2 c3 - clause
)

(:init
    (varTrueIn x1 c1)
    (varTrueIn x3 c1)
    (varFalseIn x4 c1)
    (varTrueIn x4 c2)
    (varTrueIn x2 c3)
    (varFalseIn x3 c3)
)

(:goal (and
    (clauseTrue c1)
    (clauseTrue c2)
    (clauseTrue c3)
))

)

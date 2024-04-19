(define (problem problem1) (:domain SAT_Solver)

    ; (x1 || x3 || !x4) && (x4 || x2) && (!x3)
    ; Une solution possible : x1 = True, x2 = True et x3 = False

    (:objects
        x1 x2 x3 x4 - variable
        c1 c2 c3 - clause
    )

    (:init
        (hasNoValue x1)
        (hasNoValue x2)
        (hasNoValue x3)
        (hasNoValue x4)

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

(define (problem problem2) (:domain SAT_Solver)

    ; (x1) && (!x1) && (!x1)
    ; Ce problème ne doit pas avoir de solution

    (:objects
        x1 - variable
        c1 c2 c3 - clause
    )

    (:init
        (hasNoValue x1)

        (varTrueIn x1 c1)
        (varFalseIn x1 c2)
        (varFalseIn x1 c3)
    )

    (:goal (and
        (clauseTrue c1)
        (clauseTrue c2)
        (clauseTrue c3)
    ))
)

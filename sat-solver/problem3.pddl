(define (problem problem3) (:domain SAT_Solver)

    ; (a || b || !c) && (!a || !b || c) && (!b || !c) && (a || c) && (!a || !c)
    ; Solution : a = true, b = false, c = false

    (:objects
        a b c - variable
        c1 c2 c3 c4 c5 - clause
    )

    (:init
        (hasNoValue a)
        (hasNoValue b)
        (hasNoValue c)

        (varTrueIn a c1)
        (varTrueIn b c1)
        (varFalseIn c c1)

        (varFalseIn a c2)
        (varFalseIn b c2)
        (varTrueIn c c2)

        (varFalseIn b c3)
        (varFalseIn c c3)

        (varTrueIn a c4)
        (varTrueIn c c4)

        (varFalseIn a c5)
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

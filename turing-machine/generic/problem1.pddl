(define (problem problem1) (:domain TuringMachine)

    (:objects 
        z0 z1 halt - state
        blank zero one - symbol
        c0 c1 c2 c3 c4 c5 c6 c7 c8 c9 c10 c11 c12 c13 c14 c15 - cell
    )

    ; Simulation de la machine de Turing x+1 avec 0 écrit sur la bande

    (:init
        (inState z0)
        (headOn c8)

        (transition_left z0 z1 blank blank)
        (transition_right z0 z0 zero zero)
        (transition_right z0 z0 one one)
        (transition_idle z1 halt blank one)
        (transition_idle z1 halt zero one)
        (transition_left z1 z1 one zero)

        (hasSymbol blank c1)
        (hasSymbol blank c2)
        (hasSymbol blank c3)
        (hasSymbol blank c4)
        (hasSymbol blank c5)
        (hasSymbol blank c6)
        (hasSymbol blank c7)
        (hasSymbol zero c8)
        (hasSymbol blank c9)
        (hasSymbol blank c10)
        (hasSymbol blank c11)
        (hasSymbol blank c12)
        (hasSymbol blank c13)
        (hasSymbol blank c14)
        (hasSymbol blank c15)

        (atLeft c0 c1)
        (atLeft c1 c2)
        (atLeft c2 c3)
        (atLeft c3 c4)
        (atLeft c4 c5)
        (atLeft c5 c6)
        (atLeft c6 c7)
        (atLeft c7 c8)
        (atLeft c8 c9)
        (atLeft c9 c10)
        (atLeft c10 c11)
        (atLeft c11 c12)
        (atLeft c12 c13)
        (atLeft c13 c14)
        (atLeft c14 c15)

        (atRight c1 c0)
        (atRight c2 c1)
        (atRight c3 c2)
        (atRight c4 c3)
        (atRight c5 c4)
        (atRight c6 c5)
        (atRight c7 c6)
        (atRight c8 c7)
        (atRight c9 c8)
        (atRight c10 c9)
        (atRight c11 c10)
        (atRight c12 c11)
        (atRight c13 c12)
        (atRight c14 c13)
        (atRight c15 c14)
    )

    (:goal (and
        (inState halt)
    ))
)

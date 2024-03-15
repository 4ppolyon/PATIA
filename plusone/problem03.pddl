(define (problem problem1) (:domain TuringMachine)

; Nombre de départ : 7

(:objects 
    z0 - z0
    z1 - z1
    halt - zh
    c0 c1 c2 c3 c4 c5 c6 c7 c8 c9 c10 c11 c12 c13 c14 c15 - cell
    blank - blank
    zero - zero
    one - one
)

(:init
    (headOn c8)
    (inState z0)

    (hasSymbol blank c1)
    (hasSymbol blank c2)
    (hasSymbol blank c3)
    (hasSymbol blank c4)
    (hasSymbol blank c5)
    (hasSymbol blank c6)
    (hasSymbol blank c7)
    (hasSymbol one c8)
    (hasSymbol one c9)
    (hasSymbol one c10)
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

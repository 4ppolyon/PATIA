(define (problem problem3) (:domain TuringMachine)
    (:objects 
        begin blank stick end - symbol
        q0 q1 q2 q3 q4 q5 q6 q7 q8 - state
        c0 c1 c2 c3 c4 c5 c6 c7 c8 c9 c10 c11 c12 c13 c14 c15 c16 c17 c18 c19 c20 c21 c22 c23 c24 c25 c26 c27 c28 c29 c30 c31 c32 c33 c34 c35 c36 c37 c38 c39 c40 - cell
    )

    ; Simulation de la machine de Turing qui retourne le maximum de n nombres en codés en unaire
    ; Les nombres sont codés en unaires avec (n+1) stick
    ; Les symboles begin et end marque respectivement le début et la fin de la zone qui contient les arguments de la machine
    ; Arguments de la machine : 4, 1, 0, 4 et 3
    ; La valeur de retour est codée avec n stick

    (:init
        (inState q0)
        (headOn c1)

        (transition_right q0 q0 blank blank)
        (transition_right q0 q0 stick blank)
        (transition_right q0 q2 end end)
        (transition_right q1 q0 blank blank)
        (transition_right q1 q1 stick stick)
        (transition_right q1 q2 end end)
        (transition_right q2 q2 stick stick)
        (transition_left q2 q3 blank stick)
        (transition_left q3 q3 stick stick)
        (transition_left q3 q4 end end)
        (transition_left q4 q4 blank blank)
        (transition_left q4 q5 stick stick)
        (transition_right q4 q6 begin begin)
        (transition_left q5 q5 blank blank)
        (transition_left q5 q5 stick stick)
        (transition_right q5 q0 begin begin)
        (transition_right q6 q6 blank blank)
        (transition_right q6 q7 end end)
        (transition_idle q7 q8 stick blank)

        (hasSymbol begin c1)
        (hasSymbol stick c2)
        (hasSymbol stick c3)
        (hasSymbol stick c4)
        (hasSymbol stick c5)
        (hasSymbol stick c6)
        (hasSymbol blank c7)
        (hasSymbol stick c8)
        (hasSymbol stick c9)
        (hasSymbol blank c10)
        (hasSymbol stick c11)
        (hasSymbol blank c12)
        (hasSymbol stick c13)
        (hasSymbol stick c14)
        (hasSymbol stick c15)
        (hasSymbol stick c16)
        (hasSymbol stick c17)
        (hasSymbol blank c18)
        (hasSymbol stick c19)
        (hasSymbol stick c20)
        (hasSymbol stick c21)
        (hasSymbol stick c22)
        (hasSymbol end c23)
        (hasSymbol blank c24)
        (hasSymbol blank c25)
        (hasSymbol blank c26)
        (hasSymbol blank c27)
        (hasSymbol blank c28)
        (hasSymbol blank c29)
        (hasSymbol blank c30)
        (hasSymbol blank c31)
        (hasSymbol blank c32)
        (hasSymbol blank c33)
        (hasSymbol blank c34)
        (hasSymbol blank c35)
        (hasSymbol blank c36)
        (hasSymbol blank c37)
        (hasSymbol blank c38)
        (hasSymbol blank c39)
        (hasSymbol blank c40)

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
        (atLeft c15 c16)
        (atLeft c16 c17)
        (atLeft c17 c18)
        (atLeft c18 c19)
        (atLeft c19 c20)
        (atLeft c20 c21)
        (atLeft c21 c22)
        (atLeft c22 c23)
        (atLeft c23 c24)
        (atLeft c24 c25)
        (atLeft c25 c26)
        (atLeft c26 c27)
        (atLeft c27 c28)
        (atLeft c28 c29)
        (atLeft c29 c30)
        (atLeft c30 c31)
        (atLeft c31 c32)
        (atLeft c32 c33)
        (atLeft c33 c34)
        (atLeft c34 c35)
        (atLeft c35 c36)
        (atLeft c36 c37)
        (atLeft c37 c38)
        (atLeft c38 c39)
        (atLeft c39 c40)

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
        (atRight c16 c15)
        (atRight c17 c16)
        (atRight c18 c17)
        (atRight c19 c18)
        (atRight c20 c19)
        (atRight c21 c20)
        (atRight c22 c21)
        (atRight c23 c22)
        (atRight c24 c23)
        (atRight c25 c24)
        (atRight c26 c25)
        (atRight c27 c26)
        (atRight c28 c27)
        (atRight c29 c28)
        (atRight c30 c29)
        (atRight c31 c30)
        (atRight c32 c31)
        (atRight c33 c32)
        (atRight c34 c33)
        (atRight c35 c34)
        (atRight c36 c35)
        (atRight c37 c36)
        (atRight c38 c37)
        (atRight c39 c38)
        (atRight c40 c39)
    )

    (:goal (and
        (inState q8)
    ))
)
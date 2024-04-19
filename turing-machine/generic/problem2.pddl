(define (problem problem2) (:domain TuringMachine)

    (:objects 
        begin blank stick end - symbol
        q0 q1 q2 q3 q4 q5 q6 q7 q8 - state
        c0 c1 c2 c3 c4 c5 c6 c7 c8 c9 c10 c11 c12 c13 c14 c15 - cell
    )

    ; Simulation de la machine de Turing qui retourne le maximum de n nombres en codés en unaire
    ; Les nombres sont codés en unaires avec (n+1) stick
    ; Les symboles begin et end marque respectivement le début et la fin de la zone qui contient les arguments de la machine
    ; Arguments de la machine : 3 et 0
    ; La valeur de retour est codée avec n stick

    (:init
        (inState q0)
        (headOn c1)

        ; Transition état q0
        (transition_right q0 q0 blank blank)
        (transition_right q0 q1 stick blank)
        (transition_right q0 q2 end end)
        ; Transition état q1
        (transition_right q1 q0 blank blank)
        (transition_right q1 q1 stick stick)
        (transition_right q1 q2 end end)
        ; Transition état q2
        (transition_right q2 q2 stick stick)
        (transition_left q2 q3 blank stick)
        ; Transition état q3
        (transition_left q3 q3 stick stick)
        (transition_left q3 q4 end end)
        ; Transition état q4
        (transition_left q4 q4 blank blank)
        (transition_left q4 q5 stick stick)
        (transition_right q4 q6 begin begin)
        ; Transition état q5
        (transition_left q5 q5 blank blank)
        (transition_left q5 q5 stick stick)
        (transition_right q5 q0 begin begin)
        ; Transition état q6
        (transition_right q6 q6 blank blank)
        (transition_right q6 q7 end end)
        ; Transition état q7
        (transition_idle q7 q8 stick blank)

        (hasSymbol begin c0)
        (hasSymbol stick c1)
        (hasSymbol stick c2)
        (hasSymbol stick c3)
        (hasSymbol stick c4)
        (hasSymbol blank c5)
        (hasSymbol stick c6)
        (hasSymbol end c7)
        (hasSymbol blank c8)
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
        (inState q8)
    ))
)

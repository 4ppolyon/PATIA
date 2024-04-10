(define (problem problem1) (:domain HamiltonCycle)

    ; Exemple du sujet, on commence au noeud a

    (:objects
        a b c d - node
        I II III IV V VI VII - edge
    )

    (:init
        (start a)
        (on a)

        (leftToVisit a)
        (leftToVisit b)
        (leftToVisit c)
        (leftToVisit d)

        (connected a b I)
        (connected b a I)
        (connected a b VII)
        (connected b a VII)
        (connected b c II)
        (connected c b II)
        (connected b c III)
        (connected b c III)
        (connected c d IV)
        (connected d c IV)
        (connected b d V)
        (connected d b V)
        (connected a d VI)
        (connected d a VI)
    )

    (:goal (and
        (on a)
        (visited a)
        (visited b)
        (visited c)
        (visited d)
    ))
)

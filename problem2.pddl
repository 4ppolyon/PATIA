(define (problem problem2) (:domain HamiltonCycle)
    
    ; Un graphe qui ne contient pas de cycle hamlitonien    
    
    (:objects
        a b c d - node
        I II III IV - edge
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
        (connected b c II)
        (connected c b II)
        (connected c d III)
        (connected d c III)
        (connected b d IV)
        (connected d b IV)
    )

    (:goal (and
        (on a)
        (visited a)
        (visited b)
        (visited c)
        (visited d)
    ))
)

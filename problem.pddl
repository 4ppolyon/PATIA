(define (problem p) (:domain NPuzzle)

    ; Configuration initiale du puzzle (v => la case vide)
    ; 3 7 5
    ; v 1 2
    ; 8 4 6

    ; Configuration à atteindre
    ; 1 2 3
    ; 4 5 6
    ; 7 8 v

    (:objects 
        a b c d e f g h i - case
        n1 n2 n3 n4 n5 n6 n7 n8 - nombre
        haut bas gauche droite - direction
    )

    (:init
        (sur n3 a)
        (sur n7 b)
        (sur n5 c)
        (vide d)
        (sur n1 e)
        (sur n2 f)
        (sur n8 g)
        (sur n4 h)
        (sur n6 i)
        (adjacente a b gauche)
        (adjacente a d bas)
        (adjacente b a gauche)
        (adjacente b c droite)
        (adjacente b e bas)
        (adjacente c b gauche)
        (adjacente c f bas)
        (adjacente d a haut)
        (adjacente d e droite)
        (adjacente d g bas)
        (adjacente e d gauche)
        (adjacente e b haut)
        (adjacente e f droite)
        (adjacente e h bas)
        (adjacente f e gauche)
        (adjacente f c haut)
        (adjacente f i bas)
        (adjacente g d haut)
        (adjacente g h droite)
        (adjacente h g gauche)
        (adjacente h i droite)
        (adjacente h e haut)
    )

    (:goal (and
        (sur n1 a)
        (sur n2 b)
        (sur n3 c)
        (sur n4 d)
        (sur n5 e)
        (sur n6 f)
        (sur n7 g)
        (sur n8 h)
        (vide i)
    ))
)

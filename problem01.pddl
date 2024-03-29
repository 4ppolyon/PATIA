(define (problem problem01) (:domain GraphColoring)
(:objects 
    a b c - noeud
    a1 a2 a3 - arrete
    rouge bleu vert - couleur
)

(:init 
    (diff rouge bleu)
    (diff bleu vert)
    (diff vert rouge)
    (vide a)
    (vide b)
    (vide c)
    (sur a b a1)
    (sur b a a1)
    (sur a c a2)
    (sur c a a2)
    (sur b c a3)
    (sur c b a3)
)

(:goal (and
    (marquee a1)
    (marquee a2)
    (marquee a3)
))
)

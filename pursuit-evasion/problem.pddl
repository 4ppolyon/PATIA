(define (problem pursuit_1)
(:domain pursuit)
(:objects a b - noeud
    ar1 top bottom  - arete
    ag1 - agent
)
(:init (link a b ar1) (link b a ar1) (agentSur ag1 a) 
(esttop top) (estbottom bottom)

(on top ar1 a) 
(on ar1 bottom a)

(on top ar1 b)
(on ar1 bottom b))

(:goal (and (estAreteMarquee ar1)))
)
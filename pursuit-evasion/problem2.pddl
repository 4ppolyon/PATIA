(define (problem pursuit_2)
(:domain pursuit)
(:objects a b c - noeud
    ar1 ar2 top bottom - arete
    ag1 - agent
)
(:init (link a b ar1) (link b a ar1) (agentSur ag1 a) 
       (link b c ar2) (link c b ar2)

       (esttop top) (estbottom bottom)

       (on top ar1 a)
       (on ar1 bottom a) 

       (on top ar1 b)
       (on ar1 ar2 b)
       (on ar2 bottom b)

       (on top ar2 c)
       (on ar2 bottom c)
       )
(:goal (and (estAreteMarquee ar1)(estAreteMarquee ar2)))
)
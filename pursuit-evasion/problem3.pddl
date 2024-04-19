(define (problem pursuit_3)
(:domain pursuit)
(:objects a b c - noeud
    ar1 ar2 ar3 top bottom - arete
    ag1 ag2 - agent
)
(:init (link a b ar1) (link b a ar1) (agentSur ag1 a) (agentSur ag2 a)  (agentDiff ag1 ag2)
       (link b c ar2) (link c b ar2)
       (link a c ar3) (link c a ar3)

       (esttop top) (estbottom bottom)

       (on top ar1 a)
       (on ar1 ar3 a)
       (on ar3 bottom a) 

       (on top ar1 b)
       (on ar1 ar2 b)
       (on ar2 bottom b)

       (on top ar2 c)
       (on ar2 ar3 c)
       (on ar3 bottom c)
       )
(:goal (and (estAreteMarquee ar1) (estAreteMarquee ar2) (estAreteMarquee ar3)))
)
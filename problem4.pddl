(define (problem pursuit_4)
(:domain pursuit)
(:objects a b c d - noeud
    ar1 ar2 ar3 ar4 top bottom - arete
    ag1 ag2 - agent
)
(:init (link a b ar1) (link b a ar1) (agentSur ag1 a) (agentSur ag2 a)  (agentDiff ag1 ag2)
       (link b c ar2) (link c b ar2)
       (link a c ar3) (link c a ar3)
       (link b d ar4) (link d b ar4)

       (esttop top) (estbottom bottom)

       (on top ar1 a)
       (on ar1 ar3 a)
       (on ar3 bottom a) 

       (on top ar1 b)
       (on ar1 ar2 b)
       (on ar2 ar4 b)
       (on ar4 bottom b)

       (on top ar2 c)
       (on ar2 ar3 c)
       (on ar3 bottom c)

       (on top ar4 d)
       (on ar4 bottom d)
       )
(:goal (and (estAreteMarquee ar1) (estAreteMarquee ar2) (estAreteMarquee ar3) (estAreteMarquee ar4)))
)
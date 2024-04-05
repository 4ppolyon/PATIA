(define (problem pursuit_6)
(:domain pursuit)
(:objects a b c d e - noeud
    ar1 ar2 ar3 ar4 ar5 top bottom - arete
    ag1 ag2 - agent
)
(:init (link a b ar1) (link b a ar1) (agentSur ag1 e) (agentSur ag2 e) (agentDiff ag1 ag2)
       (link b c ar2) (link c b ar2)
       (link d c ar3) (link c d ar3)
       (link b d ar4) (link d b ar4)
       (link b e ar5) (link e b ar5)

       (esttop top) (estbottom bottom)

       (on top ar1 a)
       (on ar1 bottom a) 

       (on top ar1 b)
       (on ar1 ar2 b)
       (on ar2 ar4 b)
       (on ar4 ar5 b)
       (on ar5 bottom b)

       (on top ar2 c)
       (on ar2 ar3 c)
       (on ar3 bottom c)
       
       (on top ar3 d)
       (on ar3 ar4 d)
       (on ar4 bottom d)

       (on top ar5 e)
       (on ar5 bottom e)


       )
(:goal (and (estAreteMarquee ar1) (estAreteMarquee ar2) (estAreteMarquee ar3) (estAreteMarquee ar4) (estAreteMarquee ar5)))
)
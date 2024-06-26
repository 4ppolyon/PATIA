(define (problem problem3) (:domain GraphColoring)

    ; Le graphe d'exemple du sujet (les couleurs des noeuds peuvent ne pas être les mêmes que dans la solution du sujet)

    (:objects 
        WA NT SA Q NSW V T - noeud
        WANT WASA NTSA NTQ SAQ SANSW SAV QNSW NSWV - arrete
        violet bleu orange - couleur    
    )

    (:init 
        (diff violet bleu)
        (diff bleu orange)
        (diff orange violet)
        (vide WA)
        (vide NT)
        (vide SA)
        (vide Q)
        (vide NSW)
        (vide V)
        (vide T)
        (sur WA NT WANT)
        (sur NT WA WANT)
        (sur WA SA WASA)
        (sur SA WA WASA)
        (sur NT SA NTSA)
        (sur SA NT NTSA)
        (sur NT Q NTQ)
        (sur Q NT NTQ)
        (sur SA Q SAQ)
        (sur Q SA SAQ)
        (sur SA NSW SANSW)
        (sur NSW SA SANSW)
        (sur SA V SAV)
        (sur V SA SAV)
        (sur Q NSW QNSW)
        (sur NSW Q QNSW)
        (sur NSW V NSWV)
        (sur V NSW NSWV)
    )

    (:goal (and
        (marquee WANT)
        (marquee WASA)
        (marquee NTSA)
        (marquee NTQ)
        (marquee SAQ)
        (marquee SANSW)
        (marquee SAV)
        (marquee QNSW)
        (marquee NSWV)
    ))
)

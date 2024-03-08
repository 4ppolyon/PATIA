(define (domain Sokoban)

(:requirements :strips :typing)

(:types caisse but agent case direction
)

(:predicates
    ; La case c n'a pas de caisse ou d'agent dessus et est un sol (pas un mur)
    (empty ?c - case)
    ; La caisse c est sur la case case (la case est pas sol)
    (caisseSur ?c - caisse ?case - case)
    ; L'agent a est sur la case case (la case est pas sol)
    (agentSur ?a - agent ?case - case)
    ; Le but b est sur la case case (la case est un sol)
    (butSurCase ?b - but ?case - case)
    ; Le but b n'a pas de caisse sur lui
    (butVide ?b - but)
    ; La case c1 est adjacente à la case c2 dans la direction d
    (adjacente ?c1 ?c2 - case ?d - direction)
    ; La caisse n'est pas sur un but
    (caisseLibre ?c - caisse)
    ; La caisse c est sur un but
    (caisseSurBut ?c - caisse)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;                                                 ;;;
;;; Actions de déplacement SANS pousser de caisse   ;;;
;;;                                                 ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Deplacement de l'agent sans pousser de caisse
(:action deplacer_agent
    :parameters (?d - direction ?a - agent ?c1 ?c2 - case)
    ; l'agent est sur la case c1, la case c2 est un sol
    ; c1 est adjacente à c2 dans la direction d.
    :precondition (and (agentSur ?a ?c1) (empty ?c2) (adjacente ?c2 ?c1 ?d))
    :effect (and 
        ; l'agent est plus sur la case c1
        (not (agentSur ?a ?c1))
        (empty ?c1)
        ; l'agent est sur la case c2
        (agentSur ?a ?c2)
        (not (empty ?c2))
    )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;                                                 ;;;
;;; Actions de déplacement AVEC pousser de caisse   ;;;
;;;                                                 ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(:action deplacer_caisse
    :parameters (?d - direction ?a - agent ?c1 ?c2 ?c3 - case ?caisse - caisse)
    ; l'agent est sur la case c1, la case c2 est une caisse et la case c3 est un sol
    ; c1 est adjacente à c2 dans la direction d
    ; c2 est adjacente à c3 dans la direction d
    :precondition (and (agentSur ?a ?c1) (caisseSur ?caisse ?c2) (caisseLibre ?caisse) (empty ?c3) (adjacente ?c2 ?c1 ?d) (adjacente ?c3 ?c2 ?d))
    :effect (and 
        ; l'agent est plus sur la case c1
        (not (agentSur ?a ?c1))
        (empty ?c1)
        ; l'agent est sur la case c2
        (agentSur ?a ?c2)
        (not (empty ?c2))
        ; la caisse est plus sur la case c2
        (not (caisseSur ?caisse ?c2))
        ; la caisse est sur la case c3
        (caisseSur ?caisse ?c3)
        (not (empty ?c3))
    )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;                                                          ;;;
;;; Actions de déplacement AVEC pousser de caisse SUR un but ;;;
;;;                                                          ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(:action deplacer_caisse_sur_but
    :parameters (?d - direction ?a - agent ?c1 ?c2 ?c3 - case ?caisse - caisse ?b - but)
    ; l'agent est sur la case c1, la case c2 est une caisse et la case c3 est un sol
    ; c1 est adjacente à c2 dans la direction d
    ; c2 est adjacente à c3 dans la direction d
    ; le but b est sur la case c3
    :precondition (and (agentSur ?a ?c1) (caisseSur ?caisse ?c2) (caisseLibre ?caisse) (empty ?c3) (butSurCase ?b ?c3) (butVide ?b) (adjacente ?c2 ?c1 ?d) (adjacente ?c3 ?c2 ?d))
    :effect (and 
        ; l'agent est plus sur la case c1
        (not (agentSur ?a ?c1))
        (empty ?c1)
        ; l'agent est sur la case c2
        (agentSur ?a ?c2)
        (not (empty ?c2))
        ; la caisse est plus sur la case c2
        (not (caisseSur ?caisse ?c2))
        ; la caisse est sur la case c3
        (caisseSur ?caisse ?c3)
        (not (empty ?c3))
        ; le but b est occupé
        (not (butVide ?b))
        (caisseSurBut ?caisse)
        (not (caisseLibre ?caisse))
    )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;                                                              ;;;
;;; Actions de déplacement AVEC pousser de caisse DEPUIS un but  ;;;
;;;                                                              ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(:action deplacer_caisse_hors_but
    :parameters (?d - direction ?a - agent ?c1 ?c2 ?c3 - case ?caisse - caisse ?b - but)
    ; l'agent est sur la case c1, la case c2 est une caisse et la case c3 est un sol
    ; c1 est adjacente à c2 dans la direction d
    ; c2 est adjacente à c3 dans la direction d
    ; le but b1 est sur la case c2
    ; le but b2 est sur la case c3
    :precondition (and (agentSur ?a ?c1) (caisseSur ?caisse ?c2) (caisseSurBut ?caisse) (empty ?c3) (butSurCase ?b ?c2) (adjacente ?c2 ?c1 ?d) (adjacente ?c3 ?c2 ?d))
    :effect (and 
        ; l'agent n'est plus sur la case c1
        (not (agentSur ?a ?c1))
        (empty ?c1)
        ; l'agent est sur la case c2
        (agentSur ?a ?c2)
        (not (empty ?c2))
        ; la caisse n'est plus c2
        (not (caisseSur ?caisse ?c2))
        ; le but b1 n'est plus occupé
        (butVide ?b)
        ; la caisse est sur la case c3
        (caisseSur ?caisse ?c3)
        (not (empty ?c3))
        (not (caisseSurBut ?caisse))
        (caisseLibre ?caisse)
    )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;                                                                        ;;;
;;; Actions de déplacement AVEC pousser de caisse SUR un but DEPUIS un but ;;;
;;;                                                                        ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(:action deplacer_caisse_de_but_sur_but
    :parameters (?d - direction ?a - agent ?c1 ?c2 ?c3 - case ?caisse - caisse ?b1 ?b2 - but)
    ; l'agent est sur la case c1, la case c2 est une caisse et la case c3 est un sol
    ; c1 est adjacente à c2 dans la direction d
    ; c2 est adjacente à c3 dans la direction d
    ; le but b1 est sur la case c2
    ; le but b2 est sur la case c3
    :precondition (and (agentSur ?a ?c1) (caisseSur ?caisse ?c2) (empty ?c3) (butSurCase ?b1 ?c2) (butSurCase ?b2 ?c3) (butVide ?b2) (caisseSurBut ?caisse) (adjacente ?c2 ?c1 ?d) (adjacente ?c3 ?c2 ?d))
    :effect (and 
        ; l'agent n'est plus sur la case c1
        (not (agentSur ?a ?c1))
        (empty ?c1)
        ; l'agent est sur la case c2
        (agentSur ?a ?c2)
        (not (empty ?c2))
        ; la caisse n'est plus sur la case c2
        (not (caisseSur ?caisse ?c2))
        ; le but b1 n'est plus occupé
        (butVide ?b1)
        ; la caisse est sur la case c3
        (caisseSur ?caisse ?c3)
        (not (empty ?c3))
        ; le but b2 est occupé
        (not (butVide ?b2))
        (caisseSurBut ?caisse)
    )
)

)
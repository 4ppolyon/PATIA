(define (domain pursuit)
  (:requirements :strips :typing :negative-preconditions)
  (:types noeud
          agent
          arete 
  )
  (:predicates 
	   (link ?n1 - noeud ?n2 - noeud ?ar - arete)
	   (agentSur ?ag - agent ?n - noeud)
	   (estAreteMarquee ?ar - arete)
	   (estbottom ?ar - arete)
	   (esttop ?ar - arete)
	   (on ?ar1 - arete ?ar2 - arete ?p - noeud)
	   (agentDiff ?ag1 - agent ?ag2 - agent)
	   
	       )

    
        (:action move_reste1noeud
	     :parameters (?ag1 - agent ?n1 - noeud ?n2 - noeud ?arlink - arete ?ardessuspile1 - arete ?ardessuspile2 
	                        - arete ?ardessouspile1 -arete ?ardessouspile2 - arete)
	     :precondition (and (agentSur ?ag1 ?n1) (link ?n1 ?n2 ?arlink) (link ?n2 ?n1 ?arlink)
	     (on ?arlink ?ardessouspile1 ?n1) (on ?ardessuspile1 ?arlink ?n1) (estbottom ?ardessouspile1) (esttop ?ardessuspile1)
	     (on ?arlink ?ardessouspile2 ?n2) (on ?ardessuspile2 ?arlink ?n2)
		 )
	     :effect
	     (and (agentSur ?ag1 ?n2) (not (agentSur ?ag1 ?n1)) (estAreteMarquee ?arlink) (not (on ?arlink ?ardessouspile1 ?n1)) (not (on ?ardessuspile1 ?arlink ?n1)) 
	     (not (on ?arlink ?ardessouspile2 ?n2)) (not (on ?ardessuspile2 ?arlink ?n2)) (on ?ardessuspile1 ?ardessouspile1 ?n1) (on ?ardessuspile2 ?ardessouspile2 ?n2))
	     
        )
        
        (:action move_2_agent_meme_noeuds_au_debut
	     :parameters (?ag1 - agent ?ag2 - agent ?n1 - noeud ?n2 - noeud ?arlink - arete ?ardessuspile1 - arete ?ardessuspile2 
	                        - arete ?ardessouspile1 -arete ?ardessouspile2 - arete)
	     
	     :precondition (and (agentSur ?ag1 ?n1) (agentSur ?ag2 ?n1) (agentDiff ?ag1 ?ag2) (link ?n1 ?n2 ?arlink) (link ?n2 ?n1 ?arlink)
	     	(on ?ardessuspile1 ?arlink ?n1)
	     	(on ?arlink ?ardessouspile1 ?n1)
	     	 
	     	(on ?ardessuspile2 ?arlink ?n2)
	     	(on ?arlink ?ardessouspile2 ?n2)
	     )
	     
	     :effect
	     (and (agentSur ?ag1 ?n2) (not (agentSur ?ag1 ?n1)) (agentSur ?ag2 ?n1) (estAreteMarquee ?arlink) (not (on ?arlink ?ardessouspile1 ?n1)) (not (on ?ardessuspile1 ?arlink ?n1)) 
	     (not (on ?arlink ?ardessouspile2 ?n2)) (not (on ?ardessuspile2 ?arlink ?n2)) (on ?ardessuspile1 ?ardessouspile1 ?n1) (on ?ardessuspile2 ?ardessouspile2 ?n2)) 
    ) 
        
    (:action rejoindre_quand_marque
	     :parameters (?ag1 - agent ?n1 - noeud ?n2 - noeud ?arlink - arete ?bottom - arete ?top 
	                        - arete)
	     
	     :precondition (and (agentSur ?ag1 ?n1) (link ?n1 ?n2 ?arlink) (link ?n2 ?n1 ?arlink)
	     	(on ?top ?bottom ?n1)
	     	(estbottom ?bottom)
	     	(esttop ?top)    	 
	     )
	     
	     :effect
	     (and (agentSur ?ag1 ?n2) (not (agentSur ?ag1 ?n1)) )
	) 
    

	

     
)
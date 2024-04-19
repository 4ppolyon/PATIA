(define (domain hanoi)
    (:requirements :strips :typing)
    (:types object tower)

    (:predicates
        ; La pièce b1 est plus petite que la pièce b2
        (smaller ?b1 - object ?b2 - object)
        ; La pièce b1 n'a pas de pièce au-dessus d'elle
        (clear ?b1 - object)
        ; La pièce b1 est sur la tour t1
        (ontower ?b1 - object ?t1 - tower)
        ; La pièce b1 est au dessus de la pièce b2
        (on ?b1 - object ?b2 - object)
        ; La main ne tient aucune pièce
        (handempty)
        ; La main tient la pièce b1
        (holding ?b1 - object)
    )

    ; La main prend la pièce se trouvant au sommet d'une tour
    (:action unstack
        :parameters (?b1 - object ?b2 - object)
        :precondition (and (clear ?b1) (on ?b1 ?b2) (handempty))
        :effect (and 
            (not (on ?b1 ?b2)) ; l'objet n'est plus au dessus de b2
            (clear ?b2) ; b2 est maintenant au sommet
            (not (clear ?b1)) ; b1 n'est plus au sommet
            (not (handempty)) ; la main n'est plus vide
            (holding ?b1) ; la main tient b1
        )
    )

    ; La main place la pièce qu'elle tient sur une tour
    (:action stack
        :parameters (?b1 - object ?b2 - object)
        :precondition (and (holding ?b1) (clear ?b2) (smaller ?b1 ?b2))
        :effect (and 
            (on ?b1 ?b2) ; l'objet b1 est au dessus de b2
            (not (clear ?b2)) ; b2 n'est plus au sommet
            (clear ?b1) ; b1 est maintenant au sommet
            (handempty) ; la main est vide
            (not (holding ?b1)) ; la main ne tient plus b1
        )
    )
    
    ; La main prend la pièce se trouvant au sommet d'une tour
    ; et la tour n'a alors plus aucune pièce sur elle
    (:action unstack-empty
        :parameters (?b1 - object ?t - tower)
        :precondition (and (clear ?b1) (handempty) (ontower ?b1 ?t))
        :effect (and 
            (not (clear ?b1)) ; l'objet n'est plus au dessus de la tour
            (clear ?t) ; la tour est vide
            (not (ontower ?b1 ?t)) ; l'objet n'est plus sur la tour
            (not (handempty)) ; la main n'est plus vide
            (holding ?b1) ; la main tient l'objet
        )
    )
    
    ; La main place la pièce qu'elle tient sur une tour qui n'a aucune pièce
    (:action stack-empty
        :parameters (?b1 - object ?t - tower)
        :precondition (and (holding ?b1) (clear ?t))
        :effect (and 
            (clear ?b1) ; l'objet est au dessus de la tour
            (not (clear ?t)) ; la tour n'est plus vide
            (ontower ?b1 ?t) ; l'objet est sur la tour
            (handempty) ; la main est vide
            (not (holding ?b1)) ; la main ne tient plus l'objet
        )
    )
)
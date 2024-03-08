(define (domain hanoi)
    (:requirements :strips :typing)
    (:types object tower)

    (:predicates
        (smaller ?b1 - object ?b2 - object); Vrai si B1 est plus petit que b2
        (clear ?b1 - object); Vrai si b1 n'a pas d'objet au dessus de lui
        (ontower ?b1 - object ?t1 - tower); Vrai si b1 est sur la tour t1
        (on ?b1 - object ?b2 - object); Vrai si b1 est au dessus de b2
        (handempty); Vrai si la main est vide
        (holding ?b1 - object); Vrai si la main tient l'objet b1
    )

    (:action unstack ; Dépiler un objet b1 au dessus de b2
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

    (:action stack ; Empiler un objet b1 sur b2
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
    
    (:action unstack-empty ; Dépiler un objet b1 au dessus de la tour t
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
    
    (:action stack-empty ; Empiler un objet b1 sur la tour t
        :parameters (?b1 - object ?t - tower)
        :precondition (and (holding ?b1) (clear ?t)) ; la tour est vide et la main tient l'objet
        :effect (and 
            (clear ?b1) ; l'objet est au dessus de la tour
            (not (clear ?t)) ; la tour n'est plus vide
            (ontower ?b1 ?t) ; l'objet est sur la tour
            (handempty) ; la main est vide
            (not (holding ?b1)) ; la main ne tient plus l'objet
        )
    )
)
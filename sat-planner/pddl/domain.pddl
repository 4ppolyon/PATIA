(define (domain robot)
    (:requirements :strips :typing)
    (:types robot room)
    (:predicates
        (at ?robot - robot ?room - room)
        (next ?r1 ?r2 - room)
    )

    (:action move
        :parameters (?robot - robot ?dep ?dest - room)
        :precondition (and (at ?robot ?dep) (next ?dep ?dest))
        :effect (and
            (at ?robot ?dest)
            (not (at ?robot ?dep))
        )
    )
)
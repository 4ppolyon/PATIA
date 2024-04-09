(define (domain BlocksWorld)
	(:requirements :strips :typing)
	(:types block)

	(:predicates 
		; Le bloc x est empilé au dessus du bloc y
		(on ?x - block ?y - block)
		; Le bloc x est sur la table
		(ontable ?x - block)
		; Le bloc x n'a pas de bloc au dessus de lui
		(clear ?x - block)
		; La main ne tient aucun bloc
		(handempty)
		; La main tient le bloc x
		(holding ?x - block)
	)

	; La main prend un bloc qui est posé sur la table et qui n'a pas de bloc au-dessus de lui
	(:action pick-from-table
			:parameters (?x - block)
			:precondition (and (clear ?x) (ontable ?x) (handempty))
			:effect (and 
				(not (ontable ?x))
				(not (clear ?x))
				(not (handempty))
				(holding ?x)
			)
	)

	; La main place le bloc qu'elle tient sur la table
	(:action put-on-table
			:parameters (?x - block)
			:precondition (holding ?x)
			:effect (and 
				(not (holding ?x))
				(clear ?x)
				(handempty)
				(ontable ?x)
			)
	)

	; La main place le block qu'elle tient au sommet d'une pile de blocs 
	; (la pile visée peut être constituée d'un seul bloc)
	(:action stack
			:parameters (?x - block ?y - block)
			:precondition (and (holding ?x) (clear ?y))
			:effect (and 
				(not (holding ?x))
				(not (clear ?y))
				(clear ?x)
				(handempty)
				(on ?x ?y)
			)
	)

	; La main prend un bloc qui est le sommet d'une pile de blocs
	(:action unstack
			:parameters (?x - block ?y - block)
			:precondition (and (on ?x ?y) (clear ?x) (handempty))
			:effect (and 
				(holding ?x)
				(clear ?y)
				(not (clear ?x))
				(not (handempty))
				(not (on ?x ?y))
			)
	)
)

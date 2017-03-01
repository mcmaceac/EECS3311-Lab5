note
	description: "Summary description for {GAME}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GAME

create
	make

feature --Initialisation
	make (p1: STRING; p2: STRING)
		do
			player1 := p1
			player2 := p2
			p1_turn := true
		end

feature --Attributes

	player1: STRING
	player2: STRING
	p1_turn: BOOLEAN

feature --Queries



feature --Commands


end

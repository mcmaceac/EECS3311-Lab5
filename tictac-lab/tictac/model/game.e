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
			p1_score := 0
			p2_score := 0

			err_message := "  ok: => " + player1 + " plays next"
			lines := <<"___", "___", "___">>
		end

feature --Attributes

	player1: STRING
	player2: STRING
	p1_turn: BOOLEAN		--indicates X to be placed instead of O

	p1_score: INTEGER
	p2_score: INTEGER

	err_message: STRING
	lines: ARRAY[STRING]	--game board containing all marks

feature --Queries

	game_state: STRING
		do
			create Result.make_empty
			Result.append ("  " + err_message + "%N")
			Result.append ("  " + lines[1] + "%N")
			Result.append ("  " + lines[2] + "%N")
			Result.append ("  " + lines[3] + "%N")
			Result.append ("  " + p1_score.out + ": score for %"" + player1 + "%" (as X)")
			Result.append ("  " + p2_score.out + ": score for %"" + player2 + "%" (as O)")
		end

	board_indexes (position: INTEGER): TUPLE[INTEGER, INTEGER]
		--returns the proper index for the two dimensional board array
		local
			x: INTEGER
			y: INTEGER
		do
			if position >= 1 and position <= 3 then
				y := 1
				x := position
			else if position >= 4 and position <= 6 then
				y := 2
				x := position - 3
			else
				y := 3
				x := position - 6
			end
			end
			Result := [x, y]
		end

feature --Commands

	play (player: STRING; position: INTEGER)
		--player places their mark on position if it is their turn
		require
			position >= 1 and position <= 9
		do
			if p1_turn then 	--X

			else				--O

			end
		end

end

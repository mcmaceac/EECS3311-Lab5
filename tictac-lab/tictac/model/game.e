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

			err_message := "ok: => " + player1 + " plays next"
			board := <<'_','_','_','_','_','_','_','_','_'>>
		end

feature --Attributes

	player1: STRING
	player2: STRING
	p1_turn: BOOLEAN		--indicates X to be placed instead of O

	p1_score: INTEGER
	p2_score: INTEGER

	err_message: STRING
	board: ARRAY[CHARACTER]	--game board containing all marks

feature --Queries

	game_state: STRING
		do
			create Result.make_empty
			Result.append ("  " + err_message + "%N")
			Result.append ("  " + board[1].out + board[2].out + board[3].out + "%N")
			Result.append ("  " + board[4].out + board[5].out + board[6].out + "%N")
			Result.append ("  " + board[7].out + board[8].out + board[9].out + "%N")
			Result.append ("  " + p1_score.out + ": score for %"" + player1 + "%" (as X)%N")
			Result.append ("  " + p2_score.out + ": score for %"" + player2 + "%" (as O)")
		end

feature --Commands

	play (player: STRING; position: INTEGER)
		--player places their mark on position if it is their turn
		require
			position >= 1 and position <= 9
		do
			if p1_turn then 	--X
				if player /~ player1 then
					if player ~ player2 then
						err_message := "not this player's turn: => " + player1 + " plays next"
					else
						err_message := "no such player: => " + player1 + " plays next"
					end
				else if board[position] /~ '_' then
					err_message := "button already taken: => " + player1 + " plays next"
				else
					board[position].set_item ('X')
					err_message := "ok: => " + player2 + " plays next"
					p1_turn := false
				end
				end
			else				--O
				if player /~ player2 then
					if player ~ player1 then
						err_message := "not this player's turn: => " + player2 + " plays next"
					else
						err_message := "no such player: => " + player2 + " plays next"
					end
				else if board[position] /~ '_' then
					err_message := "button already taken: => " + player2 + " plays next"
				else
					board[position].set_item ('O')
					err_message := "ok: => " + player1 + " plays next"
					p1_turn := true
				end
				end
			end
		end
end

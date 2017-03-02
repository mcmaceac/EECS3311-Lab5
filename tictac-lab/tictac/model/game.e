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
			start_player := player1
			p1_turn := true
			game_finished := false
			score := <<0, 0>>

			err_message := "ok:"
			next_instruction := player1 + " plays next"
			board := <<'_','_','_','_','_','_','_','_','_'>>
		end

feature {NONE}--Attributes

	player1: STRING
	player2: STRING
	start_player: STRING 	--used to track who goes first in each round
	p1_turn: BOOLEAN		--indicates X to be placed instead of O
	game_finished: BOOLEAN

	score: ARRAY[INTEGER]	--index 1 is player 1's score, index 2 is player 2's score

	err_message: STRING
	next_instruction: STRING
	board: ARRAY[CHARACTER]	--game board containing all marks

feature --Queries

	game_state: STRING
		do
			create Result.make_empty
			Result.append ("  " + err_message + " => " + next_instruction + "%N")
			Result.append ("  " + board[1].out + board[2].out + board[3].out + "%N")
			Result.append ("  " + board[4].out + board[5].out + board[6].out + "%N")
			Result.append ("  " + board[7].out + board[8].out + board[9].out + "%N")
			Result.append ("  " + score[1].out + ": score for %"" + player1 + "%" (as X)%N")
			Result.append ("  " + score[2].out + ": score for %"" + player2 + "%" (as O)")
		end

feature {NONE}
	winner: BOOLEAN
		--checks if there is a winner on the current board
		do
			Result := (board[1] ~ board[2] and board[2] ~ board[3] and board[1] /~ '_') or
					  (board[4] ~ board[5] and board[5] ~ board[6] and board[4] /~ '_') or
					  (board[7] ~ board[8] and board[8] ~ board[9] and board[7] /~ '_') or --3 horizontal wins

					  (board[1] ~ board[4] and board[4] ~ board[7] and board[1] /~ '_') or
					  (board[2] ~ board[5] and board[5] ~ board[8] and board[2] /~ '_') or
					  (board[3] ~ board[6] and board[6] ~ board[9] and board[3] /~ '_') or --3 vertical wins

					  (board[1] ~ board[5] and board[5] ~ board[9] and board[1] /~ '_') or
					  (board[3] ~ board[5] and board[5] ~ board[7] and board[3] /~ '_')    --2 cross wins
		end

feature --Commands

	play_again
		do
			if game_finished then
				board := <<'_','_','_','_','_','_','_','_','_'>>		--wiping board
				game_finished := false
				err_message := "ok:"
				if p1_turn then
					next_instruction := player1 + " plays next"
				else
					next_instruction := player2 + " plays next"
				end
			else
				err_message := "finish this game first:"
			end
		end

	play (player: STRING; position: INTEGER)
		--main game functionality. Performs the necessary checks to make sure the user
		--is entering the proper commands at the proper times. Does not check for 1..9
		--since this check is done by ETF
		local
			p1, p2: STRING
			mark: CHARACTER
			score_index: INTEGER  	--indicates the proper index for the score array depending on who's turn it is
		do
			if game_finished then
				err_message := "game is finished:"
			else
				if p1_turn then			--this ifelse is used to avoid unnecessary and ugly code duplication
					p1 := player1
					p2 := player2
					score_index := 1	--p1 turn
					mark := 'X'
				else
					p1 := player2
					p2 := player1
					score_index := 2	--p2 turn
					mark := 'O'
				end
				if player /~ p1 then
					if player ~ p2 then
						err_message := "not this player's turn:"
					else
						err_message := "no such player:"
					end
				else if board[position] /~ '_' then
					err_message := "button already taken:"
				else
					board.put (mark, position)
					--check to see if there is a winner after previous move
					if winner then
						err_message := "there is a winner:"
						next_instruction := "play again or start new game"
						score[score_index] := score[score_index] + 1
						game_finished := true
						if start_player ~ player1 then		--every round the player who starts alternates
							start_player := player2
							p1_turn := false
						else
							start_player := player1
							p1_turn := true
						end
					else
						err_message := "ok:"
						next_instruction := p2 + " plays next"
						p1_turn := not p1_turn --switching turns
					end
				end
				end
			end
		end

	reverse_play (player: STRING; position: INTEGER)
		do
			board.put ('_', position)	--remove mark from the board and alternate turn
			if p1_turn then				--if it was p1's turn, then the command must have come from p2
				next_instruction := player2 + " plays next"
			else
				next_instruction := player1 + " plays next"
			end
			p1_turn := not p1_turn
		end
end

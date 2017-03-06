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
	make
		do
			player1 := ""
			player2 := ""
			start_player := ""
			p1_turn := false
			score := <<0, 0>>
			wipe_board
			create history.make

			err_message := "ok: "
			next_instruction := "start new game"
		end

feature {NONE}--Attributes
	new_game_started: BOOLEAN	--this variable is needed because for some reason there is a
								--space in the error message for new game when you havent started a game already
								--vs if you have started a game already
	player1: STRING
	player2: STRING
	start_player: STRING 	--used to track who goes first in each round
	p1_turn: BOOLEAN		--indicates X to be placed instead of O

	score: ARRAY[INTEGER]	--index 1 is player 1's score, index 2 is player 2's score
	board: ARRAY[CHARACTER]	--game board containing all marks
	board_size: INTEGER = 3

feature --history of commands in game
	history: LINKED_LIST[COMMAND]

feature --Queries
	game_finished: BOOLEAN		--so the model can know when a game is finished
		do
			Result := winner	--if there is a winner the game is finished
		end

	err_message: STRING
	next_instruction: STRING

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

feature {NONE} --Privileged Commands

	wipe_board				--wipe the board according to the board size
		do
			create board.make_filled('_', 1, board_size * board_size)
		end

feature --Commands

	new_game (p1: STRING; p2: STRING)
		do
			if p1 ~ p2 and new_game_started then						--for some reason these two situations have different error messages
				err_message := "names of players must be different:"
			else if p1 ~ p2 and not new_game_started then
				err_message := "names of players must be different: "
			else
				new_game_started := true
				player1 := p1
				player2 := p2
				start_player := player1
				p1_turn := true
				score := <<0, 0>>
				wipe_board
				err_message := "ok:"
				next_instruction := player1 + " plays next"
			end
			end
		end

	play_again
		do
			if game_finished then
				wipe_board
				err_message := "ok:"
				history.wipe_out										--clear command history
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
				else																	--all checks passed
					board.put (mark, position)
					--check to see if there is a winner after previous move
					if winner then
						err_message := "there is a winner:"
						next_instruction := "play again or start new game"
						score[score_index] := score[score_index] + 1

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

	remove_all_right (index: INTEGER)
		--remove all items right of ith item
		local
			l: LINKED_LIST[COMMAND]
			i: INTEGER
		do
			create l.make
			from
				i := 1
				history.start
			until
				i > index
			loop
				l.extend (history.item)
				i := i + 1
				history.forth
			end
			history.wipe_out
			history.append (l)
		end

	reverse_play (player: STRING; position: INTEGER; err: STRING)
		do
			if not game_finished then		--only reverse a play if the game is not finished
				board.put ('_', position)	--remove mark from the board and alternate turn
				err_message := err
				if p1_turn then				--if it was p1's turn, then the command must have come from p2
					next_instruction := player2 + " plays next"
				else
					next_instruction := player1 + " plays next"
				end
				p1_turn := not p1_turn
			end
		end
end

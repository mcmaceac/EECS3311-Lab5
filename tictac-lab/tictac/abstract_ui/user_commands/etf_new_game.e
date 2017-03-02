note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_NEW_GAME
inherit
	ETF_NEW_GAME_INTERFACE
		redefine new_game end
create
	make
feature -- command
	new_game(player1: STRING ; player2: STRING)
		require else
			new_game_precond(player1, player2)
    	do
			-- perform some update on the model state

			if player1 ~ player2 then
				if attached model.g as game then
					game.err_message.make_from_string ("names of players must be different:")
					model.status.make_from_string (game.game_state)
				else
					model.status.make_empty
					model.status.append ("  names of players must be different:  => start new game%N")
					model.status.append ("  ___%N")
					model.status.append ("  ___%N")
					model.status.append ("  ___%N")
					model.status.append ("  0: score for %"%" (as X)%N")
					model.status.append ("  0: score for %"%" (as O)")
				end
			else
				model.new_game (player1, player2)
			end
			etf_cmd_container.on_change.notify ([Current])
    	end

end

note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_PLAY
inherit
	ETF_PLAY_INTERFACE
		redefine play end
	COMMAND
		undefine out end

create
	make

feature --attributes
	pos: detachable INTEGER_64
	p: detachable STRING

feature -- command
	play(player: STRING ; press: INTEGER_64)
		require else
			play_precond(player, press)
    	do
			-- perform some update on the model state
			if attached model.g as game then
				game.play (player, press.as_integer_32)
				p := player
				pos := press

				model.remove_all_right(model.history.index)
				model.history.extend (Current)
				model.history.finish
			else
				model.status.make_empty			--if there is no game made then there are no players
				model.status.append ("  no such player:  => start new game%N")
				model.status.append ("  ___%N")
				model.status.append ("  ___%N")
				model.status.append ("  ___%N")
				model.status.append ("  0: score for %"%" (as X)%N")
				model.status.append ("  0: score for %"%" (as O)")
			end
			etf_cmd_container.on_change.notify ([Current])
    	end

    undo
    	do
			if attached model.g as game and attached p as player and attached pos as position then
				game.reverse_play (player, position.as_integer_32)
			end
    	end

    redo
    	do
    		if attached model.g as game and attached p as player and attached pos as position then
				game.play (player, position.as_integer_32)
			end
    	end

end

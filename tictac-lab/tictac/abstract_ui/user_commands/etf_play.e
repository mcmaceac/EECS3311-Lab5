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
	err: detachable STRING

feature -- command
	play(player: STRING ; press: INTEGER_64)
		require else
			play_precond(player, press)
    	do
			-- perform some update on the model state
			err := model.g.err_message					--saving the current error message
			model.g.play (player, press.as_integer_32)
			p := player
			pos := press

			if not model.g.game_finished then						--game is still active
				model.g.remove_all_right(model.g.history.index)		--erasing so redo functions properly
				model.g.history.extend (Current)
				model.g.history.finish
			else													--game is finished, wipe the history
				model.g.history.wipe_out
			end

			etf_cmd_container.on_change.notify ([Current])
    	end

    undo
    	do
			if attached p as player and attached pos as position and attached err as err_m then
				model.g.reverse_play (player, position.as_integer_32, err_m)
			end
    	end

    redo
    	do
    		if attached p as player and attached pos as position then
				model.g.play (player, position.as_integer_32)
			end
    	end

end

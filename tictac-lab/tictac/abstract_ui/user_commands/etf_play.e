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
			model.g.play (player, press.as_integer_32)
			p := player
			pos := press

			model.g.remove_all_right(model.g.history.index)
			model.g.history.extend (Current)
			model.g.history.finish

			etf_cmd_container.on_change.notify ([Current])
    	end

    undo
    	do
			if attached p as player and attached pos as position then
				model.g.reverse_play (player, position.as_integer_32)
			end
    	end

    redo
    	do
    		if attached p as player and attached pos as position then
				model.g.play (player, position.as_integer_32)
			end
    	end

end

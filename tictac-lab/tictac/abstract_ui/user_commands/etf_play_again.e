note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_PLAY_AGAIN
inherit
	ETF_PLAY_AGAIN_INTERFACE
		redefine play_again end
	COMMAND
		undefine out end
create
	make

feature -- attributes
	err: detachable STRING
	next: detachable STRING

feature -- command
	play_again
    	do
			-- perform some update on the model state
			model.g.play_again

			err := "ok:"
			next := model.g.next_instruction
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
			if attached err as e and attached next as n then
				model.g.reverse_play_again(e, n)
			end
    	end

    redo
    	do
			--do nothing
    	end

end

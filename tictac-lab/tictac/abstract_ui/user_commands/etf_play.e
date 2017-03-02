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

create
	make

feature --attributes
	p: detachable STRING
	pos: detachable INTEGER_64

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
				model.history.extend (Current)
			else
				model.status.make_empty
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

    	end

end

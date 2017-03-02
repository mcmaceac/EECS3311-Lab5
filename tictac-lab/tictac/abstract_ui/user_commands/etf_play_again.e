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
create
	make
feature -- command
	play_again
    	do
			-- perform some update on the model state
			if attached model.g as game then
				game.play_again
			else							--no game started yet
				model.status.make_empty
				model.status.append ("  finish this game first:  => start new game%N")
				model.status.append ("  ___%N")
				model.status.append ("  ___%N")
				model.status.append ("  ___%N")
				model.status.append ("  0: score for %"%" (as X)%N")
				model.status.append ("  0: score for %"%" (as O)")
			end
			etf_cmd_container.on_change.notify ([Current])
    	end

end

note
	description: "A default business model."
	author: "Jackie Wang"
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_MODEL

inherit
	ANY
		redefine
			out
		end

create {ETF_MODEL_ACCESS}
	make

feature {NONE} -- Initialization
	make
			-- Initialization for `Current'.
		do
			create status.make_empty
			status.append ("  ok:  => start new game%N")
			status.append ("  ___%N")
			status.append ("  ___%N")
			status.append ("  ___%N")
			status.append ("  0: score for %"%" (as X)%N")
			status.append ("  0: score for %"%" (as O)")
			i := 0
		end

feature -- model attributes
	status : STRING
	i : INTEGER
	g: detachable GAME

feature -- model operations
	default_update
			-- Perform update to the model state.
		do
			i := i + 1
		end

	update_status
			-- Update the status based on the current game state
		do

		end

	reset
			-- Reset model state.
		do
			make
		end

feature -- queries
	out : STRING
		do
			create Result.make_from_string (status)
		end

end





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
			create history.make
		end

feature -- model attributes
	status : STRING
	i : INTEGER
	g: detachable GAME
	--history: LINKED_LIST[COMMAND]		--history of commands for undo / redo
	history: LINKED_LIST[COMMAND]

feature -- model operations
	default_update
			-- Perform update to the model state.
		do
			i := i + 1
		end

	reset
			-- Reset model state.
		do
			make
		end

feature -- queries
	out : STRING
		do
			if attached g as game then
				Result := game.game_state
			else
				create Result.make_from_string (status)
			end
		end

feature -- command
	new_game (p1: STRING; p2: STRING)
		do
			create history.make				--clearing the history
			create g.make (p1, p2)
			if attached g as game then
				status := game.game_state
			end
		end

end





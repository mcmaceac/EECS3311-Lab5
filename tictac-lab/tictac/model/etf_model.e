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
			i := 0
			create g.make
		end

feature -- model attributes
	i : INTEGER
	g: GAME
	--history: LINKED_LIST[COMMAND]		--history of commands for undo / redo

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
--			if attached g as game then
--				Result := game.game_state
--			else
--				create Result.make_from_string (status)
--			end
			Result := g.game_state
		end

end





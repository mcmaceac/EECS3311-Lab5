note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_REDO
inherit
	ETF_REDO_INTERFACE
		redefine redo end
create
	make
feature -- command
	redo
    	do
			-- perform some update on the model state
			if not_last then
				model.g.history.forth
				model.g.history.item.redo
			end
			etf_cmd_container.on_change.notify ([Current])
    	end

    not_last: BOOLEAN
    	do
    		Result := (not model.g.history.is_empty) and (not model.g.history.islast)
    	end

end

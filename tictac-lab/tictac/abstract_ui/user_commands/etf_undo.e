note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_UNDO
inherit
	ETF_UNDO_INTERFACE
		redefine undo end
create
	make
feature -- command
	undo
    	do
			-- perform some update on the model state
			if on_item then					--history is not empty and
				model.g.history.item.undo
				model.g.history.back
			end
			etf_cmd_container.on_change.notify ([Current])
    	end

    on_item: BOOLEAN
    	do
    		Result := (not model.g.history.is_empty) and (not model.g.history.before)
    	end

end

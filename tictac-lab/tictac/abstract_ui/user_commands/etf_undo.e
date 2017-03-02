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
			model.default_update
			if on_item then					--history is not empty and
				model.history.item.undo
				model.history.back
			end
			etf_cmd_container.on_change.notify ([Current])
    	end

    on_item: BOOLEAN
    	do
    		Result := (not model.history.is_empty) and (not model.history.before)
    	end

end

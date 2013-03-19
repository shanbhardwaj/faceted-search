class WinetypeFilter < ActiveRecord::Base
	searchable do
    	text :type_wine
    end
end

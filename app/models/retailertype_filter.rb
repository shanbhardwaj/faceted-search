class RetailertypeFilter < ActiveRecord::Base
	searchable do
    	text :stores
    end
end

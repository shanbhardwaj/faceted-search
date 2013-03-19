class SubregionFilter < ActiveRecord::Base
	searchable do
    	text :subregion_name
    end
end

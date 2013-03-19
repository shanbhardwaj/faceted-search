class RegionFilter < ActiveRecord::Base

	searchable do
    	text :region_name
    end
end

class VarietalFilter < ActiveRecord::Base
	searchable do
    	text :name
    end
end

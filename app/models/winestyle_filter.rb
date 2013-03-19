class WinestyleFilter < ActiveRecord::Base
	searchable do
    	text :style
    end
end

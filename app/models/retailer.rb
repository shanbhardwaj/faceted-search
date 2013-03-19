class Retailer < ActiveRecord::Base
	has_many :retailer_ledgers

	searchable do
    	text :retailer_name, :retailer_type
    	string :retailer_type
    	latlon(:location) { Sunspot::Util::Coordinates.new(lat, lng) unless lat.nil? or lng.nil? }
    end
end

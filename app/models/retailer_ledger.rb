class RetailerLedger < ActiveRecord::Base

belongs_to :wine

  # searchable do
  #   # string :store do
  #   #   :retailer_type
  #   # end

  #   latlon (:location) { Sunspot::Util::Coordinates.new(lat, lng) }
  # end

end

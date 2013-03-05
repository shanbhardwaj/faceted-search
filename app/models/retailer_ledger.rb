class RetailerLedger < ActiveRecord::Base

belongs_to :wine

  searchable do
    # text :wine_name, :boost => 5
    # text :region, :producer, :varietal, :year
    
    # string :region
    # string :producer
    # string :varietal
    string :store do
    	:retailer_type
    end

    location :coordinates do
           Sunspot::Util::Coordinates.new(lat, lng) 
       end        
  end

end

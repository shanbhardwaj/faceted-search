class Wine < ActiveRecord::Base
  attr_accessible :wine_name, :producer, :region, :varietal, :year

  has_many :retailer_ledgers

  searchable do
    text :wine_name, :boost => 5
    text :region, :producer, :varietal, :year
    string :region
    string :producer
    string :varietal

    latlon(:location, :multiple => true) do
      self.retailer_ledgers.map {|l| Sunspot::Util::Coordinates.new(l.lat, l.lng) }
    end

  end

end

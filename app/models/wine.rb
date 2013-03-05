class Wine < ActiveRecord::Base
  attr_accessible :wine_name, :producer, :region, :varietal, :year
  
  has_many :retailer_ledgers

  searchable do
    text :wine_name, :boost => 5
    text :region, :producer, :varietal, :year
    string :region
    string :producer
    string :varietal
  end
  
end

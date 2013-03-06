class Wine < ActiveRecord::Base
  attr_accessible :wine_name, :producer, :region, :varietal, :year

  has_many :retailer_ledgers
  has_many :wine_reviews

  searchable do
    text :wine_name, :boost => 5
    text :region, :producer, :varietal, :year
    string :region
    string :sub_region
    string :producer
    string :varietal
    string :wine_type
    float :expert_rating
    string :white_varietal
    string :red_varietal
    string :champagne_varietal
    string :year
    integer(:retailer_id, :multiple => true) do
      if retailer_ledgers.present?
        self.retailer_ledgers.map { |l| l.retailer_id if l.in_stock and l.retailer.present?}
      end
    end
    string(:review, :multiple => true) do
      if wine_reviews.present?
        self.wine_reviews.map { |r| r.expert }
      end
    end
    string(:retailer_type, :multiple => true) do
      if retailer_ledgers.present? 
        self.retailer_ledgers.map { |l| l.retailer.retailer_type unless (l.retailer.nil? or !l.in_stock) }
      end
    end
    latlon(:location, :multiple => true) do
      if retailer_ledgers.present? 
        self.retailer_ledgers.map {|l| Sunspot::Util::Coordinates.new(l.lat, l.lng) if l.in_stock }
      end
    end
    string(:size, :multiple => true) do
      if retailer_ledgers.present?
        self.retailer_ledgers.map { |l| l.bottlesize if l.in_stock}
      end
    end

  end

  def expert_rating
    rating = nil
    total = 0
    wine_reviews.each do |rev|
      total += rev.rating
    end
    rating = total.to_f/wine_reviews.count unless wine_reviews.count <= 0
    return rating
  end

  def red_varietal
    if wine_type == "Red"
      return varietal
    end
  end
  def white_varietal
    if wine_type == "White"
      return varietal
    end
  end
  def champagne_varietal
    if wine_type == "Sparkling/Champagne"
      return varietal
    end
  end

end

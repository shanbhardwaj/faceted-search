class RetailerLedger < ActiveRecord::Base

belongs_to :wine
belongs_to :retailer

  # searchable do
  #   # string :store do
  #   #   :retailer_type
  #   # end

  #   latlon (:location) { Sunspot::Util::Coordinates.new(lat, lng) }
  # end

  searchable do
    text(:wine_name, :boost => 5) { wine.wine_name unless wine.nil?}
    # text :region, :producer, :varietal, :year
    string(:region) { wine.region unless wine.nil? }
    string(:sub_region) { wine.sub_region unless wine.nil? }
    string(:producer) { wine.producer unless wine.nil?}
    string(:varietal) { wine.varietal unless wine.nil? }
    string (:wine_type) { wine.wine_type unless wine.nil? }
    float :expert_rating
    string :white_varietal
    string :red_varietal
    string :champagne_varietal
    string(:year){ wine.year unless wine.nil? }
    # integer(:retailer_id, :multiple => true) do
    #   if retailer_ledgers.present?
    #     self.retailer_ledgers.map { |l| l.retailer_id if l.in_stock and l.retailer.present?}
    #   end
    # end
    string(:review, :multiple => true) do
      if wine.present? and wine.wine_reviews.present?
        wine.wine_reviews.map { |r| r.expert }
      end
    end
    string(:retailer_type) { retailer.retailer_type unless retailer.nil? }
    boolean :in_stock
    latlon(:location) { Sunspot::Util::Coordinates.new(retailer.lat, retailer.lng) unless retailer.nil? }
    string :bottlesize
    string :wine_group_str
    string :retailer_type_group_str
    string(:retailer_id_str) { retailer_id.to_s}
    string(:wine_id_str) { wine_id.to_s}
    integer :retailer_id
    integer :wine_id, :stored => true

  end

  def wine_group_str
    return wine_id.to_s + "," + bottlesize
  end

  def retailer_type_group_str
    return wine_id.to_s + "," + retailer.retailer_type unless retailer.nil? 
  end

  def expert_rating
    rating = nil
    total = 0
    if wine.present?
      wine.wine_reviews.each do |rev|
        total += rev.rating if rev.rating.present?
      end
      rating = total.to_f/wine.wine_reviews.count unless wine.wine_reviews.count <= 0
    end
    return rating
  end

  def red_varietal
    if wine and wine.wine_type == "Red"
      return wine.varietal
    end
  end
  def white_varietal
    if wine and wine.wine_type == "White"
      return wine.varietal
    end
  end
  def champagne_varietal
    if wine and wine.wine_type == "Sparkling/Champagne"
      return wine.varietal
    end
  end

end

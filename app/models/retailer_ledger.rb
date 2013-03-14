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
    float :price
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
    string :wine_price_group_str
    string(:retailer_id_str) { retailer_id.to_s}
    string(:wine_id_str) { wine_id.to_s}
    integer :retailer_id
    integer :wine_id, :stored => true
    integer :value

  end

  def wine_group_str
    return wine_id.to_s + "," + bottlesize
  end

  def retailer_type_group_str
    return wine_id.to_s + "," + retailer.retailer_type unless retailer.nil? 
  end

  def expert_rating
    if wine.present?
     return wine.expert_points
   end
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

  def wine_price_group_str
    if price.present?
      if price < 10
        return wine_id.to_s + ",under10"
      elsif price < 20
        return wine_id.to_s + ",10-20"
      elsif price < 30
        return wine_id.to_s + ",20-30"
      elsif price < 50
        return wine_id.to_s + ",30-50"
      elsif price >= 50
        return wine_id.to_s + ",50+"
      end
    end
  end

  def value_img
    if value == 1
      return "/assets/goodvalue.png"
    elsif value == 2
      return "/assets/excellent.png"
    elsif value == 3
      return "/assets/incredible.png"
    end
    return ""
  end


end

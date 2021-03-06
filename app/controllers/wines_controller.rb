class WinesController < ApplicationController
  # GET /wines
  # GET /wines.xml
  def index
    lat = 34.0126379
    lng = -118.495155
    size = (params[:bottlesize])? params[:bottlesize] : "750ML"
    page = (params[:page])? params[:page] : 1
    # params[:retailer_type] = params[:retailer_type].split(",") if params[:retailer_type].present?
    params[:varietal] = params[:varietal].split(",") if params[:varietal].present?
    params[:region] = params[:region].split(",") if params[:region].present?
    params[:sub_region] = params[:sub_region].split(",") if params[:sub_region].present?
    params[:wine_type] = params[:wine_type].split(",") if params[:wine_type].present?
    @search = RetailerLedger.search do
      group :wine_group_str do
        order_by(:price, :asc)
        truncate
      end
      if params[:sort].present?
        order = ((params[:order].nil?)? "asc" : params[:order])
        order_by(params[:sort], order)
      else
        order_by(:value,:asc)
      end
      if params[:sfield]
        fulltext params[:search] do
          fields(params[:sfield])
        end
      else
        fulltext params[:search]
      end
      if params[:distance].blank? and params[:retailer_type].blank?
        any_of do
          with(:location).in_radius(lat, lng, 50)
          with(:retailer_type, "Online Store") 
        end
      end
      size_filter = with(:bottlesize, size)
      with(:in_stock, true)
      with(:varietal, params[:varietal]) if params[:varietal].present?
      with(:producer, params[:producer]) if params[:producer].present?
      with(:region, params[:region]) if params[:region].present?
      with(:retailer_type, params[:retailer_type]) if params[:retailer_type].present?
      with(:bottlesize, params[:bottlesize]) if params[:bottlesize].present?
      with(:sub_region, params[:sub_region]) if params[:sub_region].present?
      with(:wine_type, params[:wine_type]) if params[:wine_type].present?
      with(:white_varietal, params[:white_varietal]) if params[:white_varietal].present?
      with(:red_varietal, params[:red_varietal]) if params[:red_varietal].present?
      with(:champagne_varietal, params[:champagne_varietal]) if params[:champagne_varietal].present?
      with(:year, params[:year]) if params[:year].present?
      with(:review, params[:review]) if params[:review].present?
      with(:style, params[:style]) if params[:style].present?
      if params[:distance].present?
        loc = params[:distance].split("..")
        all_of do
          without(:location).in_radius(lat, lng, loc[0].to_i) unless loc[0] == "0"
          with(:location).in_radius(lat, lng, loc[1].to_i) 
        end
      end
      if params[:expert_rating].present?
        rat = params[:expert_rating].split("..")
        if rat.count == 1
        # case of "below 80"
        with(:expert_rating).less_than 80
      else
       all_of do
        with(:expert_rating).less_than(rat[1].to_i) unless rat[1] == "100"
        with(:expert_rating).greater_than_or_equal_to(rat[0].to_i)
      end
    end
  end
  if params[:price].present?
    price = params[:price].gsub("Under","").gsub("$","").strip.split(" - ")
    if price.length > 1
      all_of do
        with(:price).less_than(price[1].strip.to_i)
        with(:price).greater_than_or_equal_to(price[0].strip.to_i)
      end
    elsif price[0].index("+").present?
      price = price[0].gsub("+","").strip
      with(:price).greater_than_or_equal_to(price.to_i)
    else
      with(:price).less_than(price[0].to_i)
    end
  end
    # with(:distance, params[:distance]) if params[:distance].present?
    # with(:expert_rating, params[:expert_rating]) if params[:expert_rating].present?

    facet :varietal, :limit => 5
    facet :producer, :region, :sub_region, :wine_type, :white_varietal, :red_varietal,:champagne_varietal, :year, :review, :limit => 5
    facet :bottlesize, :exclude => size_filter, :limit => 5
    facet(:expert_rating) do
      row(95..100) do
        with(:expert_rating).greater_than_or_equal_to(95.0)
      end
      row(90..95) do
        all_of do
         with(:expert_rating).greater_than_or_equal_to(90.0)
         with(:expert_rating).less_than(95.0)
       end
     end
     row(85..90) do
      all_of do
       with(:expert_rating).greater_than_or_equal_to(85.0)
       with(:expert_rating).less_than(90.0)
     end
   end
   row(80..85) do
    all_of do
     with(:expert_rating).greater_than_or_equal_to(80.0)
     with(:expert_rating).less_than(85.0)
   end
 end
 row("below 80") do
  with(:expert_rating).less_than(80.0)
end
end
paginate :page => page, :per_page => 30

end


@retailerType = RetailerLedger.search do
  group :retailer_type_group_str do
    truncate
  end

  if params[:sfield]
    fulltext params[:search] do
     fields(params[:sfield])
    end
  else
    fulltext params[:search]
  end
  if params[:distance].blank? and params[:retailer_type].blank?
    any_of do
      with(:location).in_radius(lat, lng, 50)
      with(:retailer_type, "Online Store")
    end
  end
  with(:bottlesize, size)
  with(:in_stock, true)
  with(:varietal, params[:varietal]) if params[:varietal].present?
  with(:producer, params[:producer]) if params[:producer].present?
  with(:region, params[:region]) if params[:region].present?
  with(:retailer_type, params[:retailer_type]) if params[:retailer_type].present?
  with(:bottlesize, params[:bottlesize]) if params[:bottlesize].present?
  with(:sub_region, params[:sub_region]) if params[:sub_region].present?
  with(:wine_type, params[:wine_type]) if params[:wine_type].present?
  with(:white_varietal, params[:white_varietal]) if params[:white_varietal].present?
  with(:red_varietal, params[:red_varietal]) if params[:red_varietal].present?
  with(:champagne_varietal, params[:champagne_varietal]) if params[:champagne_varietal].present?
  with(:year, params[:year]) if params[:year].present?
  with(:review, params[:review]) if params[:review].present?
  with(:style, params[:style]) if params[:style].present?
  if params[:distance].present?
    loc = params[:distance].split("..")
    all_of do
      without(:location).in_radius(lat, lng, loc[0].to_i) unless loc[0] == "0"
      with(:location).in_radius(lat, lng, loc[1].to_i) 
    end
  end
  if params[:expert_rating].present?
    rat = params[:expert_rating].split("..")
    if rat.count == 1
        # case of "below 80"
        with(:expert_rating).less_than 80
      else
       all_of do
        with(:expert_rating).less_than(rat[1].to_i) unless rat[1] == "100"
        with(:expert_rating).greater_than_or_equal_to(rat[0].to_i)
      end
    end
  end
  if params[:price].present?
    price = params[:price].gsub("Under","").gsub("$","").strip.split(" - ")
    if price.length > 1
      all_of do
        with(:price).less_than(price[1].strip.to_i)
        with(:price).greater_than_or_equal_to(price[0].strip.to_i)
      end
    elsif price[0].index("+").present?
      price = price[0].gsub("+","").strip
      with(:price).greater_than_or_equal_to(price.to_i)
    else
      with(:price).less_than(price[0].to_i)
    end
  end
  facet :retailer_type 
end

@priceGroup = RetailerLedger.search do
  group :wine_price_group_str do
    truncate
  end

  if params[:sfield]
    fulltext params[:search] do
      fields(params[:sfield])
    end
  else
    fulltext params[:search]
  end
  if params[:distance].blank? and params[:retailer_type].blank?
    any_of do
      with(:location).in_radius(lat, lng, 50)
      with(:retailer_type, "Online Store")
    end
  end
  with(:bottlesize, size)
  with(:in_stock, true)
  with(:varietal, params[:varietal]) if params[:varietal].present?
  with(:producer, params[:producer]) if params[:producer].present?
  with(:region, params[:region]) if params[:region].present?
  with(:retailer_type, params[:retailer_type]) if params[:retailer_type].present?
  with(:bottlesize, params[:bottlesize]) if params[:bottlesize].present?
  with(:sub_region, params[:sub_region]) if params[:sub_region].present?
  with(:wine_type, params[:wine_type]) if params[:wine_type].present?
  with(:white_varietal, params[:white_varietal]) if params[:white_varietal].present?
  with(:red_varietal, params[:red_varietal]) if params[:red_varietal].present?
  with(:champagne_varietal, params[:champagne_varietal]) if params[:champagne_varietal].present?
  with(:year, params[:year]) if params[:year].present?
  with(:review, params[:review]) if params[:review].present?
  with(:style, params[:style]) if params[:style].present?
  if params[:distance].present?
    loc = params[:distance].split("..")
    all_of do
      without(:location).in_radius(lat, lng, loc[0].to_i) unless loc[0] == "0"
      with(:location).in_radius(lat, lng, loc[1].to_i) 
    end
  end
  if params[:expert_rating].present?
    rat = params[:expert_rating].split("..")
    if rat.count == 1
        # case of "below 80"
        with(:expert_rating).less_than 80
      else
       all_of do
        with(:expert_rating).less_than(rat[1].to_i) unless rat[1] == "100"
        with(:expert_rating).greater_than_or_equal_to(rat[0].to_i)
      end
    end
  end
  if params[:price].present?
    price = params[:price].gsub("Under","").gsub("$","").strip.split(" - ")
    if price.length > 1
      all_of do
        with(:price).less_than(price[1].strip.to_i)
        with(:price).greater_than_or_equal_to(price[0].strip.to_i)
      end
    elsif price[0].index("+").present?
      price = price[0].gsub("+","").strip
      with(:price).greater_than_or_equal_to(price.to_i)
    else
      with(:price).less_than(price[0].to_i)
    end
  end
  facet(:price) do
    row("Under $10") do
      with(:price).less_than(10.0)
    end
    row("$10 - $20") do
      all_of do
        with(:price).less_than(20.0)
        with(:price).greater_than_or_equal_to(10.0)
      end
    end
    row("$20 - $30") do
      all_of do
        with(:price).less_than(30.0)
        with(:price).greater_than_or_equal_to(20.0)
      end
    end
    row("$30 - $50") do
      all_of do
        with(:price).less_than(50.0)
        with(:price).greater_than_or_equal_to(30.0)
      end
    end
    row("$50+") do
      with(:price).greater_than_or_equal_to(50.0)
    end
  end
end


if params[:distance].nil?
  @distance_0to1 = RetailerLedger.search do
    group :wine_group_str do
      truncate
    end

    if params[:sfield]
        fulltext params[:search] do
          fields(params[:sfield])
        end
      else
        fulltext params[:search]
      end
      # any_of do
      with(:location).in_radius(lat, lng, 1)
        # with(:retailer_type, "Online Store")
      # end
      with(:bottlesize, size)
      with(:in_stock, true)
      with(:varietal, params[:varietal]) if params[:varietal].present?
      with(:producer, params[:producer]) if params[:producer].present?
      with(:region, params[:region]) if params[:region].present?
      with(:retailer_type, params[:retailer_type]) if params[:retailer_type].present?
      with(:bottlesize, params[:bottlesize]) if params[:bottlesize].present?
      with(:sub_region, params[:sub_region]) if params[:sub_region].present?
      with(:wine_type, params[:wine_type]) if params[:wine_type].present?
      with(:white_varietal, params[:white_varietal]) if params[:white_varietal].present?
      with(:red_varietal, params[:red_varietal]) if params[:red_varietal].present?
      with(:champagne_varietal, params[:champagne_varietal]) if params[:champagne_varietal].present?
      with(:year, params[:year]) if params[:year].present?
      with(:review, params[:review]) if params[:review].present?
      with(:style, params[:style]) if params[:style].present?
      # with(:location).in_radius(lat, lng, 1)
      if params[:expert_rating].present?
        rat = params[:expert_rating].split("..")
        if rat.count == 1
          # case of "below 80"
          with(:expert_rating).less_than 80
        else
         all_of do
          with(:expert_rating).less_than(rat[1].to_i) unless rat[1] == "100"
          with(:expert_rating).greater_than_or_equal_to(rat[0].to_i)
        end
      end
    end
    if params[:price].present?
      price = params[:price].gsub("Under","").gsub("$","").strip.split(" - ")
      if price.length > 1
        all_of do
          with(:price).less_than(price[1].strip.to_i)
          with(:price).greater_than_or_equal_to(price[0].strip.to_i)
        end
      elsif price[0].index("+").present?
        price = price[0].gsub("+","").strip
        with(:price).greater_than_or_equal_to(price.to_i)
      else
        with(:price).less_than(price[0].to_i)
      end
    end
  end
end
@distance_1to3 = RetailerLedger.search do
  group :wine_group_str do
    truncate
  end

  if params[:sfield]
        fulltext params[:search] do
          fields(params[:sfield])
        end
      else
        fulltext params[:search]
      end
  all_of do
    without(:location).in_radius(lat, lng, 1)
    with(:location).in_radius(lat, lng, 3)
        # with(:retailer_type, "Online Store")
      end
      with(:bottlesize, size)
      with(:in_stock, true)
      with(:varietal, params[:varietal]) if params[:varietal].present?
      with(:producer, params[:producer]) if params[:producer].present?
      with(:region, params[:region]) if params[:region].present?
      with(:retailer_type, params[:retailer_type]) if params[:retailer_type].present?
      with(:bottlesize, params[:bottlesize]) if params[:bottlesize].present?
      with(:sub_region, params[:sub_region]) if params[:sub_region].present?
      with(:wine_type, params[:wine_type]) if params[:wine_type].present?
      with(:white_varietal, params[:white_varietal]) if params[:white_varietal].present?
      with(:red_varietal, params[:red_varietal]) if params[:red_varietal].present?
      with(:champagne_varietal, params[:champagne_varietal]) if params[:champagne_varietal].present?
      with(:year, params[:year]) if params[:year].present?
      with(:review, params[:review]) if params[:review].present?
      with(:style, params[:style]) if params[:style].present?
      # with(:location).in_radius(lat, lng, 1)
      if params[:expert_rating].present?
        rat = params[:expert_rating].split("..")
        if rat.count == 1
          # case of "below 80"
          with(:expert_rating).less_than 80
        else
         all_of do
          with(:expert_rating).less_than(rat[1].to_i) unless rat[1] == "100"
          with(:expert_rating).greater_than_or_equal_to(rat[0].to_i)
        end
      end
    end
    if params[:price].present?
      price = params[:price].gsub("Under","").gsub("$","").strip.split(" - ")
      if price.length > 1
        all_of do
          with(:price).less_than(price[1].strip.to_i)
          with(:price).greater_than_or_equal_to(price[0].strip.to_i)
        end
      elsif price[0].index("+").present?
        price = price[0].gsub("+","").strip
        with(:price).greater_than_or_equal_to(price.to_i)
      else
        with(:price).less_than(price[0].to_i)
      end
    end
  end
  @distance_3to5 = RetailerLedger.search do
    group :wine_group_str do
      truncate
    end

    if params[:sfield]
        fulltext params[:search] do
          fields(params[:sfield])
        end
      else
        fulltext params[:search]
      end
    all_of do
      without(:location).in_radius(lat, lng, 3)
      with(:location).in_radius(lat, lng, 5)
        # with(:retailer_type, "Online Store")
      end
      with(:bottlesize, size)
      with(:in_stock, true)
      with(:varietal, params[:varietal]) if params[:varietal].present?
      with(:producer, params[:producer]) if params[:producer].present?
      with(:region, params[:region]) if params[:region].present?
      with(:retailer_type, params[:retailer_type]) if params[:retailer_type].present?
      with(:bottlesize, params[:bottlesize]) if params[:bottlesize].present?
      with(:sub_region, params[:sub_region]) if params[:sub_region].present?
      with(:wine_type, params[:wine_type]) if params[:wine_type].present?
      with(:white_varietal, params[:white_varietal]) if params[:white_varietal].present?
      with(:red_varietal, params[:red_varietal]) if params[:red_varietal].present?
      with(:champagne_varietal, params[:champagne_varietal]) if params[:champagne_varietal].present?
      with(:year, params[:year]) if params[:year].present?
      with(:review, params[:review]) if params[:review].present?
      with(:style, params[:style]) if params[:style].present?
      # with(:location).in_radius(lat, lng, 1)
      if params[:expert_rating].present?
        rat = params[:expert_rating].split("..")
        if rat.count == 1
          # case of "below 80"
          with(:expert_rating).less_than 80
        else
         all_of do
          with(:expert_rating).less_than(rat[1].to_i) unless rat[1] == "100"
          with(:expert_rating).greater_than_or_equal_to(rat[0].to_i)
        end
      end
    end
    if params[:price].present?
      price = params[:price].gsub("Under","").gsub("$","").strip.split(" - ")
      if price.length > 1
        all_of do
          with(:price).less_than(price[1].strip.to_i)
          with(:price).greater_than_or_equal_to(price[0].strip.to_i)
        end
      elsif price[0].index("+").present?
        price = price[0].gsub("+","").strip
        with(:price).greater_than_or_equal_to(price.to_i)
      else
        with(:price).less_than(price[0].to_i)
      end
    end
  end
  @distance_5to25 = RetailerLedger.search do
    group :wine_group_str do
      truncate
    end

    if params[:sfield]
        fulltext params[:search] do
          fields(params[:sfield])
        end
      else
        fulltext params[:search]
      end
    all_of do
      without(:location).in_radius(lat, lng, 5)
      with(:location).in_radius(lat, lng, 25)
        # with(:retailer_type, "Online Store")
      end
      with(:bottlesize, size)
      with(:in_stock, true)
      with(:varietal, params[:varietal]) if params[:varietal].present?
      with(:producer, params[:producer]) if params[:producer].present?
      with(:region, params[:region]) if params[:region].present?
      with(:retailer_type, params[:retailer_type]) if params[:retailer_type].present?
      with(:bottlesize, params[:bottlesize]) if params[:bottlesize].present?
      with(:sub_region, params[:sub_region]) if params[:sub_region].present?
      with(:wine_type, params[:wine_type]) if params[:wine_type].present?
      with(:white_varietal, params[:white_varietal]) if params[:white_varietal].present?
      with(:red_varietal, params[:red_varietal]) if params[:red_varietal].present?
      with(:champagne_varietal, params[:champagne_varietal]) if params[:champagne_varietal].present?
      with(:year, params[:year]) if params[:year].present?
      with(:review, params[:review]) if params[:review].present?
      with(:style, params[:style]) if params[:style].present?
      # with(:location).in_radius(lat, lng, 1)
      if params[:expert_rating].present?
        rat = params[:expert_rating].split("..")
        if rat.count == 1
          # case of "below 80"
          with(:expert_rating).less_than 80
        else
         all_of do
          with(:expert_rating).less_than(rat[1].to_i) unless rat[1] == "100"
          with(:expert_rating).greater_than_or_equal_to(rat[0].to_i)
        end
      end
    end
    if params[:price].present?
      price = params[:price].gsub("Under","").gsub("$","").strip.split(" - ")
      if price.length > 1
        all_of do
          with(:price).less_than(price[1].strip.to_i)
          with(:price).greater_than_or_equal_to(price[0].strip.to_i)
        end
      elsif price[0].index("+").present?
        price = price[0].gsub("+","").strip
        with(:price).greater_than_or_equal_to(price.to_i)
      else
        with(:price).less_than(price[0].to_i)
      end
    end
  end
   # @wines = []
  # @wines = @search.results.wines
    # wine_ids = @search.group(:wine_group_str).groups.map { |p| p.value.split(",")[0].to_i }
    
    # @wines = Wine.where(:id => wine_ids).order('FIELD (id,'+wine_ids.to_s.gsub("]","").gsub("[","")+')')
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @wines }
    end
  end

  # GET /wines/1
  # GET /wines/1.xml
  def show
    @wine = Wine.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @wine }
    end
  end

  # GET /wines/new
  # GET /wines/new.xml
  def new
    @wine = Wine.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @wine }
    end
  end

  # GET /wines/1/edit
  def edit
    @wine = Wine.find(params[:id])
  end

  # POST /wines
  # POST /wines.xml
  def create
    @wine = Wine.new(params[:wine])

    respond_to do |format|
      if @wine.save
        format.html { redirect_to(@wine, :notice => 'Wine was successfully created.') }
        format.xml  { render :xml => @wine, :status => :created, :location => @wine }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @wine.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /wines/1
  # PUT /wines/1.xml
  def update
    @wine = Wine.find(params[:id])

    respond_to do |format|
      if @wine.update_attributes(params[:wine])
        format.html { redirect_to(@wine, :notice => 'Wine was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @wine.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /wines/1
  # DELETE /wines/1.xml
  def destroy
    @wine = Wine.find(params[:id])
    @wine.destroy

    respond_to do |format|
      format.html { redirect_to(wines_url) }
      format.xml  { head :ok }
    end
  end

  # Header Search
  def hsearch_drpdwn
    search = params[:search]
    @d = 1
    @m = 0
    lat = 34.0126379
    lng = -118.495155
    if search.present? and search.length > 0

      # Retailer Type
      @retailerTypes = Retailer.search do
        fulltext search do
          fields(:retailer_type)
        end
        group :retailer_type do
          truncate
        end
        any_of do
          with(:location).in_radius(lat,lng,50)
          with(:retailer_type, "Online Store")
        end
      end
      @m += @retailerTypes.total

      # Stores
      @stores = Retailer.search do
        fulltext search do
          fields(:retailer_name)
        end
        any_of do
          with(:retailer_type, 'Wine Store')
          with(:retailer_type, 'Liquor Store')
          with(:retailer_type, 'Grocery Store')
          with(:retailer_type, 'Wholesalers')
          with(:retailer_type, 'Grocery & Wine Store')
          with(:retailer_type, 'Online Store')
        end
        any_of do
          with(:location).in_radius(lat,lng,50)
          with(:retailer_type, "Online Store")
        end
      end
      @m += @stores.total

      # Restaurants & Bars
      @restbars = Retailer.search do
        fulltext search do
          fields(:retailer_name)
        end
        any_of do
          with(:retailer_type, 'Restaurant')
          with(:retailer_type, 'Bar')
          with(:retailer_type, 'Wine Bar')
          with(:retailer_type, 'Tasting Room')
          with(:retailer_type, 'Bring-Your-Own')
          with(:retailer_type, 'Restaurant & Bar')
          with(:retailer_type, 'Bring-Your-Own')
        end
          with(:location).in_radius(lat,lng,50)
      end
      @m += @restbars.total

      # Producer
      @producer = RetailerLedger.search do
        fulltext search do
          fields(:producer)
        end
        group :producer do
          truncate
        end
        any_of do
          with(:location).in_radius(lat,lng,50)
          with(:retailer_type, 'Online Store')
        end
        with(:bottlesize, "750ML")
        with(:in_stock, true)
      end

      # Wine Type
      @wineTypes = RetailerLedger.search do
        fulltext search do
          fields(:wine_type)
        end
        group :wine_type do
          truncate
        end
        any_of do
          with(:location).in_radius(lat,lng,50)
          with(:retailer_type, 'Online Store')
        end
        with(:bottlesize, "750ML")
        with(:in_stock, true)
      end
      @m += @wineTypes.total

      # Varietals
      @varietals = RetailerLedger.search do
        fulltext search do
          fields(:varietal)
        end
        group :varietal_type_str do
            truncate
        end
        any_of do
          with(:location).in_radius(lat,lng,50)
          with(:retailer_type, 'Online Store')
        end
        with(:bottlesize, "750ML")
        with(:in_stock, true)
      end
      @m += @varietals.total

      # Region
      @regions = RetailerLedger.search do
        fulltext search do
          fields(:region)
        end
        group :region do
          truncate
        end
        any_of do
          with(:location).in_radius(lat,lng,50)
          with(:retailer_type, 'Online Store')
        end
        with(:bottlesize, "750ML")
        with(:in_stock, true)
      end
      @m += @regions.total

      # Sub-region
      @subRegions = RetailerLedger.search do
        fulltext search do
          fields(:sub_region)
        end
        group :sub_region do
          truncate
        end
        any_of do
          with(:location).in_radius(lat,lng,50)
          with(:retailer_type, 'Online Store')
        end
        with(:bottlesize, "750ML")
        with(:in_stock, true)
      end
      @m += @subRegions.total

      # Adjectives

      # Styles
      # @wineStyles = WinestyleFilter.search do
      #   fulltext search
      # end
      # @m += @wineStyles.total

      # Wine Name
      @wines = RetailerLedger.search do
        fulltext search do
          fields(:wine_name)
        end
        group :wine_group_str do
          truncate
        end
        any_of do
          with(:location).in_radius(lat,lng,50)
          with(:retailer_type, 'Online Store')
        end
        with(:bottlesize, "750ML")
        with(:in_stock, true)
      end
      @m += @wines.total
    end
    respond_to do |format|
      format.js
    end
  end


  def hsearch
    search = (params[:search].present?) ? params[:search] : ""
    @m = 1
    lat = 34.0126379
    lng = -118.495155
    # search = ""
    # if search.present? and search.length > 0

      # Retailer Type
      @retailerTypes = Retailer.search do
        fulltext search do
          fields(:retailer_type)
        end
        group :retailer_type do
          truncate
        end
        any_of do
          with(:location).in_radius(lat,lng,50)
          with(:retailer_type, "Online Store")
        end
      end
      @m += @retailerTypes.total

      # Stores
      @stores = Retailer.search do
        fulltext search do
          fields(:retailer_name)
        end
        any_of do
          with(:retailer_type, 'Wine Store')
          with(:retailer_type, 'Liquor Store')
          with(:retailer_type, 'Grocery Store')
          with(:retailer_type, 'Wholesalers')
          with(:retailer_type, 'Grocery & Wine Store')
          with(:retailer_type, 'Online Store')
        end
        any_of do
          with(:location).in_radius(lat,lng,50)
          with(:retailer_type, "Online Store")
        end
      end
      @m += @stores.total

      # Restaurants & Bars
      @restbars = Retailer.search do
        fulltext search do
          fields(:retailer_name)
        end
        any_of do
          with(:retailer_type, 'Restaurant')
          with(:retailer_type, 'Bar')
          with(:retailer_type, 'Wine Bar')
          with(:retailer_type, 'Tasting Room')
          with(:retailer_type, 'Bring-Your-Own')
          with(:retailer_type, 'Restaurant & Bar')
          with(:retailer_type, 'Bring-Your-Own')
        end
          with(:location).in_radius(lat,lng,50)
      end
      @m += @restbars.total

      # Producer
      @producer = RetailerLedger.search do
        fulltext search do
          fields(:producer)
        end
        group :wine_group_str do
          truncate
        end
        any_of do
          with(:location).in_radius(lat,lng,50)
          with(:retailer_type, 'Online Store')
        end
        with(:bottlesize, "750ML")
        with(:in_stock, true)
      end

      # Wine Type
      @wineTypes = RetailerLedger.search do
        fulltext search do
          fields(:wine_type)
        end
        group :wine_group_str do
          truncate
        end
        any_of do
          with(:location).in_radius(lat,lng,50)
          with(:retailer_type, 'Online Store')
        end
        with(:bottlesize, "750ML")
        with(:in_stock, true)
      end
      @m += @wineTypes.total

      # Varietals
      @varietals = RetailerLedger.search do
        fulltext search do
          fields(:varietal)
        end
        group :wine_group_str do
            truncate
        end
        any_of do
          with(:location).in_radius(lat,lng,50)
          with(:retailer_type, 'Online Store')
        end
        with(:bottlesize, "750ML")
        with(:in_stock, true)
      end
      @m += @varietals.total

      # Region
      @regions = RetailerLedger.search do
        fulltext search do
          fields(:region)
        end
        group :wine_group_str do
          truncate
        end
        any_of do
          with(:location).in_radius(lat,lng,50)
          with(:retailer_type, 'Online Store')
        end
        with(:bottlesize, "750ML")
        with(:in_stock, true)
      end
      @m += @regions.total

      # Sub-region
      @subRegions = RetailerLedger.search do
        fulltext search do
          fields(:sub_region)
        end
        group :wine_group_str do
          truncate
        end
        any_of do
          with(:location).in_radius(lat,lng,50)
          with(:retailer_type, 'Online Store')
        end
        with(:bottlesize, "750ML")
        with(:in_stock, true)
      end
      @m += @subRegions.total

      # Adjectives

      # Styles
      # @wineStyles = WinestyleFilter.search do
      #   fulltext search
      # end
      # @m += @wineStyles.total

      # Wine Name
      @wines = RetailerLedger.search do
        fulltext search do
          fields(:wine_name)
        end
        group :wine_group_str do
          truncate
        end
        any_of do
          with(:location).in_radius(lat,lng,50)
          with(:retailer_type, 'Online Store')
        end
        with(:bottlesize, "750ML")
        with(:in_stock, true)
      end
      @m += @wines.total
    # end

  end
end

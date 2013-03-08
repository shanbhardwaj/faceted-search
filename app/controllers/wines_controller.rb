class WinesController < ApplicationController
  # GET /wines
  # GET /wines.xml
  def index
    lat = 34.0126379
    lng = -118.495155
    size = (params[:bottlesize])? params[:bottlesize] : "750ML"
    page = (params[:page])? params[:page] : 1
  @search = RetailerLedger.search do
    group :group_str do
        truncate
    end
      
    fulltext params[:search]
    any_of do
      with(:location).in_radius(lat, lng, 15)
      with(:retailer_type, "Online Store")
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
    # with(:distance, params[:distance]) if params[:distance].present?
    # with(:expert_rating, params[:expert_rating]) if params[:expert_rating].present?

    facet :varietal, :producer, :region, :sub_region, :retailer_type, :wine_type, :white_varietal, :red_varietal,:champagne_varietal, :year, :review
    facet :bottlesize, :exclude => size_filter
    facet(:distance) do
      row(0..1) do
        with(:location).in_radius(lat, lng, 1)
      end
      row(1..3) do
        all_of do
          without(:location).in_radius(lat, lng, 1)
          with(:location).in_radius(lat, lng, 3)
        end
      end
      row(3..5) do
        all_of do
          without(:location).in_radius(lat, lng, 3)
          with(:location).in_radius(lat, lng, 5)
        end
      end
      row(5..25) do
        all_of do
          without(:location).in_radius(lat, lng, 5)
          with(:location).in_radius(lat, lng, 25)
        end
      end
      row("any") do
        # Any distance
      end
    end
    facet(:expert_rating) do
      row(95..100) do
        with(:expert_rating, 95.0..100.0)
      end
      row(90..95) do
        with(:expert_rating, 90.0..95.0)
      end
      row(85..90) do
        with(:expert_rating, 85.0..90.0)
      end
      row(80..85) do
        with(:expert_rating, 80.0..85.0)
      end
      row("below 85") do
        with(:expert_rating, 0.0..85.0)
      end
    end
    paginate :page => page, :per_page => 30

  end

   @wines = []
  # @wines = @search.results.wines
    wine_ids = @search.group(:group_str).groups.map { |p| p.value.split(",")[0].to_i }
    @wines = Wine.where(:id => wine_ids)
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
end

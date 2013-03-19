class RetailersController < ApplicationController
  def index
  	lat = 34.0126379
    lng = -118.495155
    page = (params[:page])? params[:page] : 1
    params[:retailer_type] = params[:retailer_type].split(",") if params[:retailer_type].present?
    @search = Retailer.search do
    	fulltext params[:search]
    	with(:retailer_type, params[:retailer_type]) if params[:retailer_type].present?
    	any_of do
          with(:location).in_radius(lat, lng, 50)
          with(:retailer_type, "Online Store") unless params[:retailer_type].present?
        end
    	facet :retailer_type
    end

  end
end

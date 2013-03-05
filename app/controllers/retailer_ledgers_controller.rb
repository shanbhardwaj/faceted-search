class RetailerLedgersController < ApplicationController
  # GET /retailer_ledgers
  # GET /retailer_ledgers.json
  def index
    @retailer_ledgers = RetailerLedger.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @retailer_ledgers }
    end
  end

  # GET /retailer_ledgers/1
  # GET /retailer_ledgers/1.json
  def show
    @retailer_ledger = RetailerLedger.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @retailer_ledger }
    end
  end

  # GET /retailer_ledgers/new
  # GET /retailer_ledgers/new.json
  def new
    @retailer_ledger = RetailerLedger.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @retailer_ledger }
    end
  end

  # GET /retailer_ledgers/1/edit
  def edit
    @retailer_ledger = RetailerLedger.find(params[:id])
  end

  # POST /retailer_ledgers
  # POST /retailer_ledgers.json
  def create
    @retailer_ledger = RetailerLedger.new(params[:retailer_ledger])

    respond_to do |format|
      if @retailer_ledger.save
        format.html { redirect_to @retailer_ledger, notice: 'Retailer ledger was successfully created.' }
        format.json { render json: @retailer_ledger, status: :created, location: @retailer_ledger }
      else
        format.html { render action: "new" }
        format.json { render json: @retailer_ledger.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /retailer_ledgers/1
  # PUT /retailer_ledgers/1.json
  def update
    @retailer_ledger = RetailerLedger.find(params[:id])

    respond_to do |format|
      if @retailer_ledger.update_attributes(params[:retailer_ledger])
        format.html { redirect_to @retailer_ledger, notice: 'Retailer ledger was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @retailer_ledger.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /retailer_ledgers/1
  # DELETE /retailer_ledgers/1.json
  def destroy
    @retailer_ledger = RetailerLedger.find(params[:id])
    @retailer_ledger.destroy

    respond_to do |format|
      format.html { redirect_to retailer_ledgers_url }
      format.json { head :no_content }
    end
  end
end

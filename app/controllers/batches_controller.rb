class BatchesController < ApplicationController
  respond_to :html, :xml
  before_filter :authenticate_user!
  
  def index
    @batches = Batch.all
    flash[:notice] = "Currently there are no batches. Please click on Add button to create one." if @batches.empty?
    respond_with(@batches)
  end

  def new
    @batch = Batch.new
    respond_with(@batch)
  end
  
   def show
    @batch = Batch.find(params[:id])
    respond_with(@batch)
  end

  def create
    params[:batch][:seats_available] = params[:batch][:total_seats]
    @batch = Batch.new(params[:batch])
    if @batch.save
      flash[:notice] = "Successfully created Batch"
    end
    respond_with(@batch, :location => batches_path)
  end

  def edit
    @batch = Batch.find(params[:id])
    respond_with(@batch)
  end

  def update
    @batch = Batch.find(params[:id])

    originalTotalSeats = @batch.total_seats
    originalAvailableSeats = @batch.seats_available
    currentTotalSeats = params[:batch][:total_seats].to_i
    if originalTotalSeats > currentTotalSeats
      update = originalTotalSeats - currentTotalSeats
      params[:batch][:seats_available] = originalAvailableSeats - update
    elsif originalTotalSeats < currentTotalSeats
      update = currentTotalSeats - originalTotalSeats
      params[:batch][:seats_available] = originalAvailableSeats + update
    else
      params[:batch][:seats_available] = currentTotalSeats
    end
    
    if @batch.update_attributes(params[:batch])
      flash[:notice] = "Successfully updated Batch"
    end
    respond_with(@batch, :location=> batches_path)
  end

  def destroy
    @batch = Batch.find(params[:id])
    @batch.destroy
    redirect_to(batches_path)
  end
end

class BatchesController < ApplicationController
  respond_to :html, :xml
  
  def index
    @batches = Batch.all
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
    if @batch.update_attributes(params[:batch])
      flash[:notice] = "Successfully updated Batch"
    end
    respond_with(@batch)
  end

  def destroy
    @batch = Batch.find(params[:id])
    @batch.destroy
    redirect_to(batches_path)
  end
end

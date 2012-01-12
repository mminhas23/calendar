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
    params[:batch][:seats_available] = @batch.update_course_seats(params[:batch][:total_seats].to_i)
    if @batch.errors.empty?
      if @batch.update_attributes(params[:batch])
        flash[:notice] = "Successfully updated Batch"
      end
    end
    respond_with(@batch, :location=> batches_path)
  end

  def destroy
    @batch = Batch.find(params[:id])
    @batch.update_student_statuses
    @batch.destroy
    redirect_to(batches_path)
  end
end

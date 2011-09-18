class DescriptionsController < ApplicationController
  respond_to :html, :xml
  before_filter :authenticate_user!

  def index
    @descriptions = Description.all
    flash[:notice] = "Currently there are no categories. Please click on Add button to create one." if @descriptions.empty?
    respond_with(@descriptions)
  end

  def show
    @description = Description.find(params[:id])
    respond_with(@description)
  end

  def new
    @description = Description.new
    respond_with(@description)
  end

  def create
    @description = Description.new(params[:description])
    if @description.save
      flash[:notice] = "Successfully created description"
    end
    respond_with(@description, :location => descriptions_path)
  end

  def edit
    @description = Description.find(params[:id])
    respond_with(@description)
  end

  def update
    @description = Description.find(params[:id])
    if @description.update_attributes(params[:description])
      flash[:notice] = "Successfully updated description"
    end
    respond_with(@description)
  end

  def destroy
    @description = Description.find(params[:id])
    @description.destroy
    redirect_to(descriptions_path)
  end
end

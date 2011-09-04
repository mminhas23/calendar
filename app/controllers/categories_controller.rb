class CategoriesController < ApplicationController
  respond_to :html, :xml

  def index
    @categories = Category.all
    respond_with(@categories)
  end

  def show
    @category = Category.find(params[:id])
    respond_with(@category)
  end

  def new
    @category = Category.new
    respond_with(@category)
  end

  def create
    @category = Category.new(params[:category])
    if @category.save
      flash[:notice] = "Successfully created category"
    end
    respond_with(@category,:location => categories_path)
  end

  def edit
    @category = Category.find(params[:id])
    respond_with(@category)
  end

  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(params[:category])
      flash[:notice] = "Successfully updated category"
    end
    respond_with(@category)
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    flash[:notice] = "Successfully deleted category"
    respond_with(@category)
  end
end

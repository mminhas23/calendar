class CategoriesController < ApplicationController
  respond_to :html, :xml
  before_filter :authenticate_user!

  def index
    @categories = Category.all
    flash[:notice] = "Currently there are no categories. Please click on Add button to create one." if @categories.empty?
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
#      @user = User.find(1)
#      StudentMailer.welcome_email(@user).deliver
      flash[:notice] = "Successfully created category"
    end
    respond_with(@category, :location => categories_path)
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
    respond_with(@category,:location => categories_path)
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to(categories_path)
  end
end

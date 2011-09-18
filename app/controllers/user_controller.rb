class UserController < ApplicationController
  respond_to :html, :xml
  before_filter :authenticate_user!
  load_and_authorize_resource :message => "You are not authorized to perform this action"

  def new
    @result = User.new
    respond_with(@result)
  end

  def create
    @result = User.new(params[:user])
    if @result.save
      flash[:notice] = "User was successfully created"
    end
    render :action => 'show'
  end
  
  def index
    @users = User.all
    respond_with(@users)
  end

  def show
    @result = User.find(params[:id])
    respond_with(@result)
  end

  def edit
    @result = User.find(params[:id])
    respond_with(@result)
  end

  def update
    @result = User.find(params[:id])
    params[:user].delete(:password) if params[:user][:password].blank?
    params[:user].delete(:password_confirmation) if params[:user][:password].blank? and params[:user][:password_confirmation].blank?
    if @result.update_attributes(params[:user])
      flash[:notice] = "Successfully updated User."
      redirect_to user_index_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    @result = User.find(params[:id])
    @result.destroy
    redirect_to(user_index_path)
  end

end
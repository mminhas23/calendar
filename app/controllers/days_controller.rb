class DaysController < ApplicationController
  respond_to :html, :xml

  def index
    @days = Day.all
    respond_with(@days)
  end

  def show
    @day = Day.find(params[:id])
    respond_with(@day)
  end

  def new
    @day = Day.new
    @day.sessions.build
    respond_with(@day)
  end

  def edit
    @day = Day.find(params[:id])
  end

  def create
    @day = Day.new(params[:day])
    if @day.save
      flash[:notice] = 'Day was successfully created'
    end
    respond_with(@day)
  end

  def update
    @day = Day.find(params[:id])
    if @day.update_attributes(params[:day])
      flash[:notice] = 'Day was successfully updated.'
    end
    respond_with(@day)
  end

  def destroy
    @day = Day.find(params[:id])
    @day.destroy
  end
end

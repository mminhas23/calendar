class SlotsController < ApplicationController
  respond_to :html, :xml
  before_filter :authenticate_user!

  def index
    @slots = Slot.where(:day_id => 1)
    respond_with(@slots)
  end

  def show
    @slot = Slot.find(params[:id])
    respond_with(@slot)
  end

  def new
    @slot = Slot.new
    respond_with(@slot)
  end

  def edit
    @slot = Slot.find(params[:id])
  end

  def create
    @slot = Slot.new(params[:Slot])
    if @slot.save
      flash[:notice] = 'Slot was successfully created.'
    end
    respond_with(@slot, :location => slots_path)
  end

  def update
    @slot = Slot.find(params[:id])
    if @slot.update_attributes(params[:Slot])
      flash[:notice] = 'Slot was successfully updated.'
    end
    respond_with(@slot, :location => slots_path)
  end

  def destroy
    @slot = Slot.find(params[:id])
    @slot.destroy
    redirect_to(slots_path)
  end
end

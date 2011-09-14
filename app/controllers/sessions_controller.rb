class SessionsController < ApplicationController
  respond_to :html, :xml

  def index
    @sessions = Session.where(:day_id => 1)
    respond_with(@sessions)
  end

  def show
    @session = Session.find(params[:id])
    respond_with(@session)
  end

  def new
    @session = Session.new
    respond_with(@session)
  end

  def edit
    @session = Session.find(params[:id])
  end

  def create
    @session = Session.new(params[:session])
    if @session.save
      flash[:notice] = 'Session was successfully created.'
    end
    respond_with(@session)
  end

  def update
    @session = Session.find(params[:id])
    if @session.update_attributes(params[:session])
      flash[:notice] = 'Session was successfully updated.'
    end
    respond_with(@session)
  end

  def destroy
    @session = Session.find(params[:id])
    @session.destroy
  end
end

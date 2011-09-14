class TutorsController < ApplicationController
  respond_to :html, :xml

  def index
    @tutors = Tutor.all
    respond_with(@tutors)
  end

  def show
    @tutor = Tutor.find(params[:id])
    respond_with(@tutor)
  end

  def new
    @tutor = Tutor.new
#    @tutor.time_table.create_association
    respond_with(@tutor)
  end

  def edit
    @tutor = Tutor.find(params[:id])
  end

  def create
    @tutor = Tutor.new(params[:tutor])
    if @tutor.save
      flash[:notice] = "Tutor was successfully created"
    end
    respond_with(@tutor)
  end

  def update
    @tutor = Tutor.find(params[:id])
    if @tutor.update
      flash[:notice] = 'Record was successfully updated'
    end
    respond_with(@tutor)
  end

  def destroy
    @tutor = Tutor.find(params[:id])
    @tutor.destroy
  end

end

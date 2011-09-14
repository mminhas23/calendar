class CoursesController < ApplicationController
  respond_to :html, :xml

  def index
    @courses = Course.all
    respond_with(@courses)
  end

  def show
    @course = Course.find(params[:id])
    respond_with(@course)
  end

  def new
    @course = Course.new
#    @course.batches.build
    respond_with(@course)
  end

  def edit
    @course = Course.find(params[:id])
  end

  def create
    @course = Course.new(params[:course])
    if @course.save
      flash[:notice] = "Course was successfully created"
    end
    respond_with(@course)
  end

  # PUT /courses/1
  # PUT /courses/1.xml
  def update
    @course = Course.find(params[:id])

    respond_to do |format|
      if @course.update_attributes(params[:course])
        format.html { redirect_to(@course, :notice => 'Course was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @course.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @course = Course.find(params[:id])
    @course.destroy
  end
end

class CoursesController < ApplicationController
  respond_to :html, :xml
  before_filter :authenticate_user!

  def index
    @courses = Course.all
    flash[:notice] = "Currently there are no courses. Please click on Add button to create one." if @courses.empty?
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
    respond_with(@course,:location=> courses_path)
  end

  def update
    @course = Course.find(params[:id])
    if @course.update_attributes(params[:course])
      flash[:notice] = 'Course was successfully updated.'
    end
    respond_with(@course,:location=> courses_path)
  end

  def enroll
    @course = Course.find(params[:id])
    @student = Student.new
    respond_with(@course)
  end

  def destroy
    @course = Course.find(params[:id])
    @course.destroy
    redirect_to(courses_path)
  end
end

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
    respond_with(@course)
  end

  def edit
    @course = Course.find(params[:id])
    respond_with(@course)
  end

  def create
    @course = Course.new(params[:course])
    @course.seats_remaining = params[:course][:total_seats]
    if @course.save
      flash[:notice] = "Course was successfully created"
    end
    respond_with(@course,:location=> courses_path)
  end

  def update
    @course = Course.find(params[:id])
    params[:course][:seats_remaining] = @course.update_remaining_seats(@course.total_seats.to_i,params[:course][:total_seats].to_i)
    @course.update_attributes(params[:course]) unless @course.errors[:total_seats].any?
    respond_with(@course,:location=> courses_path)
  end

  def enroll
    @batch = Batch.find(params[:batch])
    @course = Course.find(params[:id])
    @student = Student.new
    @students = @course.enrolled_student_ids.empty? ? Student.current_unassigned : Student.current_unassigned.where('id NOT IN (?)',@course.enrolled_student_ids)
    respond_with(@course)
  end

  def student
    @course = Course.find(params[:id])
    @batch = Batch.find(params[:batch_id])
    @student = Student.new(params[:student]).assign(@course,@batch)
    @student.payment_methods(params[:payment_methods])
    if @student.save
      flash[:notice] = "Successfully enrolled student"
    end
    redirect_to(batches_course_path)
  end

  def assign
    @course = Course.find(params[:id])
    @student = Student.find(params[:student])
    @batch = Batch.find(params[:batch])
    assigned = @batch.assign_student @student
    if assigned
      if @batch.save
        flash[:notice] = 'Student successfully enrolled'
      end
    else
      flash[:notice] = 'Batch is already full'
    end
  end

  def batches
    @course = Course.find(params[:id])
    @batches = @course.batches
  end

  def destroy
    @course = Course.find(params[:id])
    @course.destroy
    redirect_to(courses_path)
  end
end

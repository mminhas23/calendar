class StudentsController < ApplicationController
  respond_to :html, :xml
  respond_to :js, :only => [ :courses, :batches]

  before_filter :authenticate_user!
  
  def index
    @students = Student.all
    flash[:notice] = "Currently there are no students. Please click on Add button to create one." if @students.empty?
    respond_with(@students)
  end

  def new
    @student = Student.new
    @student.comments.build
    respond_with(@student)
  end
  
   def show
    @student = Student.find(params[:id])
    respond_with(@student)
  end

  def create
    @student = Student.new(params[:student])
    @student.payment_methods(params[:payment_methods])
    @student.update_batches(params[:student][:batch_ids])
    if @student.save
      flash[:notice] = "Successfully created Student"
    end
    respond_with(@student, :location => students_path)
  end

  def edit
    @student = Student.find(params[:id])
    @categories = Category.where(:id => @student.course_categories)
    @coursesAvailable = Course.where(:category_id => @categories)
    @batchesAvailable = Batch.where(:course_id => @student.courses)
    respond_with(@student)
  end

  def update
    params[:student][:course_ids] ||= []
    params[:student][:batch_ids] ||= []

    @student = Student.find(params[:id])
    @student.payment_methods(params[:payment_methods])
    
    old_batches = @student.batches.sort
    current_batches = Batch.where(:id => params[:student][:batch_ids]).to_a.sort

    if ((old_batches<=>current_batches)!=0)
      for batch in old_batches
        Batch.update(batch.id, "seats_available" => batch.seats_available + 1)
      end
      for batch in current_batches
        Batch.update(batch.id, "seats_available" => batch.seats_available - 1)
      end
    end

    if @student.update_attributes(params[:student])
      flash[:notice] = "Successfully updated Student"
    end
    respond_with(@student, :location => students_path)
  end

  def assign
    @student = Student.find(params[:id])
    @batchesAvailable = Batch.where(:course_id => @student.courses)
    respond_with(@batchesAvailable)
  end

  def destroy
    @student = Student.find(params[:id])
    @student.destroy
    redirect_to(students_path)
  end

  def batches
    @student = Student.new
    @batchesAvailable = Batch.where(:course_id => params[:id])
    respond_with(@batchesAvailable)
  end

  def courses
    @student = Student.new
    @coursesAvailable = Course.where(:category_id => params[:id])
    respond_with(@coursesAvailable)
  end
end

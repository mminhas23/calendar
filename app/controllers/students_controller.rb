class StudentsController < ApplicationController
  respond_to :html, :xml
  
  def index
    @students = Student.all
    respond_with(@students)
  end

  def new
    @student = Student.new
    respond_with(@student)
  end
  
   def show
    @student = Student.find(params[:id])
    respond_with(@student)
  end

  def create
    @student = Student.new(params[:student])
    if @student.save
      flash[:notice] = "Successfully created Student"
    end
    respond_with(@student, :location => students_path)
  end

  def edit
    @student = Student.find(params[:id])
    respond_with(@student)
  end

  def update
    params[:student][:course_ids] ||= []
    params[:student][:batch_ids] ||= []
    @student = Student.find(params[:id])
    if @student.update_attributes(params[:student])
      flash[:notice] = "Successfully updated Student"
    end
    respond_with(@student)
  end

  def assign
    @student = Student.find(params[:id])
    @batches = Batch.where(:course_id => @student.courses)
    respond_with(@batches)
  end

  def destroy
    @student = Student.find(params[:id])
    @student.destroy
    redirect_to(students_path)
  end
end
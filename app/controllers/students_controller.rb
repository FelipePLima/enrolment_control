class StudentsController < ApplicationController
  layout "application"
  before_filter :authenticate_user!

  def index
    @students = Student.all
    respond_with(@students)
  end

  def show
    @student = Student.find(params[:id])
    respond_with(@student)
  end

  def new
    @student = Student.new
    respond_with(@student)
  end

  def edit
    @student = Student.find(params[:id])
  end

  def create
    @student = Student.new(student_params)
    if @student.save
      flash[:success] == "Estudante criado com sucesso!"
      redirect_to students_path
    else
      respond_with(@student)
    end
  end

  def update
    @student = Student.find(params[:id])
    if @student.update_attributes(student_params)
      flash[:success] == "Estudante editado com sucesso!"
      respond_with(@student)
    else
      respond_with(@student)
    end
  end

  def destroy
    @student = Student.find(params[:id])
    @student.destroy
    respond_with(@student)
  end

  private

  def student_params
    params.require(:student).permit(:name, :register_number, :status)
  end
end

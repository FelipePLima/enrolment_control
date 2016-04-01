class CoursesController < ApplicationController
  layout "application"
  before_filter :authenticate_user!

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
    respond_with(@course)
  end

  def edit
    @course = Course.find(params[:id])
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      flash[:success] = "Curso criado com sucesso!"
      redirect_to courses_path
    else
      respond_with(@course)
    end
  end

  def update
    @course = Course.find(params[:id])
    if @course.update_attributes(course_params)
      flash[:success] = "Curso editado com sucesso!"
      respond_with(@course)
    else
      respond_with(@course)
    end
  end

  def destroy
    @course = Course.find(params[:id])
    @course.destroy
    respond_with(@course)
  end

  private

  def course_params
    params.require(:course).permit(:name, :description, :status)
  end
end

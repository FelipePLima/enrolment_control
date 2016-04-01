class ClassroomsController < ApplicationController
  layout "application"
  before_filter :authenticate_user!

  def index
    @classrooms = Classroom.all
    respond_with(@classrooms)
  end

  def show
    @classroom = Classroom.find(params[:id])
    respond_with(@classroom)
  end

  def new
    @classroom = Classroom.new
    respond_with(@classroom)
  end

  def edit
    @classroom = Classroom.find(params[:id])
  end

  def create
    @classroom = Classroom.new(classroom_params)
    if @classroom.save
      flash[:success] = "Mátricula criada com sucesso!"
      redirect_to classrooms_path
    else
      respond_with(@classroom)
    end
  end

  def update
    @classroom = Classroom.find(params[:id])
    if @classroom.update_attributes(classroom_params)
      flash[:success] = "Mátricula editada com sucesso!"
      respond_with(@classroom)
    else
      respond_with(@classroom)
    end
  end

  def destroy
    @classroom = Classroom.find(params[:id])
    @classroom.destroy
    respond_with(@classroom)
  end

  private

  def classroom_params
    params.require(:classroom).permit(:student_id, :course_id, :entry_at)
  end
end

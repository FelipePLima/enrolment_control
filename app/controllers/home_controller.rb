class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @count_students = Student.all.count
    @count_courses = Course.all.count
    @count_classrooms = Classroom.all.count
  end
end

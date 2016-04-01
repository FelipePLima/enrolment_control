class Classroom < ActiveRecord::Base
  validates :student_id, :course_id, :entry_at, presence: true
  validate :student_in_course

  belongs_to :student
  belongs_to :course

  def student_in_course
    if Classroom.where(student_id: student_id, course_id: course_id).count > 0
      errors.add('Estudante','O estudante já está cadastrado neste curso!')
    end
  end
end

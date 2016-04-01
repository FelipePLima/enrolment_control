class Course < ActiveRecord::Base

  has_many :classrooms

  validates :name, :description, :status, presence: true
end

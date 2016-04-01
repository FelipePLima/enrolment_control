class Student < ActiveRecord::Base

  has_many :classrooms

  validates :name, :register_number, :status, presence: true
  validates :register_number, uniqueness: true

end

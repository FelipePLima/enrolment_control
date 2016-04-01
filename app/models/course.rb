class Course < ActiveRecord::Base
  validates :name, :description, :status, presence: true
end

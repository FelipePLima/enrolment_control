class Student < ActiveRecord::Base
  validates :name, :register_number, :status, presence: true
end

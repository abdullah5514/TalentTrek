class Talent < ApplicationRecord
  has_many :courses_talents
  has_many :courses, through: :courses_talents
  has_many :course_learning_path_details
  has_many :learning_path_talents
  has_many :learning_paths, through: :learning_path_talents

  has_many :authored_courses, class_name: 'Course', as: :instructor

  validates :name, presence: true

  # Validation for roll_no
  validates :roll_no, presence: true

  # Validation for email
  validates :email, presence: true, uniqueness: true
end

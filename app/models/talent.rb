class Talent < ApplicationRecord
  # Associations

  # Define a many-to-many association with courses through courses_talents
  has_many :courses_talents
  has_many :courses, through: :courses_talents

  # Define a many-to-many association with learning_paths through learning_path_talents
  has_many :learning_path_talents
  has_many :learning_paths, through: :learning_path_talents

  # Define a many-to-many association with course_learning_path_details
  has_many :course_learning_path_details

  # Define a one-to-many association with authored_courses as an instructor
  has_many :authored_courses, class_name: 'Course', as: :instructor

  # Validations

  # Ensure that a name is present for the talent
  validates :name, presence: true

  # Validation for roll_no
  validates :roll_no, presence: true

  # Validation for email
  validates :email, presence: true, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
end

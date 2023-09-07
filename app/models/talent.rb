class Talent < ApplicationRecord
    has_and_belongs_to_many :courses, join_table: 'courses_talents'
    # has_many :learning_paths
    has_many :authored_courses, class_name: 'Course', as: :instructor
    has_and_belongs_to_many :learning_paths

    validates :name, presence: true

    # Validation for roll_no
    validates :roll_no, presence: true
  
    # Validation for email
    validates :email, presence: true, uniqueness: true
end

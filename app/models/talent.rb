class Talent < ApplicationRecord
    has_and_belongs_to_many :courses, join_table: 'courses_talents'
    has_many :learning_paths
    has_many :authored_courses, class_name: 'Course', as: :instructor'
end

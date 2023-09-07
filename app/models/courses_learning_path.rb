class CoursesLearningPath < ApplicationRecord
  belongs_to :learning_path
  belongs_to :course
  has_many :course_learning_path_details
end
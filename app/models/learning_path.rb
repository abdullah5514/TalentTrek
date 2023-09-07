class LearningPath < ApplicationRecord
  has_many :learning_paths_talents
  has_many :talents, through: :learning_paths_talents
  has_many :courses_learning_paths
  has_many :courses, through: :courses_learning_paths
  has_many :course_learning_path_details, through: :courses_learning_paths
end

class LearningPath < ApplicationRecord
  has_many :learning_path_talents
  has_many :talents, through: :learning_path_talents
  has_many :courses_learning_paths
  has_many :courses, through: :courses_learning_paths
  has_many :course_learning_path_details, through: :courses_learning_paths

  validates :title, presence: true
end

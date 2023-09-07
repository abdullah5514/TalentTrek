class CourseLearningPathDetail < ApplicationRecord
  belongs_to :talent
  belongs_to :courses_learning_path
  has_many :courses, through: :courses_learning_path
  has_many :learning_paths, through: :courses_learning_path

  include CourseLearningPathDetails::Status

  after_create :change_inprogress_to_pending
end

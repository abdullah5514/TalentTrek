class CourseLearningPathDetail < ApplicationRecord
  belongs_to :talent
  belongs_to :courses_learning_path
  has_many :courses, through: :courses_learning_path
  has_many :learning_paths, through: :courses_learning_path
  has_many :learning_path_talents, through: :talent

  include CourseLearningPathDetails::Status

  after_create :change_pending_to_inprogess

  def change_pending_to_inprogess
    inprogress_courses = learning_paths.first.course_learning_path_details.inprogress
    return if inprogress_courses.any?

    first_position_course = learning_paths.first.course_learning_path_details.where(course_position: 1).first
    first_position_course.mark_as_inprogress! 
  end
end

class CourseLearningPathDetail < ApplicationRecord
  # Include the Status module from CourseLearningPathDetails namespace
  include CourseLearningPathDetails::Status
  
  # Associations

  # Define a many-to-one association with a talent
  belongs_to :talent

  # Define a many-to-one association with courses_learning_path
  belongs_to :courses_learning_path

  # Define a many-to-many association with courses through courses_learning_path
  has_many :courses, through: :courses_learning_path

  # Define a many-to-many association with learning_paths through courses_learning_path
  has_many :learning_paths, through: :courses_learning_path

  # Define a many-to-many association with learning_path_talents through talent
  has_many :learning_path_talents, through: :talent

  # Validations

  # Ensure uniqueness of talent_id within the scope of courses_learning_path_id
  validates :talent_id, uniqueness: { scope: :courses_learning_path_id }

  # Callback after a new record is created
  after_create :change_pending_to_inprogress

  private

  # Change pending course to in-progress if no other course is in progress
  def change_pending_to_inprogress
    # Find in-progress courses in the associated learning path
    inprogress_courses = learning_paths.first.course_learning_path_details.inprogress
    
    # If there are in-progress courses, return without making changes
    return if inprogress_courses.any?

    # If no courses are in progress, find the first course in the path and mark it as in-progress
    first_position_course = learning_paths.first.course_learning_path_details.where(course_position: 1).first
    first_position_course.mark_as_inprogress!
  end
end

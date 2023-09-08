class Course < ApplicationRecord
  # Associations

  # Define a many-to-many association with talents through courses_talents
  has_many :courses_talents
  has_many :talents, through: :courses_talents

  # Define a many-to-many association with learning paths through courses_learning_paths
  has_many :courses_learning_paths
  has_many :learning_paths, through: :courses_learning_paths

  # Define a polymorphic association with instructors (can be Author or Talent)
  belongs_to :instructor, polymorphic: true
  
  # Validations

  # Ensure that a title is present for the course
  validates :title, presence: true
end

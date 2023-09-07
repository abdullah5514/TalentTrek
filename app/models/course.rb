class Course < ApplicationRecord
  has_many :courses_talents
  belongs_to :instructor, polymorphic: true
  has_and_belongs_to_many :learning_paths

  validates :title, presence: true

  # Validation for instructor_type
  validates :instructor_type, presence: true

  # Validation for instructor_id
  validates :instructor_id, presence: true
end

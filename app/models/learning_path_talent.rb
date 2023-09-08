class LearningPathTalent < ApplicationRecord
  # Include the Status module from LearningPathTalents namespace
  include LearningPathTalents::Status

  # Associations

  # Define a many-to-one association with learning_path
  belongs_to :learning_path

  # Define a many-to-one association with talent
  belongs_to :talent

  # Validations

  # Ensure uniqueness of talent_id within the scope of learning_path_id
  validates :talent_id, uniqueness: { scope: :learning_path_id }, presence: true
end

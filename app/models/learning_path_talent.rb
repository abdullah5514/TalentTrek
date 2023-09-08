class LearningPathTalent < ApplicationRecord
    belongs_to :learning_path
    belongs_to :talent
    has_many :course_learning_path_details

    validates :talent_id, uniqueness: { scope: :learning_path_id }, presence: true
end
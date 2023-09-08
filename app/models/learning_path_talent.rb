class LearningPathTalent < ApplicationRecord
    belongs_to :learning_path
    belongs_to :talent

    validates :talent_id, uniqueness: { scope: :learning_path_id }, presence: true
end
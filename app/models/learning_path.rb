class LearningPath < ApplicationRecord
    has_many :courses, { order(:position) }
end

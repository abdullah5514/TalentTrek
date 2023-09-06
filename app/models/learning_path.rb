class LearningPath < ApplicationRecord
    has_many :courses,-> { order(:position) }
    has_and_belongs_to_many :talents
    has_and_belongs_to_many :courses
end

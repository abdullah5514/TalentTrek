class LearningPath < ApplicationRecord
  has_many :courses
  has_and_belongs_to_many :talents

  include AASM

  aasm column: 'status' do
    state :incomplete, initial: true
    state :completed

    event :mark_as_completed do
      transitions from: :incomplete, to: :completed
    end

    event :mark_as_incomplete do
      transitions from: :completed, to: :incomplete
    end
  end
end

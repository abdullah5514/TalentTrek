class CourseLearningPathDetail < ApplicationRecord
  belongs_to :courses_learning_path

  # Define the state machine
  include AASM

  aasm column: 'state' do
    state :pending, initial: true
    state :completed

    event :mark_as_completed do
      transitions from: :pending, to: :completed
    end

    # Define other events and transitions as needed
  end
end

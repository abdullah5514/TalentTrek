# frozen_string_literal: true

module CourseLearningPathDetails
  module Status
    extend ActiveSupport::Concern

    included do 
      include AASM
      aasm column: 'status' do
        state :inprogress, initial: true
        state :pending
        state :completed
        state :unavailable

        event :mark_as_completed do
          transitions from: :inprogress, to: :completed
        end

        event :mark_as_unavailable do
          transitions from: :inprogress, to: :unavailable
        end

        event :mark_as_pending do
          transitions from: :inprogress, to: :pending
        end
      end
    end
  end
end

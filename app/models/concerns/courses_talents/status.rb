# frozen_string_literal: true

module CoursesTalents
  module Status
    extend ActiveSupport::Concern

    included do 
      include AASM
      aasm column: 'status' do
        state :inprogress, initial: true
        state :completed
        state :unavailable
        state :dropped
        state :withdrawn

        event :mark_as_completed do
          transitions from: :inprogress, to: :completed
        end

        # TODO we can implement additional API's for below transitions

        event :mark_as_dropped do
          transitions from: :inprogress, to: :dropped
        end

        event :mark_as_withdrawn do
          transitions from: :inprogress, to: :withdrawn
        end

        event :mark_as_unavailable do
          transitions from: :inprogress, to: :unavailable
        end

      end
    end
  end
end

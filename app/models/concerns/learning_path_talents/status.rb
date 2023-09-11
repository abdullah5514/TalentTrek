# frozen_string_literal: true

module LearningPathTalents
  module Status
    extend ActiveSupport::Concern

    included do 
      include AASM
      aasm column: 'status' do
        state :inprogress, initial: true
        state :completed
        
        event :mark_as_completed do
          transitions from: :inprogress, to: :completed
        end

      end
    end
  end
end

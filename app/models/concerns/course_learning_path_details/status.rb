# frozen_string_literal: true

module CourseLearningPathDetails
  module Status
    extend ActiveSupport::Concern

    included do 
      include AASM

      # Define states for the AASM state machine
      aasm column: 'status' do
        state :pending, initial: true
        state :inprogress
        state :completed

        # Define transitions and events for the state machine
        event :mark_as_completed do
          transitions from: :inprogress, to: :completed, after: :assign_next_course
        end

        event :mark_as_unavailable do
          transitions from: :inprogress, to: :unavailable
        end

        event :mark_as_inprogress do
          transitions from: :pending, to: :inprogress
        end
      end

      # Custom method to assign the next course or mark the learning path as completed
      def assign_next_course
        # Find the next course in the learning path based on course_position
        next_course = learning_paths.first.course_learning_path_details.where("course_position > ?", course_position).order(:course_position)

        if next_course.any?
          # If there's a next course, mark it as in progress
          next_course.first.mark_as_inprogress!
        else
          # If there are no more courses, mark the learning path as completed
          learning_path = LearningPathTalent.where(talent_id: talent_id, learning_path_id: learning_paths.first.id)
          learning_path.first.mark_as_completed!
        end
      end
    end
  end
end

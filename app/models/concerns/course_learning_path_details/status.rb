# frozen_string_literal: true

module CourseLearningPathDetails
  module Status
    extend ActiveSupport::Concern

    included do 
      include AASM
      aasm column: 'status' do
        state :pending, initial: true
        state :inprogress
        state :completed
        state :unavailable

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

      def assign_next_course
        next_course = learning_paths.first.course_learning_path_details.where("course_position > ?",course_position).order(:course_position)
        next_course.first.mark_as_inprogress!
      end
    end
  end
end

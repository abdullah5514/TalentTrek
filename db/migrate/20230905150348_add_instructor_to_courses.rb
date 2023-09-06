class AddInstructorToCourses < ActiveRecord::Migration[6.0]
  def change
    add_reference :courses, :instructor, polymorphic: true, index: true

    # Change the null constraint to true for the instructor column
    change_column_null :courses, :instructor_id, true
    change_column_null :courses, :instructor_type, true
  end
end

class AddTitleCourseCodeStatusToCourses < ActiveRecord::Migration[6.0]
  def change
    add_column :courses, :course_code, :string
    add_column :courses, :status, :string
  end
end

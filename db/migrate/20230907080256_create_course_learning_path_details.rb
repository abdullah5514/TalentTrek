class CreateCourseLearningPathDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :course_learning_path_details do |t|
      t.belongs_to :courses_learning_path, null: false, foreign_key: true
      t.integer :course_position
      t.string :state

      t.timestamps
    end
  end
end

class CreateCoursesLearningPathsJoinTable < ActiveRecord::Migration[6.0]
  def change
    create_table :courses_learning_paths, id: false do |t|
      t.belongs_to :course
      t.belongs_to :learning_path
    end
  end
end

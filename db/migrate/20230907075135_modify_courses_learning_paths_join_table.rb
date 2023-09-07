# db/migrate/modify_courses_learning_paths_join_table.rb

class ModifyCoursesLearningPathsJoinTable < ActiveRecord::Migration[6.0]
  def up
    # Remove the existing join table
    drop_table :courses_learning_paths

    # Create a new join table with an auto-increment primary key
    create_table :courses_learning_paths do |t|
      t.belongs_to :course
      t.belongs_to :learning_path
      t.timestamps # Add timestamps for created_at and updated_at columns
    end
  end

  def down
    # Revert the migration by dropping the table
    drop_table :courses_learning_paths
  end
end

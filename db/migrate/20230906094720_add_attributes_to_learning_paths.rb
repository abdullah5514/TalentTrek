class AddAttributesToLearningPaths < ActiveRecord::Migration[6.0]
  def change
    add_column :learning_paths, :course_sequence, :integer, array: true, default: []
    add_column :learning_paths, :start_date, :date
    add_column :learning_paths, :end_date, :date
    add_column :learning_paths, :title, :string
  end
end

class RemoveStatusFromLearningPaths < ActiveRecord::Migration[6.0]
  def change
    remove_column :learning_paths, :status, :string
    remove_column :learning_paths, :course_sequence, :integer
  end
end

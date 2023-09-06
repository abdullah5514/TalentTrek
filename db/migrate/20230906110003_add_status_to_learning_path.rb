class AddStatusToLearningPath < ActiveRecord::Migration[6.0]
  def change
    add_column :learning_paths, :status, :string
  end
end

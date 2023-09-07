class RemoveNameColoumFromLearningPath < ActiveRecord::Migration[6.0]
  def change
    remove_column :learning_paths, :name
  end
end

class AddPrimaryKeyLearningPathDetails < ActiveRecord::Migration[6.0]
  def change
    def up
    # Remove the existing join table
    drop_table :learning_paths_talents
    # Create a new join table with an auto-increment primary key
    create_table :learning_path_talents do |t|
      t.belongs_to :learning_path
      t.belongs_to :talent
      t.string :status
      t.timestamps # Add timestamps for created_at and updated_at columns
    end
  end
  end
end

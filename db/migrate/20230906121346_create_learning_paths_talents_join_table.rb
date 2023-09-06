class CreateLearningPathsTalentsJoinTable < ActiveRecord::Migration[6.0]
  def change
    create_table :learning_paths_talents, id: false do |t|
      t.belongs_to :learning_path
      t.belongs_to :talent
    end
  end
end

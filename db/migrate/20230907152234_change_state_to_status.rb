class ChangeStateToStatus < ActiveRecord::Migration[6.0]
  def change
    rename_column :course_learning_path_details, :state, :status
  end
end

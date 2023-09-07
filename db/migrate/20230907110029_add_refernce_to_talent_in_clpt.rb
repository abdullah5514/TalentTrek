class AddRefernceToTalentInClpt < ActiveRecord::Migration[6.0]
  def change
    add_reference :course_learning_path_details, :talent, foreign_key: true
  end
end

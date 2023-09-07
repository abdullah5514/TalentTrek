class RemoveAuthorAndTalentFromCourses < ActiveRecord::Migration[6.0]
  def change
    remove_column :courses, :author_id
    remove_column :courses, :talent_id
  end
end

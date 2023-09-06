class AddTalentToCourses < ActiveRecord::Migration[6.0]
  def change
    add_reference :courses, :talent, null: false, foreign_key: true
  end
end

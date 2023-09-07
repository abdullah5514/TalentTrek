class AddPrimarKeyToCourseTalent < ActiveRecord::Migration[6.0]
  def up
    # Remove the existing join table
    drop_table :courses_talents
    # Create a new join table with an auto-increment primary key
    create_table :courses_talents do |t|
      t.belongs_to :course
      t.belongs_to :talent
      t.string :status
      t.timestamps # Add timestamps for created_at and updated_at columns
    end
  end
end

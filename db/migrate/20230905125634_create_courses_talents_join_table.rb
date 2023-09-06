class CreateCoursesTalentsJoinTable < ActiveRecord::Migration[6.0]
  def change
    create_table :courses_talents, id: false do |t|
      t.belongs_to :course
      t.belongs_to :talent
    end
  end
end

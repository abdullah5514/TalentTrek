class Course < ApplicationRecord 
    has_and_belongs_to_many :talents, join_table: 'courses_talents'
    belongs_to :instructor, polymorphic: true
    has_and_belongs_to_many :learning_paths
end

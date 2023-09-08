class Course < ApplicationRecord
  has_many :courses_talents
  has_many :talents, through: :courses_talents
  has_many :courses_learning_paths
  has_many :learning_paths, through: :courses_learning_paths
  
  belongs_to :instructor, polymorphic: true

  validates :title, presence: true


end 

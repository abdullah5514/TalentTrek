class Author < ApplicationRecord
  has_many :courses
  has_many :authored_courses, class_name: 'Course', as: :instructor
 
  before_destroy :transfer_courses_to_another_author

  validates :name, presence: true

  # Validation for speciality
  validates :speciality, presence: true

  # Validation for email presence and uniqueness
  validates :email, presence: true, uniqueness: true
  
  def transfer_courses_to_another_author
    if authored_courses.any?
      another_author = Author.where(speciality: speciality).where.not(id: id)

      another_author.any? ? assign_course_to_another_author(another_author) : assign_course_to_talent

      courses.update_all(author_id: another_author.first.id)
    else
      puts "Author is missing"
    end
  end

  def assign_course_to_talent
    
  end

  def assign_course_to_another_author(author)
    authored_courses.update_all(instructor: author.first)
  end
end

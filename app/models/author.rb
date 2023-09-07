class Author < ApplicationRecord
  has_many :authored_courses, class_name: 'Course', as: :instructor

  validates :name, presence: true

  # Validation for speciality
  validates :speciality, presence: true

  # Validation for email presence and uniqueness
  validates :email, presence: true, uniqueness: true
  
  before_destroy :transfer_courses_to_another_instructor
  
  private

  def transfer_courses_to_another_instructor
    return unless authored_courses.any?

    another_author = Author.where(speciality: speciality).where.not(id: id)

    another_author.any? ? assign_course_to_another_author(another_author) : assign_course_to_talent
  end

  def assign_course_to_talent
    authored_courses.each do |course|
      completed_courses = course.courses_talents.completed
      unless completed_courses.any?
        talent = Talent.find(completed_courses.first.talent_id)
        course.update(instructor_id: talent.id, instructor_type: 'Talent')
      else
        course.update(instructor_id: Author.first.id, instructor_type: 'Author')
      end
    end
  end

  def assign_course_to_another_author(author)
    authored_courses.update_all(instructor_id: author.first.id, instructor_type: 'Author')
  end
end

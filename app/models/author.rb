class Author < ApplicationRecord
  # Associations
  has_many :authored_courses, class_name: 'Course', as: :instructor

  # Validations
  validates :name, presence: true
  validates :speciality, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }

  # Callback to transfer courses before destroying the author
  before_destroy :transfer_courses_to_another_instructor

  private

  # Transfer courses to another instructor if available, or to a talent
  def transfer_courses_to_another_instructor
    return unless authored_courses.any?

    # Find another author with the same speciality, excluding the current author
    another_author = Author.where(speciality: speciality).where.not(id: id)

    # If another author with the same speciality exists, transfer courses to them
    if another_author.any?
      assign_course_to_another_author(another_author.first)
    else
      # If no other author is available with the same speciality, transfer to a talent
      assign_course_to_talent
    end
  end

  # Transfer courses to a talent if no other author is available
  def assign_course_to_talent
    authored_courses.each do |course|
      # Find completed courses for the course and get the first talent
      completed_courses = course.courses_talents.completed
      if completed_courses.any?
        talent = Talent.find(completed_courses.first.talent_id)
        course.update(instructor_id: talent.id, instructor_type: 'Talent')
      else
        # If no talent has completed the course, assign it to the first author
        course.update(instructor_id: Author.first.id, instructor_type: 'Author')
      end
    end
  end

  # Transfer courses to another author with the same speciality
  def assign_course_to_another_author(author)
    authored_courses.update_all(instructor_id: author.id, instructor_type: 'Author')
  end
end

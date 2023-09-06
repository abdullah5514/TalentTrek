class Author < ApplicationRecord
    has_many :courses
    before_destroy :transfer_courses_to_another_author
    has_many :authored_courses, class_name: 'Course', as: :instructor
   
   
    def transfer_courses_to_another_author
        if courses.any?
          # Choose another author to transfer the courses to (you need to implement your own logic here)
          another_author = Author.last
    
          if another_author
            courses.update_all(author_id: another_author.id)
          else
            puts "Author is missing"
          end
        end
    end
end

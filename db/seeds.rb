# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# db/seeds.rb



# Create talents
# db/seeds.rb
require 'faker'

# Seed Authors
5.times do
  author = Author.create(
    name: Faker::Name.name,
    speciality: Faker::Lorem.word,
    email: Faker::Internet.email,
    phone: Faker::PhoneNumber.phone_number
  )

  # Create authored courses for each author
  3.times do
    author.authored_courses.create(
      title: Faker::Lorem.sentence,
      description: Faker::Lorem.paragraph,
      instructor_type: 'Author', # Assuming all authored courses have authors as instructors
      course_code: Faker::Alphanumeric.alphanumeric(number: 6, min_alpha: 3, min_numeric: 3).upcase,
      status: ['incomplete', 'completed'].sample
    )
  end
end

# Seed Talents
5.times do
  talent = Talent.create(
    name: Faker::Name.name,
    roll_no: Faker::Alphanumeric.alphanumeric(number: 6, min_alpha: 3, min_numeric: 3).upcase,
    email: Faker::Internet.email,
    phone: Faker::PhoneNumber.phone_number
  )

  # Create talents' courses and associate them with random learning paths
  3.times do
    talent.courses.create(
      title: Faker::Lorem.sentence,
      description: Faker::Lorem.paragraph,
      instructor_type: 'Talent', # Assuming all talent-taught courses have talents as instructors
      course_code: Faker::Alphanumeric.alphanumeric(number: 6, min_alpha: 3, min_numeric: 3).upcase,
      status: ['incomplete', 'completed'].sample
    )
  end

  # Associate talents with random learning paths
  talent.learning_paths << LearningPath.all.sample(2)
end

# Seed LearningPaths
3.times do
  LearningPath.create(
    title: Faker::Lorem.sentence,
    course_sequence: (1..10).to_a.sample(3),
    start_date: Faker::Date.forward(days: 10),
    end_date: Faker::Date.forward(days: 30)
  )
end

# Seed Courses and associate them with random learning paths
10.times do
  course = Course.create(
    title: Faker::Lorem.sentence,
    description: Faker::Lorem.paragraph,
    instructor_type: ['Author', 'Talent'].sample,
    instructor_id: (['Author', 'Talent'].sample == 'Author' ? Author.pluck(:id).sample : Talent.pluck(:id).sample),
    course_code: Faker::Alphanumeric.alphanumeric(number: 6, min_alpha: 3, min_numeric: 3).upcase,
    status: ['incomplete', 'completed'].sample
  )

  # Associate courses with random learning paths
  course.learning_paths << LearningPath.all.sample(2)
end


puts 'Seed data has been created.'

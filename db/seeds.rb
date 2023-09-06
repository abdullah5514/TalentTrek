# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# db/seeds.rb

require 'faker'

# Create talents
10.times do
  Talent.create(
    name: Faker::Name.unique.name

  )
end

# Create authors
5.times do
  Author.create(
    name: Faker::Name.unique.name
  )
end

# Create courses with talents and authors associations
author = Author.last
talents = Talent.last

20.times do
  course = Course.create(
    title: Faker::Lorem.sentence,
    description: Faker::Lorem.paragraph,
    author: author
  )
end

# Create learning paths with courses associations
5.times do
  learning_path = LearningPath.create(
    title: Faker::Lorem.sentence
  )
  learning_path.courses << Course.all.sample(rand(3..7))
end

puts 'Seed data has been created.'

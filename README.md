# TalentTrek Learning Path Management API

## Introduction

The TalentTrek Learning Path Management API is a Ruby on Rails 6.0 application that helps organizations manage learning paths, courses, instructors, and talents. This API provides CRUD (Create, Read, Update, Delete) operations for these entities and is backed by a PostgreSQL database.

## Features

- Manage learning paths, courses, instructors, and talents.
- Assign talents to courses and learning paths.
- Transfer authorship of courses when an instructor is deleted.
- Mark courses as completed for talents.
- Automatically assign talents to the next course in a learning path upon completion.

## Prerequisites

Before running the application, ensure you have the following installed:

- Ruby 2.7.4
- Ruby on Rails 6.0
- PostgreSQL 13.0

## Installation

1. Clone the repository to your local machine:

     git clone git@github.com:abdullah5514/TalentTrek.git 
 
Navigate to the "TalentTrek" directory: 

     cd TalentTrek



4. Access the API at [http://0.0.0.0:3000](http://0.0.0.0:3000)

## Usage

1. [Provide details on how to use each API endpoint, including request and response formats.]

2. [Include examples or code snippets for common use cases.]

## Endpoints

### Learning Paths

- **List Learning Paths**
  - `GET /learning_paths`
  - Retrieve a list of all available learning paths.

- **Show Learning Path**
  - `GET /learning_paths/:id`
  - Retrieve details of a specific learning path by its ID.

- **Create Learning Path**
  - `POST /learning_paths`
  - Create a new learning path with the specified attributes.

- **Update Learning Path**
  - `PUT /learning_paths/:id`
  - Update the details of a specific learning path by its ID.

- **Delete Learning Path**
  - `DELETE /learning_paths/:id`
  - Delete a learning path by its ID.

- **Assign Courses to Learning Path**
  - `GET /learning_paths/:id/assign_courses_to_learning_path`
  - View and assign courses to a specific learning path.

- **Remove Courses from Learning Path**
  - `DELETE /learning_paths/:id/remove_courses_from_learning_path`
  - Remove courses from a specific learning path.

### Courses

- **List Courses**
  - `GET /courses`
  - Retrieve a list of all available courses.

- **Show Course**
  - `GET /courses/:id`
  - Retrieve details of a specific course by its ID.

- **Create Course**
  - `POST /courses`
  - Create a new course with the specified attributes.

- **Update Course**
  - `PUT /courses/:id`
  - Update the details of a specific course by its ID.

- **Delete Course**
  - `DELETE /courses/:id`
  - Delete a course by its ID.

- **Complete Course**
  - `PUT /courses/:id/complete_course`
  - Mark a course as completed.

### Authors

- **List Authors**
  - `GET /authors`
  - Retrieve a list of all authors in the system.

- **Show Author**
  - `GET /authors/:id`
  - Retrieve details of a specific author by their ID.

- **Create Author**
  - `POST /authors`
  - Create a new author with the specified attributes.

- **Update Author**
  - `PUT /authors/:id`
  - Update the details of a specific author by their ID.

- **Delete Author**
  - `DELETE /authors/:id`
  - Delete an author by their ID.

### Talents

- **List Talents**
  - `GET /talents`
  - Retrieve a list of all talents in the system.

- **Show Talent**
  - `GET /talents/:id`
  - Retrieve details of a specific talent by their ID.

- **Create Talent**
  - `POST /talents`
  - Create a new talent with the specified attributes.

- **Update Talent**
  - `PUT /talents/:id`
  - Update the details of a specific talent by their ID.

- **Delete Talent**
  - `DELETE /talents/:id`
  - Delete a talent by their ID.

- **Assign Courses to Talent**
  - `GET /talents/:id/assign_courses_to_talent`
  - View and assign courses to a specific talent.

- **Assign Learning Path to Talent**
  - `GET /talents/:id/assign_learning_path_to_talent`
  - Assign a learning path to a specific talent.

- **Remove Courses from Talent**
  - `DELETE /talents/:id/remove_courses_from_talent`
  - Remove courses from a specific talent.


## Tests

To run tests for the Learning Path Management API, you will need to use RSpec. Follow these steps to run the tests:

1. Ensure you have RSpec installed. If you don't, you can install it using:

   gem install rspec

   cd TalentTrek

## Contact

If you have any questions or need further assistance, you can contact us at mabdullah5514@gmail.com.
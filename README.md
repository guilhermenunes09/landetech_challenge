# Landetech Challenge
Introduction
Welcome! This README will help you set up and run the API. Make sure you have the required versions installed:

* Ruby: 2.7.2
* Rails: 6.0.0

## Setup

1. Clone the repository

       git clone https://github.com/guilhermenunes09/landetech_challenge.git

2. CD into the new created folder

       cd landetech_challenge

3. Install necessary libraries on your system (Debian/Ubuntu)

       sudo apt-get install build-essential patch ruby-dev zlib1g-dev liblzma-dev

4. Install dependencies

       bundle install

5. Create the database and run migrations:

       rails db:create
       rails db:migrate

6. Run the server:

       rails server

## API

### Routes and Examples
Authentication

Example Request:

      curl -X POST http://localhost:3000/auth/login \
        -H "Content-Type: application/json" \
        -d '{"email": "user@example.com", "password": "secret"}'

Example Response:
JSON

    {
      "id": 11,
      "name": "New name",
      "email": "New email 6",
      "token": "eyJhbGciOiJIUzI1NiJ9.eyJyZWNydWl0ZXJfaWQiOjExfQ.7Nqd4lXPthva2LOvtlvzSwXOalI3jhapkVI9WW3c5nA"
    }

Token:
Include the access token in the Authorization header for protected routes.

### Example of routes

    Route: GET /recruiter/recruiters
    Description: Get a list of recruiters.
    Example Request:
    curl -X GET http://localhost:3000/recruiter/recruiters \
      -H "Authorization: Bearer <your_access_token_here>"


    Route: GET /recruiter/jobs
    Description: Get a list of jobs.
    Example Request:
    curl -X GET http://localhost:3000/recruiter/jobs \
      -H "Authorization: Bearer <your_access_token_here>"


    Route: GET /recruiter/submissions
    Description: Get a list of submissions.
    Example Request:
    curl -X GET http://localhost:3000/recruiter/submissions \
      -H "Authorization: Bearer <your_access_token_here>"


### Headers:
Set the Content-Type header to application/json for JSON requests.

## Testing

To run your RSpec tests, execute the following command:

    bundle exec rspec

That’s it! You’re all set to build your Rails API. If you have any questions, feel free to ask me. guilhermewnunes@gmail.com

Thank you! 🚀
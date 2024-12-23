Deployment Instructions

Step 1: Cloning the Project

1. Clone the project repository:
    
   Run: git clone https://github.com/MarkLysenkoZp/sample_app.git 

2. Navigate to the project folder:

   Example: cd  project/sample_app

Step 2: Installing Gems

1. Ensure that the correct versions of Ruby and Bundler are installed.
2. Install all required gems

  Run  bundle install

If you encounter issues with Bundler, install the required version:

  Example:  gem install bundler -v "2.4.22"

Step 3: Running Database Migrations

1. Create the database (if not already created):

   Run: rails db:create

2. Run the migrations:

    Run: rails db:migrate

Step 4: Running Tests

1. Apply the migrations to the test database:

    Run: rails db:migrate RAILS_ENV=test

2. Run the test

   Run: rails test

For RSpec:

  Run: rspec
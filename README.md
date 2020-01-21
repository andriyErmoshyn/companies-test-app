# README

Companies Test App represents companies with theirs branches and allows to manage data by creating, editing, deleting it.

## Technology stack
* We use Ruby 2.7.0 and Ruby on Rails 5.2.4 on a back-end and Angular1 as a front-end framework.
* The search is implemented with Ransack gem.
* Rubocop helps us to keep the code clear 

## Getting started

To run the application locally you should do the next steps:
1. Download the code from the repository: https://github.com/andriyErmoshyn/companies-test-app
2. Ensure you have Ruby version 2.7.0.
3. Install gems and dependencies:
   ``` 
   $ bundle install 
   ```
4. Add local database configs to database.yml:
   ```
   $ cp config/database.example.yml config/database.yml
   ```
5. Create database, configure db schema and populate seeds:
   ```
   $ rails db:setup
   ```
6. Run Rails server:
   ```
   $ rails s
   ````  
7. Visit app on http://localhost:3000   
  
### Running tests 
  ```
   $ rspec spec
  ```
  We also use Guard, FactoryBot and Faker for testing.

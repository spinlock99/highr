require 'faker'

# Create rake task in namespace db
namespace :db do
	  desc "Fill database with sample data"
	  # Task name will be db:populate 
	  task :populate => :environment do
	       # Reset the database
	       Rake::Task['db:reset'].invoke
	       # Create the First User
	       User.create!(:name => "Example User",
	       	 	    :email => "example@railstutorial.org",
			    :password => "foobar",
			    :password_confirmation => "foobar")
	       # Create 99 more users
	       99.times do |n|
	       		name = Faker::Name.name
			email = "example-#{n+1}@railstutorial.org"
			password = "password"
			User.create!(:name => name,
				     :email => email,
				     :password => password,
				     :password_confirmation => password)
	       end
	  end # desc "Fill database with sample data"
end # namespace :db
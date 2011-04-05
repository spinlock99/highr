# Create rake task in namespace db
namespace :db do
	  desc "Fill database with sample data"
	  # Task name will be db:populate 
	  task :populate => :environment do
	       require 'faker'
	       # Reset the database
	       Rake::Task['db:reset'].invoke
	       # Create an the First User as an admin
	       #admin = User.create!(:name => "Example User",
	       # 	    :email => "example@railstutorial.org",
	       #	    :password => "foobar",
	       #	    :password_confirmation => "foobar")
	       #admin.toggle!(:admin)
	       # Create 99 regular users
	       99.times do |n|
	       		first_name = Faker::Name.first_name
			last_name = Faker::Name.last_name
			email = "example-#{n+1}@railstutorial.org"
			password = "password"
			User.create!(:first_name => first_name,
				     :last_name => last_name,
				     :email => email,
				     :password => password,
				     :password_confirmation => password)
	       end
	       User.all(:limit => 6).each do |user|
	       		50.times do
				 user.microposts.create!(
				   :content => Faker::Lorem.sentence(5))
			end	 
	       end	       
	  end # desc "Fill database with sample data"
end # namespace :db
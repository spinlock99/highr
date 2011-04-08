# Create rake task in namespace db
namespace :db do
  desc "Fill database with sample data"
  # Task name will be db:populate 
  task :populate => :environment do
    require 'faker'
    # Reset the database
    Rake::Task['db:reset'].invoke
    make_users
    make_teams
    make_memberships
    make_microposts 
  end # desc "Fill database with sample data"
end # namespace :db

def make_users
  # Hannible
  hannible = User.create!(:email => "hannible@ateam.com",
			 :password => "iloveit",
			 :password_confirmation => "iloveit")
  hannible.first_name = "John"
  hannible.last_name = "Smith"
  hannible.save!

  # Face
  face = User.create!(:email => "face@ateam.com",
		      :password => "testing",
		      :password_confirmation => "testing")
  face.first_name = "Templeton"
  face.last_name = "Peck"
  face.save!

  # Murdock
  murdock = User.create!(:email => "murdock@ateam.com",
			 :password => "howlingmad",
			 :password_confirmation => "howlingmad")
  murdock.first_name = "H.M."
  murdock.last_name = "Murdock"
  murdock.save!

  # B.A.
  ba = User.create!(:email => "ba@ateam.com",
		    :password => "suckafool",
		    :password_confirmation => "suckafool")
  ba.first_name = "Bosco Albert"
  ba.last_name = "Baracus"
  ba.save!

end	       

def make_microposts
  User.all(:limit => 6).each do |user|
    50.times do
      content = Faker::Lorem.sentence(5)      
      user.microposts.create!(:content => content)
    end	 
  end
end 

def make_teams
  # The A-Team
  a_team = Team.create!(:name => "The A-Team",
  	       :mission => "In 1972, a crack commando unit was sent to prison by a military court for a crime they didn't commit. They promptly escaped from a maximum security stockade to the Los Angeles underground. Today, still wanted by the government, they survive as soldiers of fortune. If you have a problem, if no-one else can help, and if you can find them, maybe you can hire the A-Team.")
end

def make_memberships
  users = User.all
  ateam = Team.find(1)

  users.each do |user|
    user.join!(ateam)
  end
end


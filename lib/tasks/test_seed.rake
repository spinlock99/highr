#
# Make sure that seed data (e.g. for HVP) is loaded in 
# the test database
#
namespace :db do
  namespace :test do
    task :prepare => :environment do
      Rake::Task["db:seed"].invoke
    end
  end
end
# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
# require factory_girl - not sure if this is necessary but it came from 
# the authlogic/rspec example at:
#   https://github.com/trevmex/authlogic_rails3_example/blob/master/spec/spec_helper.rb
require 'factory_girl'
# Needed to for integration testing with authlogic
#require 'authlogic/test_case'
#include Authlogic::TestCase


# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  # == Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  config.mock_with :rspec

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # create helper function to sign_in users. defined here 
  # so that it is available to all specs.
  def test_sign_in(user)
    controller.sign_in(user)
  end

  # create a helper function to sign_in users in integration
  # tests. for some reason integration tests cannot use the controller
  def integration_sign_in(user)
    visit new_user_session_path
    fill_in :email, :with => user.email
    fill_in :password, :with => user.password
    click_button "Sign in"
  end

  # Webrat configuration
#  Webrat.configure do |config|
#    config.mode = :rack
#  end
end

ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/rspec'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.include Capybara::DSL 
  config.include ApiHelper, :type => :api

  config.use_transactional_fixtures = false

  config.before(:each) do
    if Capybara.current_driver == :rack_test
      DatabaseCleaner.strategy = :transaction
    else
      DatabaseCleaner.strategy = :deletion
    end
    DatabaseCleaner.start
  end
 
  config.after do
    DatabaseCleaner.clean
  end

  config.before(:suite) do
    DatabaseCleaner.clean_with(:deletion)
  end
end


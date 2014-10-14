ENV['RACK_ENV'] = 'test'

require 'rspec'

require File.expand_path('../../config/application', __FILE__)

require './api/server'
require './frontend/server'

require 'database_cleaner'
require 'factory_girl'
require 'faker'
require_relative 'factories/fabrics'

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean_with(:truncation)
    begin
      DatabaseCleaner.start
      FactoryGirl.lint
    ensure
      DatabaseCleaner.clean
    end
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end

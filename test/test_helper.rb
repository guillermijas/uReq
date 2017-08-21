ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport
  class TestCase
    fixtures :all
    include Devise::Test::IntegrationHelpers
  end
end

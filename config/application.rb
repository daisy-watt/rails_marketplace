require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Marketplace
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
# adding in ability for heroku to access the other webhook/stripe credentials for deploying
module Marketplace
  class Application < Rails::Application
    if ENV["PIPE_ENV"].present?
      Rails.application.config.credentials.content_path = Rails.root.join("config/credentials/#{ENV["PIP_ENV"]}.yml.enc")
    end 
  end
end
# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RailsProject66
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    I18n.load_path += Dir[Rails.root.join('lib/locale/*.{rb,yml}')]
    I18n.available_locales = %i[ru en]
    I18n.default_locale = :ru
    config.autoload_paths += %W[#{config.root}/lib]
    routes.default_url_options = { host: ENV.fetch('BASE_URL', nil) }
    config.action_mailer.default_options = { from: ENV.fetch('MAIL_FROM', nil) }
  end
end

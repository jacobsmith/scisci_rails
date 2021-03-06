require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)


module ScisciNotes
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.autoload_paths += %W(#{config.root}/app/services)

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    config.compass.require "modular-scale"


    # kindly borrowed from: https://github.com/sass/sassc-rails/issues/19#issuecomment-106140015
    # which is a work around to issue: https://github.com/Compass/compass-rails/issues/244
    config.assets.paths.concat(
     Compass::Frameworks::ALL.map { |f| f.stylesheets_directory }
   )

    config.generators do |c|
      c.test_framework :rspec
    end
  end
end

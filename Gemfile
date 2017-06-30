source 'https://rubygems.org'

gem 'devise'
gem 'crummy'
gem 'rack-mini-profiler'
gem 'foundation-rails'
gem 'cite-me', '>= 0.1.2'
gem 'pg', '0.18.3'
gem 'activerecord-session_store', github: 'rails/activerecord-session_store'
gem 'aws-s3'
gem 'zip'
gem 'sparkpost_rails'


gem 'stripe', '~> 1.57.1'

gem 'pry'

# help with js runtime
gem 'execjs'

gem 'compass-rails', '1.1.3'
gem 'sass-rails'
gem 'modular-scale', '~> 2.0.0'
gem 'responsive-modular-scale'
gem 'jquery-ui-rails', '~> 4.2.1'
gem "sprockets", "2.11.0"
gem "rake", "11.1.2"

# DataTables for teacher views of student projects
gem 'jquery-datatables-rails', :git => 'git://github.com/rweng/jquery-datatables-rails.git'

gem 'masonry-rails'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 4.0.1'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'jquery-turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
#  gem 'sdoc', require: false
end

gem 'rspec-rails', '~> 3.5', :group => [:test, :development]
group :test do
  gem 'factory_girl_rails', '~> 4.7.0'
  gem 'guard-rspec'
  gem 'capybara'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'guard-livereload', '~> 2.4', require: false
end

group :production do
  # allow it to work on heroku
  gem 'rails_12factor'
end

# Use unicorn as the app server
gem 'unicorn'

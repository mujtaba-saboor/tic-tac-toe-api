# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

gem 'bootsnap', '>= 1.4.4', require: false
gem 'jwt'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rack-cors'
gem 'rails', '~> 6.1.7', '>= 6.1.7.3'
gem 'redis', '~> 3.0'

group :development, :test do
  gem 'pry', '=0.13.1'
  gem 'rspec-rails', '=4.0.1'
end

group :development do
  gem 'listen', '~> 3.3'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :test do
  gem 'database_cleaner', '=2.0.1'
  gem 'factory_bot_rails', '=6.1.0'
  gem 'faker', '=2.17.0'
  gem 'shoulda-matchers', '=4.5.1'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.1"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.4", ">= 7.0.4.3"

# Use SQLite as the database for Active Record
gem "sqlite3", "~> 1.6"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 5.0"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

## JSON API
gem "grape", "~> 1.7"
gem "grape-swagger", "~> 1.6"

group :development do
  gem "rubocop", "~> 1.48"
end

group :development, :test do
  gem "pry", "~> 0.14.2"
  gem "pry-byebug", "~> 3.10"
end

group :test do
  gem "rspec", "~> 3.12"
  gem "rspec-rails", "~> 6.0"
  gem "database_cleaner", "~> 2.0"
  gem "shoulda-matchers", "~> 5.3"
end

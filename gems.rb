# frozen_string_literal: true

source 'https://rubygems.org'

gem 'onlyoffice_digitalocean_wrapper'

group :test do
  gem 'codecov', require: false
  gem 'parallel_tests'
  gem 'rspec'
end

group :development do
  gem 'overcommit', require: false
  gem 'rubocop', require: false
  gem 'rubocop-rspec', require: false
end

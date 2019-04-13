source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.3'

gem 'rails', '~> 5.2.2'
gem 'jquery-rails'
gem 'twitter-bootstrap-rails'
gem 'devise'
gem 'devise-i18n'
gem 'rails-i18n'
gem 'carrierwave'
gem 'rmagick'
gem 'dotenv-rails', groups: [:development, :test, :production]
gem 'fog-aws'
gem 'sassc-rails'
gem 'pg'

gem 'omniauth'
gem 'omniauth-facebook'

gem 'resque'

group :assets do
  gem 'uglifier', '>= 1.3.0'
end

group :test do
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'shoulda-matchers'
  gem 'rails-controller-testing'
end

group :development do
  gem 'byebug'
  gem 'web-console'
  gem 'letter_opener'

  gem 'capistrano'
  gem 'capistrano-rails'
  gem 'capistrano-passenger'
  gem 'capistrano-rbenv'
  gem 'capistrano-bundler'
  gem 'capistrano-resque', require: false
end

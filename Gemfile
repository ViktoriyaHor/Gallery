source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'
gem 'rails', '~> 5.2.3'
gem 'rails-i18n'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.12'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  gem 'rspec-rails', '~> 3.8'
  gem 'factory_bot_rails'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'faker', git: 'https://github.com/stympy/faker.git', branch: 'master'
  gem 'rails-controller-testing'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'capistrano', require: false
  gem 'capistrano-figaro-yml', '~> 1.0.2'
  gem 'rvm1-capistrano3', require: false
  gem 'capistrano-bundler'
  gem 'capistrano-rails', require: false
  gem "letter_opener"
end

group :test do
  gem 'database_cleaner'
  gem 'capybara', '>= 2.15'
  gem 'capybara-email'
  gem "fakeredis", :require => "fakeredis/rspec"
  gem 'selenium-webdriver'
  gem 'chromedriver-helper'
  gem 'resque_spec'
end

group :production do
  gem 'rails_12factor', '0.0.2'
end
gem "fog-aws"
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'bootstrap', '~> 4.3.1'
gem 'jquery-rails', '4.3.5'
gem "haml-rails", "~> 2.0"
gem 'friendly_id', '~> 5.2.4'
gem 'carrierwave', '>= 2.0.0.rc', '< 3.0'
gem 'mini_magick'
gem "devise", ">= 4.7.1"
gem 'devise-i18n'
gem "bootstrap_form", ">= 4.0.0.alpha1"
gem 'devise-bootstrap-views'
gem 'activeadmin'
gem 'omniauth', '~> 1.6'
gem 'omniauth-facebook'
gem 'figaro'
gem 'kaminari'
gem "recaptcha", require: "recaptcha/rails"
gem 'resque', require: 'resque/server'
gem 'resque-web', require: 'resque_web'
gem "nokogiri", ">= 1.10.4"
gem 'font_awesome5_rails'
gem 'file_validators'


gem 'jquery-validation-rails'
source 'https://rubygems.org'
ruby '2.2.4'

gem 'sinatra', require: 'sinatra/base'
gem 'sinatra-contrib', github: 'maccman/sinatra-contrib'
gem 'sinatra-initializers'
gem 'activesupport', require: false
gem 'rack-standards'
gem 'rack-contrib'
# Using fork of Puma with a raised URI length limit. Puma's limit is 2048 chars. This forks limit is 10240.
gem 'puma', github: 'producthunt/puma'
gem 'erubis'
gem 'i18n'
gem 'rake'
gem 'builder'
gem 'json'
gem 'dotenv'
gem 'imgkit'
gem 'rumoji'
gem 'gemoji'
gem 'wkhtmltoimage-binary'
gem 'pry', require: false, group: :production

group :development, :test do
  gem 'pry-byebug'
  gem 'rubocop'
end

group :test do
  gem 'rspec'
  gem 'rack-test'
  gem 'codeclimate-test-reporter'
end

group :development do
  gem 'bundler'
end

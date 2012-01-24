source 'http://rubygems.org'

gem 'rails', '3.1.0'
gem 'heroku'
gem 'omniauth'
gem 'omniauth-twitter'
gem 'omniauth-facebook'
gem 'devise'


group :production do
		gem 'pg'
		gem 'thin'
end

group :development, :test do
	gem 'sqlite3'
	gem 'rails-erd'
end

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'




# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "  ~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end

gem 'jquery-rails'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :test do
  # Pretty printed test output
  gem 'turn', '< 0.8.3', :require => false
end

source 'https://rubygems.org'
gem 'rails', '4.0.0'

# Back-end
gem 'mysql2'
gem 'unicorn'

# Front-end
gem 'sass-rails', '~> 4.0.0'
gem "slim-rails"
gem "font-awesome-rails"
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'

# Utilities
gem 'bcrypt-ruby', '~> 3.0.0'
gem 'uglifier', '>= 1.3.0' # Use Uglifier as compressor for JavaScript assets
gem 'aws-sdk'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby
gem 'rb-readline', '~> 0.4.2' # for AMI

# Use ActiveRecord for session
gem 'activerecord-session_store', github: 'rails/activerecord-session_store'
# For thumbnails
gem 'paperclip'
gem 'validates_email_format_of'

gem 'i18n_generators'
gem 'kaminari'


# For non-production

group :development, :test do
  gem 'rspec-rails', '~> 2.0'
end

group :development do
  gem 'pry'
  gem 'pry-rails'
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

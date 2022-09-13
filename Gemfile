source 'https://rubygems.org'

ruby '2.6.3'
#ruby '3.1.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.0'

# Use sqlite3 as the database for Active Record
#gem 'sqlite3'
gem 'devise'
gem 'devise_invitable', '~> 2.0.0'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
#gem 'jquery-rails'
gem 'jquery-rails', '4.2.2'
gem 'jquery-ui-rails', '6.0.1'
gem 'data-confirm-modal'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
#gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

#bootstrap it up
gem 'twitter-bootstrap-rails'
gem 'devise-bootstrap-views'
gem 'bootstrap-datepicker-rails', '~> 1.8.0'

#for image uploading
gem 'carrierwave', '~> 2.0'
gem 'mini_magick', '4.9.5'
gem 'fog-aws'

#for testing
gem 'sql_queries_count'

#for background jobs
gem 'delayed_job_active_record'
gem "daemons"

#for search
gem 'ransack', '2.1.1'
#for reports
gem 'axlsx_rails', '0.5.2'

#for charts
gem 'chartkick', '2.3.5'


gem 'will_paginate', '3.1.5'
gem 'will_paginate-bootstrap', '1.0.1'

gem 'sendgrid-ruby'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'sqlite3', '~> 1.3.6'
  #gem 'sqlite3', '~> 1.4'
  gem 'byebug', platform: :mri
  
  #gem 'bullet'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'wkhtmltopdf-binary-edge', '0.12.4'
end

group :production do
  gem 'pg', '~> 0.18'
  gem 'rails_12factor'
  gem 'wkhtmltopdf-heroku'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]


# For Generating PDF
gem 'wicked_pdf', '1.4.0'
#gem 'wkhtmltopdf-binary-edge', '0.12.4'
#gem 'wkhtmltopdf-heroku', '2.12.4.0'
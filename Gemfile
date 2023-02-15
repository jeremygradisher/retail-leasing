source 'https://rubygems.org'

ruby '3.1.3'
gem 'rails', '~> 7.0', '>= 7.0.4.2'

# Use sqlite3 as the database for Active Record
#gem 'sqlite3'
gem 'devise'
gem 'devise_invitable'
# Use Puma as the app server
gem 'puma'
# Use SCSS for stylesheets
#gem 'sassc'
gem 'sassc-rails'
# Use Uglifier as compressor for JavaScript assets
#gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
#gem 'jquery-rails'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'data-confirm-modal'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
#gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
#gem 'jbuilder', '~> 2.5'
gem 'jbuilder'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

#bootstrap it up
gem 'twitter-bootstrap-rails'
gem 'devise-bootstrap-views'
gem 'bootstrap-datepicker-rails'

#for image uploading
gem 'carrierwave'
gem 'mini_magick'
gem 'fog-aws'

#for testing
gem 'sql_queries_count'

#for background jobs
gem 'delayed_job_active_record'
gem "daemons"

#for search
#gem 'ransack', '2.1.1'
gem 'ransack'
#for reports
#gem 'axlsx_rails', '0.5.2'
#gem 'axlsx_rails', '~> 0.6.1'
gem 'caxlsx'
gem 'caxlsx_rails'

# For Generating PDF
#gem 'wicked_pdf', '1.4.0'
gem 'wicked_pdf'
#gem 'wkhtmltopdf-binary-edge', '0.12.4'
#gem 'wkhtmltopdf-heroku', '2.12.4.0'


#for charts
gem 'chartkick'


#gem 'will_paginate', '3.1.5'
gem 'will_paginate'
#gem 'will_paginate-bootstrap', '1.0.1'
gem 'will_paginate-bootstrap'

gem 'sendgrid-ruby'


gem 'sprockets-rails', :require => 'sprockets/railtie'

#gem 'pg', '~> 0.18'
gem 'pg'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  gem 'listen'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  #gem 'spring-watcher-listen'
  #gem 'wkhtmltopdf-binary-edge', '0.12.4'
  gem 'wkhtmltopdf-binary'
end

group :production do
  #gem 'pg', '~> 0.18'
  gem 'rails_12factor'
  #gem 'wkhtmltopdf-heroku'
  gem 'wkhtmltopdf-heroku', '2.12.6.1.pre.jammy'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
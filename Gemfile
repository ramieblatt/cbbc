source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.4'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
gem 'active_model_serializers'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# ActiveRecord gems start
gem 'pg'
# gem 'postgresql_cursor' # Right now not in use but could be useful
# gem 'pg_search', git: 'https://github.com/Casecommons/pg_search' #, git: 'https://github.com/warmlyyours/pg_search'
# gem 'arel-helpers'
# gem 'postgres_ext'
# gem 'ransack'
# gem 'activerecord_any_of'
# gem 'postgres-copy'
# gem 'pghero'
# gem 'pg_query'
# gem 'activerecord-collection_cache_key'
# PostGres gems end

# Ethereum/IPFS gems start
gem 'ipfs-api', '~> 0.3.0'
# gem 'ethereum.rb'
gem 'ethereum.rb', git: 'https://github.com/ramieblatt/ethereum.rb' # using fork because some rake tasks broken with later versions of parity
gem 'web3-eth'
# Ethereum gems end

# Toolset gems start
gem 'kaminari'
gem 'simple_form'
# Toolset gems end

gem 'bootstrap-sass'
gem "bootstrap-table-rails"
gem 'bootstrap-slider-rails'
gem 'jquery-rails'
gem 'jquery-ui-sass-rails'
gem 'jquery-timepicker-rails'
gem 'jquery-inputmask-rails'
gem 'jquery-fileupload-rails'
gem 'font-awesome-rails'

gem 'lockup'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data'

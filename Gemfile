#source 'https://rubygems.org'
source 'http://ruby.taobao.org/'
ruby '2.0.0'
gem 'rails', '4.0.0'

#gem 'railties', '4.0.0'
#-------------------------------------------
## basic
#-------------------------------------------
# Use unicorn as the app server
gem 'unicorn'

# ImageUploader
gem 'carrierwave'
gem "mini_magick"

gem "settingslogic", "2.0.9"
#-------------------------------------------
# search

# gem 'redis','2.1.1'
# gem 'chinese_pinyin', '~> 0.4.1'
# gem 'rmmseg-cpp-huacnlee', '~> 0.2.9'
# gem 'redis-namespace','~> 1.0.2'
# gem 'redis-search', '~> 0.6.3'


#for rake
# Web Spider Framework
gem 'anemone'

# Html Parser gem
gem 'nokogiri'

#-------------------------------------------
## local
#-------------------------------------------
group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails', '2.13.1'
  gem 'faker', '1.1.2'
  gem "pry-rails", "0.3.2"
  gem "pry-doc", "0.4.6"
end

group :test do
  #gem 'selenium-webdriver', '2.0.0'
  #gem 'capybara', '2.1.0'
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end


group :production do
  gem 'pg'
  gem 'rails_12factor'
end
#-------------------------------------------

#-------------------------------------------
## css,js part
#-------------------------------------------
gem 'will_paginate', '3.0.4'
gem 'sass-rails', '4.0.0'
gem "bootstrap-sass", "~> 3.0.0.0"
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'coffee-rails', '4.0.0'
gem 'simple_form'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '1.3.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '1.2'

#-------------------------------------------

#-------------------------------------------
## user model part 
#-------------------------------------------
gem "devise", "3.0.3"
gem "omniauth", "1.1.4"
gem "omniauth-github", "1.1.1"
gem "omniauth-weibo-oauth2", "0.3.0"
gem "omniauth-google", "1.0.2"
gem "omniauth-douban-oauth2", "0.0.6"
gem "cancan", "1.6.10"
#-------------------------------------------

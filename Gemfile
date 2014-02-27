# coding: utf-8
source 'http://ruby.taobao.org'

ruby '2.0.0'

gem 'rails', '4.0.0'

group :development, :test do
  #gem 'sqlite3', '1.3.7'
  gem 'rspec-rails', '2.13.1'
  gem 'factory_girl_rails'
end

group :test do
  gem 'rspec-rails', '2.13.1'
  gem 'database_cleaner'
  gem 'mongoid-rspec'
  gem 'selenium-webdriver', '~> 2.35.1'
  gem 'capybara', '2.1.0'
  gem 'faker',"~> 1.1.2"
  gem "rspec-cells"
end

gem 'sass-rails'
gem 'uglifier', '2.1.1'
gem 'coffee-rails', '4.0.0'
gem 'jquery-rails', '2.2.1'
gem 'turbolinks', '1.1.1'
gem 'jbuilder', '1.0.2'
gem 'rails-i18n', '~> 4.0.0.pre'

# cell
gem  "cells"

# Mongoid 辅助插件
gem "mongoid", github: 'mongoid/mongoid', ref: '11e45e5a30a45458b83db99ab6c9d9ccc337e66f'
gem "bson_ext"
#gem 'mongoid_auto_increment_id', "0.6.1"
gem 'mongoid_rails_migrations', '1.0.0'
gem "simple_enum"

# 用户系统
gem 'devise', '3.0.1'
gem 'devise-encryptable', '0.1.2'

# 分页
gem 'kaminari'
gem 'kaminari-bootstrap', '~> 0.1.3'

#表单
gem 'simple_form'

# Bootstrap
gem 'bootstrap-sass', '~> 3.1.1'
gem 'font-awesome-sass'
gem 'bootstrap_helper'
gem "select2-rails"
gem 'tagmanager-rails'
gem 'jquery-inputmask-rails'

# html5 editor
gem "summernote-rails", github: 'rorlab/summernote-rails'

group :doc do
  gem 'sdoc', '0.3.20', require: false
end

group :production do
  #gem 'pg', '0.15.1'
end

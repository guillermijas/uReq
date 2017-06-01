source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

source 'https://rails-assets.org' do
  gem 'rails-assets-tether', '>= 1.3.3'
end

gem 'bootstrap', '~> 4.0.0.alpha6'
gem 'cancancan'
gem 'ckeditor', github: 'galetahub/ckeditor'
gem 'coffee-rails', '~> 4.2'
gem 'devise'
gem 'font-awesome-sass', '~> 4.7.0'
gem 'haml-rails'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'paperclip'
gem 'puma', '~> 3.7'
gem 'rails', '~> 5.1.1'
gem 'ransack'
gem 'sass-rails', '~> 5.0'
gem 'seed_dump'
gem 'simple_form', '~> 3.2', '>= 3.2.1'
gem 'sprockets-rails'
gem 'sqlite3'
gem 'truncate_html'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.0.1'
gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'foundation-rails'
gem 'devise'
gem 'jquery-rails'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem "slim-rails"
gem 'sunspot_rails'

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'sqlite3'
end

group :production do
	gem 'sunspot_solr'
	gem 'pg'
end	

group :development do
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'better_errors'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

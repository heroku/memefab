source 'https://rubygems.org'

ruby File.read(File.join(__dir__, ".ruby-version"))

gem 'rails', '~> 5.1.6', '>= 5.1.6.1'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0', '>= 5.0.8'
gem 'uglifier', '>= 1.3.0'
gem 'bootstrap', '~> 4.1.2'
gem 'cloudinary'

group :development, :test do
  gem 'dotenv-rails', '>= 2.6.0'
  gem 'minitest-rails', '>= 5.1.0'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '~> 3.0', '>= 3.0.0'
  gem 'selenium-webdriver'
end

group :development do
  gem 'web-console', '>= 4.0.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

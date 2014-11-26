source "http://artifactory.blinkbox.local/artifactory/api/gems/bbb-gems/"
source "http://artifactory.blinkbox.local/artifactory/api/gems/rubygems/"
ruby '2.1.3'

group :automation_libs do
  gem 'cucumber'
  gem 'capybara', '~> 2.4'
  gem 'capybara-angular'
  gem 'rspec-collection_matchers'
  gem 'selenium-webdriver', '~> 2.39'
  gem 'site_prism'
end

group :misc_libs do
  gem 'activesupport'
  gem 'cucumber-helpers'
  gem 'i18n'
  gem 'rake'
  gem 'Platform'
end

group :ci do
  gem 'parallel_tests'
  gem 'headless'
end

group :api do
  gem 'multi_json'
  gem 'httpclient'
  gem 'cucumber-rest'
end

group :reporting do
  gem 'cuporter'
end

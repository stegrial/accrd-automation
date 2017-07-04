require_relative '../pages/google_page'
require 'capybara'

include Search

Given(/^User navigate on search page$/) do
  visit '/'
  page.should have_content 'English'
end

And(/^User input (.*) on search field$/) do |search_string|
  search search_string
end

Then /^I should see results$/ do
  page.expect have_css('div#res li')
end
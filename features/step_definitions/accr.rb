require_relative '../pages/create_accr_page.rb'
require 'capybara'

include Create

When(/^Пользовалтель открывает страницу создания акредетива$/) do
  open_page
end
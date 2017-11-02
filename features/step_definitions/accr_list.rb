# encoding: utf-8

require_relative '../pages/accr_list_page.rb'
require 'capybara'

include ACCRList
include Utils


When(/^"([^"]*)" открывает страницу поиска заявок клиента$/) do |user|
  open_accr_list_page user
end

When(/^Выбирает любую заявку$/) do
  sleep 2
  edit_accr 'Редактировать'
end
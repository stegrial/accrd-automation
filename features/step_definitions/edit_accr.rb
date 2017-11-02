# encoding: utf-8

require_relative '../pages/accr_edit_page.rb'
require 'capybara'

include ACCREditing
include Utils


When(/^"([^"]*)" открывйцуает страницу поиска заявок клиента$/) do |user|
  open_accr_list_page user
end


When(/^Пользователь выбирает "([^"]*)" на странице редактирования аккредетива$/) do |action|
  press_edit_button action
end
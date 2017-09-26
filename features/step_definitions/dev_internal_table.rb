# encoding: utf-8

require_relative '../pages/dev_internal_table_page.rb'
require 'capybara'

include Dev_internal_table
include Utils



When(/^"([^"]*)" открывает страницу со сводной таблицей для внутреннего пользования$/) do |user|
  open_dev_table_page user
end

When(/^Нажимает на кнопку \- Выбор компании$/) do
  press_choose_comp_button
end

When(/^Убирает\/Устанавливает флажки для компаний "([^"]*)"$/) do |list_companies|
  clear_comp_checkboxes list_companies
end

When(/^Видит что информация для компании "([^"]*)" не отображается$/) do |comp_name|
  check_comp_info_absent comp_name
end

When(/^Видит в таблице информацию для компании "([^"]*)"$/) do |comp_name|
  check_comp_info_present comp_name
end

When(/^Находит в таблице новую заявку и нажимает на кнопку \- Раскрыть$/) do
  press_disclose_button
end

When(/^Прикладывает документ раскрытия$/) do
  upload_disclosure_document
end

When(/^Видит что кнопка \- Отправить недоступна$/) do
  check_send_button_disabled
end

When(/^Видит что кнопка \- Раскрыть не отображается$/) do
  check_send_button_absent
end
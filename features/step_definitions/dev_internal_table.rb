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

When(/^Убирает\/Устанавливает флажки для компаний$/) do
  clear_comp_checkboxes
end

When(/^Видит что информация для компаний не отображается$/) do
  check_comp_info_absent
end

When(/^Видит что информация для компаний отображается$/) do
  check_comp_info_present
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

When(/^Обновляет список аккредитивов$/) do
  refresh_accr_list
end

When(/^Видит что список аккредитивов обновлен$/) do
  see_accr_list_refreshed
end

When(/^Открывает Архив аккредитивов$/) do
  open_accr_archive
end

When(/^Видит что Архив аккредитивов открыт$/) do
  see_accr_archive_opened
end

When(/^Возвращается обратно к списку не раскрытых аккредитивов$/) do
  return_accr_list
end

When(/^Видит что отображается список не раскрытых аккредитивов$/) do
  see_accr_list_opened
end
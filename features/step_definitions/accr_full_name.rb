# encoding: utf-8

require_relative '../pages/accr_full_name_page.rb'

require 'capybara'

include Search_full_name
include Utils


When(/^"([^"]*)" открывает страницу с формой поиска по ФИО$/) do |user|
  open_search_full_name_page user
end

When(/^Видит что по ФИО заявка не найдена$/) do
  sleep 2
  page.should have_current_path("http://ufrvpndev/accrd-ui/disclose/search", url: true)
  page.should have_text('ФИО покупателя')
end

When(/^Видит что найден список всех заявок от клиента "([^"]*)"$/) do |value|
  sleep 2
  page.should have_current_path("http://ufrvpndev/accrd-ui/disclose/search", url: true)
  page.should have_xpath("//div[contains(@class, 'accrd-order-short-info')]//span[text()='#{value}']")
end

When(/^Нажимает на кнопку Приложить документы$/) do
  press_attach_documents_button
end

When(/^Пользователя перенаправляет на страницу для раскрытия первой заявки$/) do
  page.should have_current_path("http://ufrvpndev/accrd-ui/disclose/pack/ACCD00001", url: true)
end

When(/^"([^"]*)" открывает страницу для раскрытия новой заявки$/) do |user|
  open_attach_documents_page user
end
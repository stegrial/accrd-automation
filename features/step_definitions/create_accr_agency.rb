# encoding: utf-8

require_relative '../pages/create_accr_agency_page.rb'

require 'capybara'
require 'date'

include Create_agency
include Utils


When(/^Выбирает Тип продавца "([^"]*)"$/) do |seller_type|
  select_seller_type seller_type
end

When(/^Вводит ФИО продавца "([^"]*)"$/) do |name|
  fill_full_name name
end

When(/^Вводит ИНН продавца физ\.лица "([^"]*)"$/) do |number|
  fill_inn_number_ind number
end

When(/^Вводит Серию паспорта "([^"]*)"$/) do |series|
  fill_passport_series series
end

When(/^Вводит Номер паспорта "([^"]*)"$/) do |number|
  fill_passport_number number
end

When(/^Вводит Кем выдан паспорт "([^"]*)"$/) do |organization|
  fill_issued_by organization
end

When(/^Указывает Когда выдан паспорт \(текущая дата\)$/) do
  fill_issued_date Date.today.strftime('%d.%m.%Y')
end

When(/^Указывает Дату рождения \(текущая дата\)$/) do
  fill_birth_date Date.today.strftime('%d.%m.%Y')
end

When(/^Вводит Место рождения "([^"]*)"$/) do |birth_place|
  fill_birth_place birth_place
end

When(/^Указывает Гражданство "([^"]*)"$/) do |citizenship|
  select_citizenship citizenship
end

When(/^Вводит Адрес регистрации "([^"]*)"$/) do |address|
  fill_registration_address address
end

When(/^Видит что поле ФИО продавца обязательно$/) do
  xpath = "//span[contains(@class,'input_focused')]//input[@name='search-seller--individual--fullName']"
  page.should have_xpath(xpath)
end

When(/^Видит что поле ИНН продавца физ\.лица обязательно$/) do
  xpath = "//span[contains(@class,'input_focused')]//input[@name='search-seller--individual--inn']"
  page.should have_xpath(xpath)
end

When(/^Видит что сообщение "([^"]*)" не отображается$/) do |notice|
  page.should_not have_text(notice)
end

When(/^Видит что поле Серия паспорта обязательно$/) do
  xpath = "//span[contains(@class,'input_focused')]//input[@name='search-seller--individual--passport-series']"
  page.should have_xpath(xpath)
end

When(/^Видит что кнопка Распечатать доступна$/) do
  page.should_not have_xpath("//button[@data-reactid='174' and @disabled]")
end

When(/^Видит что поле Номер паспорта обязательно$/) do
  xpath = "//span[contains(@class,'input_focused')]//input[@name='search-seller--individual--passport-number']"
  page.should have_xpath(xpath)
end

When(/^Видит что поле Кем выдан обязательно$/) do
  xpath = "//span[contains(@class,'input_focused')]//input[@name='search-seller--individual--passport-issued-by']"
  page.should have_xpath(xpath)
end

When(/^Видит что поле Когда выдан паспорт обязательно$/) do
  page.should have_xpath("//span[contains(@class,'input_focused')]//input[@tabindex='46']")
end

When(/^Указывает дату Когда выдан паспорт "([^"]*)"$/) do |date|
  fill_issued_date date
end

When(/^Кликает на поле Когда выдан паспорт$/) do
  click_issued_date
end

When(/^Видит что поле Дата рождения обязательно$/) do
  page.should have_xpath("//span[contains(@class,'input_focused')]//input[@tabindex='47']")
end

When(/^Указывает Дату рождения "([^"]*)"$/) do |date|
  fill_birth_date date
end

When(/^Кликает на поле Дата рождения$/) do
  click_birth_date
end

When(/^Видит что поле Место рождения обязательно$/) do
  xpath = "//span[contains(@class,'input_focused')]//input[@name='search-seller--individual--birth-place']"
  page.should have_xpath(xpath)
end
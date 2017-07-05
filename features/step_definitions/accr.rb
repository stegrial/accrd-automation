# encoding: utf-8

require_relative '../pages/create_accr_page.rb'
require_relative '../pages/accrd_page.rb'

require 'capybara'

include Create
include Utils
include Accr


When(/^"([^"]*)" открывает страницу создания аккредетива$/) do |user|
  open_page user
end

When(/^Вводит номер счета продавца "([^"]*)"$/) do |number|
  fill_invoice_number number
end

When(/^Выбирает "([^"]*)" зарплатный счет$/) do |money_number|
  select_salary_account money_number
end

When(/^Вводит сумму акредетива "([^"]*)"$/) do |amount_accr|
  fill_amount_accr amount_accr
end

When(/^Вводит адрес приобритения недвижимости "([^"]*)"$/) do |address|
  fill_address_real_estate address
end

When(/^Вводит номер договора "([^"]*)"$/) do |number|
  fill_contract_number number
end

When(/^Указывает текущую дату$/) do
  fill_current_contract_date
end

When(/^Вводит наименнование договора "([^"]*)"$/) do |name|
  fill_contract_name name
end

When(/^Загружает копию договора купли\-продажи$/) do
  upload_contract_copy
end

When(/^Указывает условия исполнения договора "([^"]*)"$/) do |conditions|
  fill_conditions conditions
end

When(/^Распечатывает заявление$/) do
  print_statement
end

When(/^Прекрепляет файл$/) do
  upload_statement
end

When(/^Открывает аккредитив$/) do
  open_accr
end

When(/^Всего к оплате "([^"]*)"$/) do |count|
  page.should have_text(count)
end

When(/^Комисия составляет "([^"]*)"$/) do |count|
  page.should have_text(count)
end

When(/^Выбирает покупку "([^"]*)"$/) do |pay_type|
  select_pay_type pay_type
end

When(/^Пользователя перенаправляет на страницу аккредетива$/) do
  page.should have_xpath("//h1[@data-reactid='26']")
  page.should have_text('Покупка недвижимости через Аккредитив')
end

When(/^Видит ошибку "([^"]*)"$/) do |arg|
  page.should have_text(arg)
end
# encoding: utf-8

require_relative '../pages/create_accr_page.rb'

require 'capybara'

include Create
include Utils


When(/^"([^"]*)" открывает страницу создания аккредетива$/) do |user|
  open_page user
end

When(/^Вводит номер счета продавца "([^"]*)"$/) do |number|
  fill_invoice_number number
end

When(/^Выбирает "([^"]*)" зарплатный счет$/) do |money_number|
  sleep 3
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
  fill_contract_date Time.now.strftime('%d.%m.%Y')
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

When(/^Видит что кнопки "([^"]*)" недоступны$/) do |list_buttons|
  butt = list_buttons.split(/,/)
  butt.each do |i|
    page.should have_xpath(get_button_path(i))
  end
end

When(/^Видит что поле "([^"]*)" осталось пустым$/) do |field_name|
  find(:xpath, get_field_path(field_name)).value.should == ''
end

When(/^Указывает дату договора "([^"]*)"$/) do |date|
  fill_contract_date date
end

When(/^Кликает на поле "([^"]*)"$/) do |field_name|
  find(:xpath, get_field_path(field_name)).click
end

When(/^Видит календарь на текущий месяц и год$/) do
  date_compare Time.now.strftime('%m'), year = Time.now.strftime('%Y')
end

When(/^Нажимает в календаре на "двойную стрелку \- назад"$/) do
  calendar_double_arrow_back
end

When(/^Видит что год изменился на предыдущий$/) do
  date_compare Time.now.strftime('%m'), year = Time.now.strftime('%Y').to_i - 1
end

When(/^Нажимает в календаре на "двойную стрелку \- вперед"$/) do
  calendar_double_arrow_forward
end

When(/^Нажимает в календаре на "одинарную стрелку \- назад"$/) do
  calendar_single_arrow_back
end

When(/^Видит что месяц изменился на предыдущий$/) do
  date_compare (Time.now - 2592000).strftime('%m'), Time.now.strftime('%Y')
end

When(/^Нажимает в календаре на "одинарную стрелку \- вперед"$/) do
  calendar_single_arrow_forward
end

When(/^Выбирает в календаре текущее число месяца$/) do
  select_current_date Time.now.strftime('%d').to_i
end

When(/^Видит в поле "([^"]*)" текущую дату$/) do |field_name|
  find(:xpath, get_field_path(field_name)).value.should == Time.now.strftime('%d.%m.%Y')
end

When(/^Видит календарь с выбранной датой$/) do
  current_day = Time.now.strftime('%d').to_i
  page.should have_xpath("//td[contains(@class, 'calendar__day_state_current') and contains(., '#{current_day}')]")
end

When(/^Видит имя прикрепленного файла копии договора купли\-продажи$/) do
  page.should have_xpath("//div[@data-reactid='147']//span[@class='attach__text']")
end

When(/^Удаляет прикрепленный файл копии договора купли\-продажи$/) do
  remove_contract_copy
end

When(/^Видит что файл копии договора купли\-продажи удален$/) do
  page.should_not have_xpath("//div[@data-reactid='147']//span[@class='attach__text']")
end

When(/^Видит в поле "([^"]*)" номер "([^"]*)"$/) do |field_name, field_value|
  find(:xpath, get_field_path(field_name)).value.should == field_value
end

When(/^Видит сообщение "([^"]*)"$/) do |notice|
  page.should have_text(notice)
end

# When(/^Вводит БИК банка продавца "([^"]*)"$/) do |number|
#   fill_BIC_number number
# end
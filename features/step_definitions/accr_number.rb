# encoding: utf-8

require_relative '../pages/accr_number_page.rb'

require 'capybara'

include Search_number
include Utils


When(/^"([^"]*)" открывает страницу с формой поиска заявки по номеру$/) do |user|
  open_search_number_page user
end

When(/^Нажимает на кнопку "([^"]*)"$/) do |button_name|
  press_find_button
end

When(/^Видит что кнопка "([^"]*)" недоступна$/) do |button_name|
  page.should have_xpath("//button[(@data-reactid='40' or @data-reactid='38') and @disabled ]")
end

When(/^Вводит "([^"]*)"$/) do |search_value|
  enter_search_value search_value
end

When(/^Видит что по номеру заявка не найдена$/) do
  page.should have_current_path("http://ufrvpndev/accrd-ui/accr/search", url: true)
  page.should have_text('Номер заявки')
end

When(/^Запоминает новый номер заявки на аккредитив$/) do
  remember_new_number
end

When(/^Вводит новый номер заявки$/) do
  enter_search_value $new_generated_accr_number
end

When(/^Вводит несуществующий номер заявки$/) do
  enter_no_exist_number
end

When(/^Пользователя перенаправляет на страницу заявки$/) do
  page.should have_current_path("http://ufrvpndev/accrd-ui/accr/approve/#{$new_generated_accr_number}", url: true)
  page.should have_text('При проверке заявки')
end

When(/^Видит что номер заявки соответствует искомой$/) do
  find(:xpath, "//span[contains(@class, 'label__inner')and contains(., 'ACCD')]").text.should == $new_generated_accr_number
end

When(/^Переходит по ссылке \- Поиск заявки для раскрытия$/) do
  redirect_to_full_name_search
end

When(/^Пользователя перенаправляет на страницу с формой поиска по ФИО$/) do
  page.should have_current_path("http://ufrvpndev/accrd-ui/disclose/search", url: true)
  page.should have_text('ФИО покупателя')
end

When(/^Сохраняет \- Копию договора купли продажи$/) do
  save_contract_copy
end

When(/^Сохраняет \- Копию анкеты$/) do
  save_statement
end

When(/^Нажимает на кнопку Редактировать$/) do
  press_edit_button
end

When(/^Пользователя перенаправляет на страницу с формой для редактирования заявки$/) do
  page.should have_current_path("http://ufrvpndev/accrd-ui/accr/edit/#{$new_generated_accr_number}", url: true)
  page.should have_xpath("//h4[text()='Покупка недвижимости через Аккредитив']")
end

When(/^Видит что форма заполнена$/) do
  page.should_not have_xpath("//button[contains(@class, 'new-accreditive__submit-button')and @disabled]")
end

When(/^Подтверждает изменения$/) do
  confirm_changes
end

When(/^Пользователь видит что сумма аккредитива изменена$/) do
  page.should have_xpath("//span[text()='1 ₽']")
end

When(/^Нажимает на кнопку Подтвердить$/) do
  press_confirm_button
end

When(/^Заявка подтверждена$/) do
  page.should have_current_path("http://ufrvpndev/accrd-ui/accr/approve/#{$new_generated_accr_number}", url: true)
  page.should_not have_xpath("//span[contains(@class, 'button__text')and contains(., 'Подтвердить')]")
  page.should_not have_xpath("//span[contains(@class, 'button__text')and contains(., 'Редактировать')]")
  page.should have_text('Заявка подтверждена')
end
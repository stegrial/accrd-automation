# encoding: utf-8

require_relative '../pages/accr_number_page.rb'

require 'capybara'

include Search_number
include Utils


When(/^"([^"]*)" открывает страницу с формой поиска по номеру$/) do |user|
  open_search_number_page user
end

When(/^Нажимает на кнопку Найти$/) do
  press_find_button
end

When(/^Видит что кнопка Найти недоступна$/) do
  sleep 2
  page.should have_xpath("//button[@data-reactid='40' and @disabled]")
end

When(/^Вводит номер заявки "([^"]*)"$/) do |number|
  enter_accr_number number
end

When(/^Видит что заявка не найдена$/) do
  sleep 2
  page.should have_text('Поиск заявки на аккредитив')
  page.should have_text('Номер заявки')
end

When(/^Запоминает новый номер заявки на аккредитив$/) do
  remember_new_number
end

When(/^Вводит новый номер заявки$/) do
  enter_accr_number $new_generated_accr_number
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
# encoding: utf-8

require_relative '../pages/search_accr_number_page.rb'

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
  #page.should have_xpath("//span[contains(@class, 'button__text') and contains (., 'Подтвердить')]")
  sleep 2
  page.should have_text('Поиск заявки на аккредитив')
  page.should have_text('Номер заявки')
end
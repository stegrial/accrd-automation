# encoding: utf-8

require_relative '../pages/login_in_accr_page.rb'

require 'capybara'

include Login
include Utils


When(/^Пользователь открывает страницу авторизации$/) do
  open_login_page
end

When(/^Нажимает на кнопку Войти$/) do
  press_login_button
end

When(/^Пользователь не смог авторизироваться$/) do
  page.should have_xpath("//button[@data-reactid='44']")
  page.should have_text('Необходимо авторизоваться')
end

When(/^Вводит логин "([^"]*)"$/) do |login|
  enter_login login
end

When(/^Вводит пароль "([^"]*)"$/) do |password|
  enter_password password
end

When(/^Пользователь переходит на страницу создания аккредитива$/) do
  page.should have_xpath("//button[@data-reactid='190']")
  page.should have_text('Покупка недвижимости через Аккредитив')
end
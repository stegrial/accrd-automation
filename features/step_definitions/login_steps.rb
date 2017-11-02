# encoding: utf-8

require_relative '../pages/login_page.rb'
require_relative '../pages/create_accr_dev_page.rb'
require 'capybara'

include Login
include Utils
include Create_dev


When(/^Пользователь открывает страницу авторизации$/) do
  open_login_page
  login_page?
end

When(/^Нажимает на кнопку Войти$/) do
  press_login_button
end

When(/^Пользователь не смог авторизироваться$/) do
  authorize?
end

When(/^Вводит логин "([^"]*)"$/) do |login|
  enter_login login
end

When(/^Вводит пароль "([^"]*)"$/) do |password|
  enter_password password
end

When(/^Пользователь переходит на страницу создания аккредитива$/) do
  new_accrd_page?
end

When(/^ставим тест на паузу$/) do
sleep 500
end
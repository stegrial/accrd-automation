# encoding: utf-8

require_relative '../pages/accr_commenting_page.rb'
require 'capybara'
require 'test/unit'



include Commenting
include Utils


When(/^"([^"]*)" открывает сводную страницу заявки$/) do |user|
  open_accr_commenting_page user
end

When(/^Нажимает на кнопку \- Отправить$/) do
  press_send_button
end

When(/^Видит что оставлен комментарий с текстом "([^"]*)"$/) do |comment_text|
  page.should have_xpath("//div[contains(@class, 'comment')]//span[text()='#{comment_text}']")
end

When(/^Видит что комментарий оставлен владельцем аккаунта$/) do
  account_owner = find(:xpath, "//div[@class='header__user']//span[@class='link__text']").text
  comments = all(:xpath, "//div[@class='comment__one-line']")

  # Get only last comment
  comments[comments.length - 1].text.should have_text(account_owner)
end

When(/^Видит что дата оставления комментария соответсвует текущей$/) do
  date_compare_statement Time.now.strftime('%Y'), Time.now.strftime('%m'), Time.now.strftime('%d')
end

When(/^Вводит комментарий "([^"]*)"$/) do |comment_text|
  enter_comment comment_text
end
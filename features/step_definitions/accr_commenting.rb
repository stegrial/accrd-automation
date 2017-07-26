# encoding: utf-8

require_relative '../pages/accr_commenting_page.rb'

require 'capybara'

include Commenting
include Utils


When(/^"([^"]*)" открывает сводную страницу заявки$/) do |user|
  open_accr_commenting_page user
end

When(/^Нажимает на кнопку Отправить$/) do
  press_send_button
end

When(/^Видит что оставлен комментарий с текстом "([^"]*)"$/) do |comment_text|
  sleep 2
  page.should have_xpath("//div[contains(@class, 'comment')]//span[text()='#{comment_text}']")
end

When(/^Видит что комментарий оставлен владельцем аккаунта$/) do
  account_owner = find(:xpath, "//span[@data-reactid='18']").text
  xpath = "//div[contains(@class, 'comment')]//span[@class='label__inner' and contains(., '#{account_owner}')]"
  page.should have_xpath(xpath)
end

When(/^Видит что дата оставления комментария соответсвует текущей$/) do
  date_compare_statement Time.now.strftime('%Y'), Time.now.strftime('%m'), Time.now.strftime('%d')
end

When(/^Вводит комментарий "([^"]*)"$/) do |comment_text|
  enter_comment comment_text
end
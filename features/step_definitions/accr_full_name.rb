# encoding: utf-8

require_relative '../pages/accr_full_name_page.rb'
require 'capybara'

include Search_full_name
include Utils


When(/^"([^"]*)" открывает страницу с формой поиска заявки по ФИО$/) do |user|
  open_search_full_name_page user
end

When(/^Видит что по ФИО заявка не найдена$/) do
  page.should_not have_xpath("//div[contains(@class, 'accrd-order-short-info')]")
end

When(/^Видит что найден список всех заявок от клиента "([^"]*)"$/) do |value|
  page.should have_current_path("#{Capybara.app_host}accrd-ui/disclose/search", url: true)
  page.should have_xpath("//div[contains(@class, 'accrd-order-short-info')]//span[text()='#{value}']")
end

When(/^Нажимает на кнопку Приложить документы$/) do
  press_attach_documents_button
end

When(/^Видит что созданная заявка отсутствует в списке заявок$/) do
  page.should_not have_text($saved_accrd_num)
end

When(/^Видит что подтвержденная заявка присутствует в списке заявок$/) do
  page.should have_text($saved_accrd_num)
end

When(/^Пользователя перенаправляет на страницу для раскрытия первой заявки$/) do
  url = current_url.to_s[0...-9] #url = URI.parse(current_url).to_s[0...-5]
  puts  "#{Capybara.app_host}accrd-ui/disclose/pack/"
  puts url
  url.should == "#{Capybara.app_host}accrd-ui/disclose/pack/"
end

When(/^"([^"]*)" открывает страницу для раскрытия новой заявки$/) do |user|
  open_attach_documents_page user
end

When(/^Прикладывает "([^"]*)" документ раскрытия$/) do |number|
  upload_disclosure_document number
end

When(/^Видит имя прикрепленного файла документа раскрытия$/) do
  page.should have_xpath("//span[@class='attach__text' and text()='disclosure_document_1.pdf']")
end

When(/^Удаляет прикрепленный файл документа раскрытия$/) do
  remove_disclosure_document
end

When(/^Видит что файл документа раскрытия удален$/) do
  page.should_not have_xpath("//span[@class='attach__text' and text()='disclosure_document_1.pdf']")
end

When(/^Нажимает на кнопку Создать$/) do
  press_create_button
end

When(/^Видит что кнопка Создать недоступна$/) do
  page.should have_xpath("//button[contains(., 'Создать') and @disabled]")
end

When(/^Видит что "([^"]*)" документ раскрытия добавлен$/) do |doc_number|
  page.should have_xpath(get_disclosure_document_path doc_number)
end

When(/^Видит что документ загружен владельцем аккаунта$/) do
  account_owner = find(:xpath, "//span[@data-reactid='18']").text
  page.should have_xpath("//span[@class='label__inner' and contains(., '#{account_owner}')]")
end

When(/^Видит что дата загрузки документа соответствует текущей$/) do
  date_compare_disclosure_doc Time.now.strftime('%Y'), Time.now.strftime('%m'), Time.now.strftime('%d')
end

When(/^Указывает Email "([^"]*)"$/) do |email_address|
  enter_email_address email_address
end

When(/^Видит в поле Email "([^"]*)"$/) do |email_address|
  xpath = "//input[@class='input__control' and @value='#{email_address}']"
  page.should have_xpath(xpath)
end

When(/^Сохраняет документ раскрытия$/) do
  save_disclosure_document
end

When(/^Нажимает на кнопку Вернуться обратно$/) do
  press_return_back_button
end

When(/^Видит что заявка не доступна для приложения документов$/) do
  see_statement_not_available
end
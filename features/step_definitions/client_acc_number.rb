# encoding: utf-8

require_relative '../pages/client_acc_number_page.rb'
require_relative '../pages/accr_number_page.rb'
require_relative '../pages/create_accr_dev_page.rb'
require 'capybara'

include Search_bill
include Search_number
include Create_dev
include Utils


When(/^"([^"]*)" открывает страницу с формой поиска клиента по номеру счета$/) do |user|
  open_search_bill_page user
end

When(/^Видит что поле для поиска клиента осталось пустым$/) do
  find(:xpath, "//span[@data-reactid='33']//input").value.should == ''
end

When(/^Видит что по номеру счета клиент не найден$/) do
  page.should have_current_path("#{Capybara.app_host}accrd-ui/client/search", url: true)
  page.should have_text('Номер счета')
end

When(/^Вводит Номер счета "([^"]*)" на имя "([^"]*)"$/) do |acc_number, client_name|
  enter_search_value acc_number
end

When(/^Вводит уникальный номер договора для "([^"]*)"$/) do |client|
  case client
    when 'первого клиента'
      @unique_contract_num_client_1 = Time.now.to_i
      fill_contract_number @unique_contract_num_client_1
    when 'второго клиента'
      @unique_contract_num_client_2 = Time.now.to_i
      fill_contract_number @unique_contract_num_client_2
    else
      puts 'Error'
  end
end

When(/^Видит заявку с номером договора для "([^"]*)"$/) do |client|
  case client
    when 'первого клиента'
      page.should have_text(@unique_contract_num_client_1)
    when 'второго клиента'
      page.should have_text(@unique_contract_num_client_2)
    else
      puts 'Error'
  end
end

When(/^Видит что заявка с номером договора для "([^"]*)" отсутствует$/) do |client|
  case client
    when 'первого клиента'
      page.should_not have_text(@unique_contract_num_client_1)
    when 'второго клиента'
      page.should_not have_text(@unique_contract_num_client_2)
    else
      puts 'Error'
  end
end

When(/^Вводит имя первого клиента "([^"]*)"$/) do |client_name|
  enter_search_value client_name
end

When(/^Вводит имя второго клиента "([^"]*)"$/) do |client_name|
  enter_search_value client_name
end
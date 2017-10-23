# encoding: utf-8

require_relative '../pages/create_accr_dev_page.rb'
require 'capybara'
require 'date'

include Create_dev
include Utils


When(/^"([^"]*)" открывает страницу с формой создания заявки на аккредитив$/) do |user|
  open_page user
end

When(/^Вводит номер счета продавца "([^"]*)"$/) do |number|
  fill_account_number number
end

When(/^Выбирает "([^"]*)" зарплатный счет$/) do |money_number|
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

When(/^Указывает текущую дату договора$/) do
  fill_contract_date Date.today.strftime('%d.%m.%Y')
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
  check_total_payment count
end

When(/^Комисия составляет "([^"]*)"$/) do |count|
  check_commission count
end

When(/^Пользователя перенаправляет на страницу аккредетива$/) do
  page.should have_xpath("//h4[text()='Покупка недвижимости через Аккредитив']")
  page.should have_xpath("//button[contains(@class, 'button_view_extra')and contains(., 'Новая покупка')]")
end

When(/^Видит ошибку "([^"]*)"$/) do |arg|
  page.should have_text(arg)
end

When(/^Видит что кнопки "([^"]*)" недоступны$/) do |list_buttons|
  check_disabled_buttons list_buttons
end

When(/^Видит что поле "([^"]*)" осталось пустым$/) do |field_name|
  find(:xpath, get_field_path(field_name)).value.should == ''
end

When(/^Указывает дату договора "([^"]*)"$/) do |date|
  fill_contract_date date
end

When(/^Кликает на поле Дата договора$/) do
  click_contract_date
end

When(/^Видит календарь на текущий месяц и год$/) do
  date_compare_calendar Date.today.strftime('%m'), Date.today.strftime('%Y')
end

When(/^Нажимает в календаре на "двойную стрелку \- назад"$/) do
  calendar_double_arrow_back
end

When(/^Видит что год изменился на предыдущий$/) do
  date_compare_calendar Date.today.strftime('%m'), Date.today.prev_year.strftime('%Y')
end

When(/^Нажимает в календаре на "двойную стрелку \- вперед"$/) do
  calendar_double_arrow_forward
end

When(/^Нажимает в календаре на "одинарную стрелку \- назад"$/) do
  calendar_single_arrow_back
end

When(/^Видит что месяц изменился на предыдущий$/) do
  date_compare_calendar Date.today.prev_month.strftime('%m'), Date.today.strftime('%Y')
end

When(/^Нажимает в календаре на "одинарную стрелку \- вперед"$/) do
  calendar_single_arrow_forward
end

When(/^Выбирает в календаре текущее число месяца$/) do
  select_current_date Date.today.to_time.to_i * 1000
end

When(/^Видит в поле "([^"]*)" текущую дату$/) do |field_name|
  find(:xpath, get_field_path(field_name)).value.should == Date.today.strftime('%d.%m.%Y')
end

When(/^Видит календарь с выбранной датой$/) do
  current_day = Date.today.to_time.to_i * 1000
  page.should have_xpath("//td[contains(@class, 'calendar__day_state_current') and @data-day='#{current_day}']")
end

When(/^Удаляет прикрепленный файл копии договора купли\-продажи$/) do
  remove_contract_copy
end

When(/^Видит что файл копии договора купли\-продажи удален$/) do
  page.should_not have_xpath("//div[@data-reactid='165']//span[text()='contract_copy.pdf']")
end

When(/^Видит в поле "([^"]*)" номер "([^"]*)"$/) do |field_name, field_value|
  find(:xpath, get_field_path(field_name)).value.should == field_value
end

When(/^Видит сообщение "([^"]*)"$/) do |notice|
  page.should have_text(notice)
end

When(/^Вводит ИНН продавца юр\.лица "([^"]*)"$/) do |number|
  fill_inn_number_dev number
end

When(/^Видит что поле "([^"]*)" заполнено и недоступно$/) do |field_name|
  find(:xpath, get_disabled_field_path(field_name)).value.should_not == ''
end

When(/^Вводит БИК банка продавца "([^"]*)"$/) do |number|
  fill_bic_number number
end

When(/^Видит что поле "([^"]*)" не заполнено и недоступно$/) do |field_name|
  find(:xpath, get_disabled_field_path(field_name)).value.should == ''
end

When(/^Видит что поле "([^"]*)" не заполнено но доступно$/) do |field_name|
  page.should_not have_xpath(get_disabled_field_path field_name)
  find(:xpath, get_field_path(field_name)).value.should == ''
end

When(/^Вводит ОГРН организации продавца "([^"]*)"$/) do |number|
  fill_ogrn_number number
end

When(/^Вводит Адрес организации продавца "([^"]*)"$/) do |address_org|
  fill_address_seller_org address_org
end

When(/^Вводит Наименование организации продавца "([^"]*)"$/) do |name_org|
  fill_name_seller_org name_org
end

When(/^Выбирает способ покупки "([^"]*)"$/) do |method|
  select_purchase_method method
end

When(/^Удаляет прикрепленный файл заявления$/) do
  remove_statement
end

When(/^Удаляет все прикрепленные файлы заявления$/) do
  remove_all_statements
end

When(/^Видит что прикрепленный файл заявления удален$/) do
  #page.should_not have_xpath("//div[@data-reactid='194']//span[text()='statement.pdf']")
  check_statement_document_list
end

When(/^Нажимает на кнопку Новая покупка$/) do
  press_new_purchase_button
end

When(/^Пользователя перенаправляет на страницу создания аккредетива$/) do
  sleep 3
  page.should have_current_path(Capybara.app_host + 'accrd-ui/accr/new', url: true)
  page.should have_xpath("//h4[text()='Покупка недвижимости через Аккредитив']")
end

When(/^Проверяет незаполненные поля$/) do
  check_accr
end

When(/^Видит что поле Сумма аккредитива не заполнено или заполнено неверно$/) do
  xpath = "//span[contains(@class,'input_focused')]//input[@name='about-accreditive--accreditive-amount']"
  page.should have_xpath(xpath)
end

When(/^Видит что поле Адрес приобретаемой недвижимости не заполнено или заполнено неверно$/) do
  xpath = "//textarea[@name='about-accreditive--real-estate-address' and contains(@class,'textarea_focused')]"
  page.should have_xpath(xpath)
end

When(/^Видит что поле Дата договора не заполнено или заполнено неверно$/) do
  page.should have_xpath("//span[contains(@class,'input_focused')]//input[@data-reactid='149']")
end

When(/^Видит что поле Наименование договора не заполнено или заполнено неверно$/) do
  xpath = "//span[contains(@class,'input_focused')]//input[@name='about-document--contract-name']"
  page.should have_xpath(xpath)
end

When(/^Видит что Копия договора купли\-продажи обязательна$/) do
  # page.should have_xpath("//span[contains(@class, 'is-required')]//input[@data-reactid='175']")
  page.should have_xpath("//span[@data-reactid='171' and contains(@class,'is-required')]")
end

When(/^Видит что поле Условия исполнения договора не заполнено или заполнено неверно$/) do
  xpath = "//textarea[@name='about-document--contract-conditions' and contains(@class,'textarea_focused')]"
  page.should have_xpath(xpath)
end

When(/^Видит что поле Номер счета продавца не заполнено или заполнено неверно$/) do
  xpath = "//span[contains(@class,'is-required')]//input[@name='search-seller--account-number']"
  page.should have_xpath(xpath)
end

When(/^Видит что поле ИНН продавца юр\.лица не заполнено или заполнено неверно$/) do
  xpath = "//span[contains(@class,'input_focused')]//input[@name='search-seller--developer--inn']"
  page.should have_xpath(xpath)
end

When(/^Видит что поле Наименование организации продавца не заполнено или заполнено неверно$/) do
  xpath = "//span[contains(@class,'input_focused')]//input[@name='search-seller--developer--name']"
  page.should have_xpath(xpath)
end

When(/^Видит что поле Адрес организации продавца не заполнено или заполнено неверно$/) do
  xpath = "//span[contains(@class,'input_focused')]//input[@name='search-seller--developer--address']"
  page.should have_xpath(xpath)
end

When(/^Видит что поле ОГРН организации продавца не заполнено или заполнено неверно$/) do
  xpath = "//span[contains(@class,'input_focused')]//input[@name='search-seller--developer--ogrn']"
  page.should have_xpath(xpath)
end

When(/^Видит что поле БИК банка продавца не заполнено или заполнено неверно$/) do
  xpath = "//span[contains(@class,'input_focused')]//input[@name='search-seller--bank-bik']"
  page.should have_xpath(xpath)
end

When(/^Видит что Подписанный скан заявления обязателен$/) do
  check_scanned_statement
end

When(/^Запоминает установленный срок действия аккредитива$/) do
  remember_accr_lifetime
end

When(/^Указывает срок действия аккредитива "([^"]*)" дней$/) do |days|
  fill_accr_lifetime days
end

When(/^Видит что поле Срок действия аккредитива не заполнено или заполнено неверно/) do
  check_accr_lifetime
end

When(/^Видит сообщение о допустимом сроке действия аккредитива$/) do
  see_message_accr_lifetime
end

When(/^Вводит ФИО второго покупателя "([^"]*)"$/) do |name|
  fill_second_buyer_name name
end

When(/^Удаляет в поле "([^"]*)" последнюю цифру$/) do |field_name|
  delete_last_digit get_field_path field_name
end

When(/^Удаляет значение поля "([^"]*)"$/) do |field_name|
  remove_field_value get_field_path field_name
end

When(/^Заполняет форму используя способ покупки \- У застройщика и "([^"]*)"$/) do |data_set|
  path = '../../../helpers/data_sets/create_accr_dev.yml'

  data = YAML.load_file(File.expand_path(File.dirname(__FILE__)+path))[data_set]
  puts data
  fill_account_number data['номер счета продавца'] if data['номер счета продавца']
  fill_inn_number_dev data['ИНН продавца юр.лица'] if data['ИНН продавца юр.лица']
  fill_name_seller_org data['наименование организации продавца'] if data['наименование организации продавца']
  fill_ogrn_number data['ОГРН организации продавца'] if data['ОГРН организации продавца']
  fill_address_seller_org data['адрес организации продавца'] if data['адрес организации продавца']
  fill_bic_number data['БИК банка продавца'] if data['БИК банка продавца']
  select_salary_account data['зарплатный счет'] if data['зарплатный счет']
  fill_second_buyer_name data['ФИО второго покупателя'] if data['ФИО второго покупателя']
  fill_amount_accr data['сумма акредетива'] if data['сумма акредетива']
  fill_address_real_estate data['адрес приобретаемой недвижимости'] if data['адрес приобретаемой недвижимости']
  fill_contract_number data['номер договора'] if data['номер договора']
  fill_contract_date Date.today.strftime('%d.%m.%Y')
  fill_contract_name data['наименование договора'] if data['наименование договора']
  upload_contract_copy
  fill_conditions data['условия исполнения договора'] if data['условия исполнения договора']
  print_statement
  upload_statement
end


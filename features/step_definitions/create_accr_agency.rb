# encoding: utf-8

require_relative '../pages/create_accr_agency_page.rb'
require_relative '../pages/create_accr_dev_page.rb'
require 'capybara'
require 'date'

include Create_agency
include Create_dev
include Utils


When(/^Выбирает Тип продавца "([^"]*)"$/) do |seller_type|
  select_seller_type seller_type
end

When(/^Вводит ФИО продавца "([^"]*)"$/) do |name|
  fill_seller_full_name name
end

When(/^Вводит ИНН продавца физ\.лица "([^"]*)"$/) do |number|
  fill_inn_number_ind number
end

When(/^Вводит Серию паспорта "([^"]*)"$/) do |series|
  fill_passport_series series
end

When(/^Вводит Номер паспорта "([^"]*)"$/) do |number|
  fill_passport_number number
end

When(/^Вводит Кем выдан паспорт "([^"]*)"$/) do |organization|
  fill_issued_by organization
end

When(/^Указывает Когда выдан паспорт \(текущая дата\)$/) do
  fill_issued_date Date.today.strftime('%d.%m.%Y')
end

When(/^Указывает Дату рождения \(текущая дата\)$/) do
  fill_birth_date Date.today.strftime('%d.%m.%Y')
end

When(/^Вводит Место рождения "([^"]*)"$/) do |birth_place|
  fill_birth_place birth_place
end

When(/^Указывает Гражданство "([^"]*)"$/) do |citizenship|
  select_citizenship citizenship
end

When(/^Вводит Адрес регистрации "([^"]*)"$/) do |address|
  fill_registration_address address
end

When(/^Указывает дату Когда выдан паспорт "([^"]*)"$/) do |date|
  fill_issued_date date
end

When(/^Кликает на поле Когда выдан паспорт$/) do
  click_issued_date
end

When(/^Указывает Дату рождения "([^"]*)"$/) do |date|
  fill_birth_date date
end

When(/^Кликает на поле Дата рождения$/) do
  click_birth_date
end

When(/^Заполняет форму используя способ покупки \- Через агенство и "([^"]*)"$/) do |data_set|
  path = '../../../helpers/data_sets/create_accr_agency.yml'

  # file_for_report = File.open(File.expand_path(File.dirname(__FILE__)+path))
  # AllureCucumber::DSL.attach_file("create_accr_agency.yml", file_for_report, true)

  data = YAML.load_file(File.expand_path(File.dirname(__FILE__)+path))[data_set]
  puts data
  select_purchase_method data['способ покупки'] if data['способ покупки']
  fill_account_number data['номер счета продавца'] if data['номер счета продавца']
  select_seller_type data['тип продавца'] if data['тип продавца']

  fill_inn_number_dev data['ИНН продавца юр.лица'] if data['ИНН продавца юр.лица']
  fill_name_seller_org data['наименование организации продавца'] if data['наименование организации продавца']
  fill_ogrn_number data['ОГРН организации продавца'] if data['ОГРН организации продавца']
  fill_address_seller_org data['адрес организации продавца'] if data['адрес организации продавца']

  fill_seller_full_name data['ФИО продавца'] if data['ФИО продавца']
  fill_inn_number_ind data['ИНН продавца физ.лица'] if data['ИНН продавца физ.лица']
  fill_passport_series data['серия паспорта'] if data['серия паспорта']
  fill_passport_number data['номер паспорта'] if data['номер паспорта']
  fill_issued_by data['кем выдан паспорт'] if data['кем выдан паспорт']
  fill_issued_date Date.today.strftime('%d.%m.%Y') if data['когда выдан паспорт']
  fill_birth_date Date.today.strftime('%d.%m.%Y') if data['дата рождения']
  fill_birth_place data['место рождения'] if data['место рождения']
  select_citizenship data['гражданство'] if data['гражданство']
  fill_registration_address data['адрес регистрации'] if data['адрес регистрации']

  fill_bic_number data['БИК банка продавца'] if data['БИК банка продавца']

  select_salary_account data['зарплатный счет'] if data['зарплатный счет']
  fill_amount_accr data['сумма акредетива'] if data['сумма акредетива']
  fill_address_real_estate data['адрес приобретаемой недвижимости'] if data['адрес приобретаемой недвижимости']

  fill_contract_number data['номер договора'] if data['номер договора']
  fill_contract_date Date.today.strftime('%d.%m.%Y') if data['дата договора']
  fill_contract_name data['наименование договора'] if data['наименование договора']
  upload_contract_copy
  fill_conditions data['условия исполнения договора'] if data['условия исполнения договора']
  print_statement
  upload_statement
end

When(/^Видит что поля в блоке данных физ\.лицо не заполнены$/) do
  check_block_fields_ind
end
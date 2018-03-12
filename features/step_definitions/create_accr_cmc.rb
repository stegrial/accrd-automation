# encoding: utf-8

require_relative '../pages/create_accr_cmc_page.rb'
require_relative '../pages/create_accr_dev_page.rb'
require_relative '../pages/create_accr_agency_page.rb'
require 'capybara'
require 'date'

include Create_cmc
include Create_dev
include Create_agency
include Utils


When(/^Заполняет форму используя способ покупки \- ЦИК и "([^"]*)"$/) do |data_set|
  path = '../../../helpers/data_sets/create_accr_cmc.yml'
  data = YAML.load_file(File.expand_path(File.dirname(__FILE__)+path))[data_set]
  puts JSON.pretty_generate(data)

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

  fill_income_account_number data['счет доходов'] if data['счет доходов']
  fill_profit_center_code data['код профит-центра'] if data['код профит-центра']
  fill_commission_amount data['сумма комиссии'] if data['сумма комиссии']
  fill_branch data['бранч отделения'] if data['бранч отделения']

  select_salary_account data['зарплатный счет'] if data['зарплатный счет']
  fill_second_buyer_name data['ФИО второго покупателя'] if data['ФИО второго покупателя']
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

When(/^Вводит Счет доходов "([^"]*)"$/) do |number|
  fill_income_account_number number
end

When(/^Вводит Код профит\-центра "([^"]*)"$/) do |code|
  fill_profit_center_code code
end

When(/^Вводит Бранч отделения "([^"]*)"$/) do |number|
  fill_branch number
end

When(/^Вводит Сумма комиссии "([^"]*)"$/) do |amount|
  fill_commission_amount amount
end
# encoding: utf-8

require_relative '../pages/compare_data_page.rb'
require_relative '../pages/create_accr_dev_page.rb'
require_relative '../pages/create_accr_agency_page.rb'

require 'capybara'
require 'roo-xls'

include Compare_data
include Create_dev
include Create_agency
include Utils


When(/^Заполняет форму для сравнения с печатной формой используя "([^"]*)"$/) do |data_set|
  path = '../../../helpers/data_sets/compare_data.yml'

  # file_for_report = File.open(File.expand_path(File.dirname(__FILE__)+path))
  # AllureCucumber::DSL.attach_file("create_accr_dev.yml", file_for_report, true)

  data = YAML.load_file(File.expand_path(File.dirname(__FILE__)+path))[data_set]
  puts data
  select_purchase_method data['способ покупки'] if data['способ покупки']
  fill_account_number data['номер счета продавца'] if data['номер счета продавца']
  select_seller_type data['тип продавца'] if data['тип продавца']
  fill_seller_full_name data['ФИО продавца'] if data['ФИО продавца']
  fill_inn_number_dev data['ИНН продавца юр.лица'] if data['ИНН продавца юр.лица']
  fill_name_seller_org data['наименование организации продавца'] if data['наименование организации продавца']
  fill_ogrn_number data['ОГРН организации продавца'] if data['ОГРН организации продавца']
  fill_address_seller_org data['адрес организации продавца'] if data['адрес организации продавца']
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

When(/^Видит что данные в печатной форме заявки соответствуют "([^"]*)"$/) do |data_set|
  sleep 10

  path = File.expand_path('../../config/saved_statements/', File.dirname(__FILE__)) + '/*'
  puts path
  files = Dir[path]

  files.each do |file_name|
    puts 'file: '
    puts file_name
    end

  path1 = '../../../helpers/data_sets/compare_data.yml'
  data = YAML.load_file(File.expand_path(File.dirname(__FILE__)+path1))[data_set]
  path2 = "../../../config/saved_statements/Accreditive_order_#{$new_generated_accr_number}.xls"
  xls = Roo::Spreadsheet.open(File.expand_path(File.dirname(__FILE__)+path2))


  compare_account_number(data['номер счета продавца'], xls) if data['номер счета продавца']
  compare_seller_full_name(data['ФИО продавца'], xls) if data['ФИО продавца']
  compare_birth_date(Date.today.strftime('%d.%m.%Y'), xls) if data['дата рождения']
  compare_inn_number_dev(data['ИНН продавца юр.лица'], xls) if data['ИНН продавца юр.лица']
  compare_name_seller_org(data['наименование организации продавца'], xls) if data['наименование организации продавца']

end
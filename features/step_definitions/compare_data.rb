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

  fill_accr_lifetime data['срок действия аккредитива'] if data['срок действия аккредитива']
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

When(/^Видит что данные в печатной форме заявки соответствуют "([^"]*)"$/) do |data_set|
  sleep 3

  path = File.expand_path('../../config/saved_statements/', File.dirname(__FILE__)) + '/*'
  puts path
  files = Dir[path]

  files.each do |file_name|
    puts 'file: '
    puts file_name
    end

  path1 = '../../../helpers/data_sets/compare_data.yml'
  data = YAML.load_file(File.expand_path(File.dirname(__FILE__)+path1))[data_set]
  path2 = "../../../config/saved_statements/Accreditive_order_#{$saved_accrd_num}.xls"
  xls = Roo::Spreadsheet.open(File.expand_path(File.dirname(__FILE__)+path2))


  compare_account_number(data['номер счета продавца'], xls) if data['номер счета продавца']

  compare_inn_number_dev(data['ИНН продавца юр.лица'], xls) if data['ИНН продавца юр.лица']
  compare_name_seller_org(data['наименование организации продавца'],xls) if data['наименование организации продавца']
  compare_ogrn_number(data['ОГРН организации продавца'], xls) if data['ОГРН организации продавца']
  compare_address_seller_org(data['адрес организации продавца'], xls) if data['адрес организации продавца']

  compare_seller_full_name(data['ФИО продавца'], xls) if data['ФИО продавца']
  compare_inn_number_ind(data['ИНН продавца физ.лица'], xls) if data['ИНН продавца физ.лица']
  compare_passport_series(data['серия паспорта'], xls) if data['серия паспорта']
  compare_passport_number(data['номер паспорта'], xls) if data['номер паспорта']
  compare_issued_by(data['кем выдан паспорт'], xls) if data['кем выдан паспорт']
  compare_issued_date(Date.today.strftime('%d.%m.%Y'), xls) if data['когда выдан паспорт']
  # compare_birth_date(Date.today.strftime('%d.%m.%Y'), xls) if data['дата рождения']
  compare_birth_place(data['место рождения'], xls) if data['место рождения']
  compare_citizenship(data['гражданство'], xls) if data['гражданство']
  compare_registration_address(data['адрес регистрации'], xls) if data['адрес регистрации']

  compare_bic_number(data['БИК банка продавца'], xls) if data['БИК банка продавца']

  compare_accr_lifetime(data['срок действия аккредитива'], xls) if data['срок действия аккредитива']
  compare_salary_account(data['зарплатный счет'], xls) if data['зарплатный счет']
  compare_second_buyer_name(data['ФИО второго покупателя'], xls) if data['ФИО второго покупателя']
  # compare_amount_accr(data['сумма акредетива'], xls) if data['сумма акредетива']
  compare_address_real_estate(data['адрес приобретаемой недвижимости'], xls) if data['адрес приобретаемой недвижимости']

  compare_contract_number(data['номер договора'], xls) if data['номер договора']
  compare_contract_date(Date.today.strftime('%d.%m.%Y'), xls) if data['дата договора']
  compare_contract_name(data['наименование договора'], xls) if data['наименование договора']
  compare_conditions(data['условия исполнения договора'], xls) if data['условия исполнения договора']

end
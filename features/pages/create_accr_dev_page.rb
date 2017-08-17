require_relative '../../helpers/http_helper'
require_relative '../../features/support/utils'
require 'capybara'


include HTTPHelper
include Utils

module Create_dev

  def open_page(user)
    url = "/accr/new?token=#{HTTPHelper.get_token user}"
    puts url
    visit url
  end

  def fill_invoice_number(number)
    find(:xpath, "//input[@name='search-seller--account-number']").set('')
    find(:xpath, "//input[@name='search-seller--account-number']").set(number)
  end

  def select_salary_account(number)
    find(:xpath, "//div[@data-reactid='83']").click
    find(:xpath, "//span[@class='menu-item__control']//*[contains(text(),'#{number}')]").click
  end

  def fill_amount_accr(number)
    find(:xpath, "//input[@name='about-accreditive--accreditive-amount']").set('')
    find(:xpath, "//input[@name='about-accreditive--accreditive-amount']").set(number)
  end

  def fill_address_real_estate(address)
    find(:xpath, "//textarea[@name='about-accreditive--real-estate-address']").set(address)
  end

  def fill_contract_number(number)
    find(:xpath, "//input[@name='about-document--contract-number']").set(number)
  end

  def fill_contract_date(date)
    find(:xpath, "//input[@data-reactid='149']").set('')
    find(:xpath, "//input[@data-reactid='149']").set(date)
  end

  def fill_contract_name(name)
    find(:xpath, "//input[@name='about-document--contract-name']").set(name)
  end

  def upload_contract_copy
    find(:xpath, "//input[@data-reactid='175']", visible: false).set(File.join(Dir.pwd, 'config/contract_copy.pdf'))
  end

  def fill_conditions(conditions)
    find(:xpath, "//textarea[@name='about-document--contract-conditions']").set(conditions)
  end

  def print_statement
    find(:xpath, "//button[@data-reactid='192']").click
  end

  def upload_statement
    find(:xpath, "//input[@data-reactid='204']", visible: false).set(File.join(Dir.pwd, 'config/statement.pdf'))
  end

  def open_accr
    find(:xpath, "//button[@data-reactid='208' and contains(., 'Открыть')]").click
  end

  def check_accr
    find(:xpath, "//button[@data-reactid='208' and contains(., 'Проверить незаполненные поля')]").click
  end

  def get_disabled_button_path(button_name)
    xpath = ''
    case button_name
      when 'Распечатать'
        xpath = "//button[@data-reactid='192' and @disabled]"
      when 'Приложить'
        xpath = "//span[@data-reactid='201' and @disabled]"
      when 'Открыть'
        xpath = "//button[@data-reactid='208' and @disabled]"
      else
        puts 'Error'
    end
    p xpath
  end

  def get_field_path(field)
    xpath = ''
    case field
      when 'Сумма аккредитива'
        xpath = "//input[@name='about-accreditive--accreditive-amount']"
      when 'Дата договора'
        xpath = "//input[@data-reactid='149']"
      when 'Номер счета продавца'
        xpath = "//input[@name='search-seller--account-number']"
      when 'ИНН продавца юр.лица'
        xpath = "//input[@name='search-seller--developer--inn']"
      when 'ИНН продавца физ.лица'
        xpath = "//input[@name='search-seller--individual--inn']"
      when 'ОГРН организации продавца'
        xpath = "//input[@name='search-seller--developer--ogrn']"
      when 'БИК банка продавца'
        xpath = "//input[@name='search-seller--bank-bik']"
      when 'Наименование организации продавца'
        xpath = "//input[@name='search-seller--developer--name']"
      when 'Адрес организации продавца'
        xpath = "//input[@name='search-seller--developer--address']"
      when 'Серия паспорта'
        xpath = "//input[@name='search-seller--individual--passport-series']"
      when 'Номер паспорта'
        xpath = "//input[@name='search-seller--individual--passport-number']"
      when 'Когда выдан паспорт'
        xpath = "//input[@tabindex='46']"
      when 'Дата рождения'
        xpath = "//input[@tabindex='47']"
      else
        puts 'Error'
    end
    p xpath
  end

  def click_contract_date
    find(:xpath, "//input[@data-reactid='149']").click
  end

  def date_compare_calendar(month, year)
    month_ru = {'01' => 'Январь', '02' => 'Февраль', '03' => 'Март',
                '04' => 'Апрель', '05' => 'Май', '06' => 'Июнь',
                '07' => 'Июль','08' => 'Август','09' => 'Сентябрь',
                '10' => 'Октябрь','11' => 'Ноябрь','12' => 'Декабрь'}

    current_month = "#{month_ru[month]} #{year}"
    find(:xpath, "//div[@class='calendar__name']").text.should == current_month
  end

  def calendar_double_arrow_back
    find(:xpath, "//div[@class='calendar__arrow calendar__arrow_direction_left calendar__arrow_double']").click
  end

  def calendar_double_arrow_forward
    find(:xpath, "//div[@class='calendar__arrow calendar__arrow_direction_right calendar__arrow_double']").click
  end

  def calendar_single_arrow_back
    find(:xpath, "//div[@class='calendar__arrow calendar__arrow_direction_left']").click
  end

  def calendar_single_arrow_forward
    find(:xpath, "//div[@class='calendar__arrow calendar__arrow_direction_right']").click
  end

  def select_current_date(day)
    find(:xpath, "//table[@class='calendar__layout']//td[@data-day='#{day}']").click
  end

  def remove_contract_copy
    find(:xpath, "//div[@data-reactid='165']//button[@class='attach__clear']").click
  end

  def fill_bic_number(number)
    find(:xpath, "//input[@name='search-seller--bank-bik']").set('')
    find(:xpath, "//input[@name='search-seller--bank-bik']").set(number)
  end

  def fill_inn_number_dev(number)
    find(:xpath, "//input[@name='search-seller--developer--inn']").set('')
    find(:xpath, "//input[@name='search-seller--developer--inn']").set(number)
  end

  def get_disabled_field_path(field)
    xpath = ''
    case field
      when 'Наименование организации продавца'
        xpath = "//input[@name='search-seller--developer--name' and @disabled]"
      when 'ОГРН организации продавца'
        xpath = "//input[@name='search-seller--developer--ogrn' and @disabled]"
      when 'Адрес организации продавца'
        xpath = "//input[@name='search-seller--developer--address' and @disabled]"
      when 'Название банка продавца'
        xpath = "//input[@name='search-seller--bank-name' and @disabled]"
      when 'Корреспондентский счет банка продавца'
        xpath = "//input[@name='search-seller--bank-cor-account' and @disabled]"
      else
        puts 'Error'
    end
    p xpath
  end

  def fill_ogrn_number(number)
    find(:xpath, "//input[@name='search-seller--developer--ogrn']").set('')
    find(:xpath, "//input[@name='search-seller--developer--ogrn']").set(number)
  end

  def fill_address_seller_org(address_org)
    find(:xpath, "//input[@name='search-seller--developer--address']").set(address_org)
  end

  def fill_name_seller_org(name_org)
    find(:xpath, "//input[@name='search-seller--developer--name']").set(name_org)
  end

  def select_purchase_method(method)
    find(:xpath, "//div[@data-reactid='48']").click
    find(:xpath, "//span[@class='menu-item__control' and text()='#{method}']").click
  end

  def remove_statement_copy
    find(:xpath, "//div[@data-reactid='194']//button[@class='attach__clear']").click
  end

  def press_new_purchase_button
    find(:xpath, "//button[contains(@class, 'button_view_extra')and contains(., 'Новая покупка')]").click
  end


end
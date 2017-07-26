require_relative '../../helpers/http_helper'
require_relative '../../features/support/utils'
require 'capybara'


include HTTPHelper
include Utils

module Create

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
    find(:xpath, "//div[@data-reactid='73']").click
    find(:xpath, "//span[@class='menu-item__control']//*[contains(text(),'#{number}')]").click
  end

  def fill_amount_accr(number)
    find(:xpath, "//input[@data-reactid='90']").set(number)
  end

  def fill_address_real_estate(address)
    find(:xpath, "//textarea[@data-reactid='102']").set(address)
  end

  def fill_contract_number(number)
    find(:xpath, "//input[@data-reactid='119']").set(number)
  end

  def fill_contract_date(current_date)
    find(:xpath, "//input[@data-reactid='131']").set(current_date)
  end

  def fill_contract_name(name)
    find(:xpath, "//input[@data-reactid='144']").set(name)
  end

  def upload_contract_copy
    find(:xpath, "//input[@data-reactid='157']", visible: false).set(File.join(Dir.pwd, 'config/contract_copy.pdf'))
  end

  def fill_conditions(conditions)
    find(:xpath, "//textarea[@data-reactid='166']").set(conditions)
  end

  def print_statement
    find(:xpath, "//span[@data-reactid='175']").click
  end

  def upload_statement
    find(:xpath, "//input[@data-reactid='186']", visible: false).set(File.join(Dir.pwd, 'config/statement.pdf'))
  end

  def open_accr
    find(:xpath, "//button[@data-reactid='190']").click
  end

  def select_pay_type(pay_type)
    find(:xpath, "//div[@data-reactid='48']").click
    find(:xpath, "//*[contains(text(), '#{pay_type}')]").click
  end

  def get_disabled_button_path(button_name)
    xpath = ''
    case button_name
      when 'Распечатать'
        xpath = "//button[@data-reactid='174' and @disabled]"
      when 'Приложить'
        xpath = "//span[@data-reactid='183' and @disabled]"
      when 'Открыть'
        xpath = "//button[@data-reactid='190' and @disabled]"
      else
        puts 'Error'
    end
    p xpath
  end

  def get_field_path(field)
    xpath = ''
    case field
      when 'Сумма аккредитива'
        xpath = "//input[@data-reactid='90']"
      when 'Дата договора'
        xpath = "//input[@data-reactid='131']"
      when 'Номер счета продавца'
        xpath = "//input[@name='search-seller--account-number']"
      when 'ИНН продавца'
        xpath = "//input[@name='search-seller--developer--inn']"
      when 'ОГРН организации продавца'
        xpath = "//input[@name='search-seller--developer--ogrn']"
      when 'БИК банка продавца'
        xpath = "//input[@name='search-seller--bank-bik']"
      when 'Наименование организации продавца'
        xpath = "//input[@name='search-seller--developer--name']"
      when 'Адрес организации продавца'
        xpath = "//input[@name='search-seller--developer--address']"
      else
        puts 'Error'
    end
    p xpath
  end

  def click_contract_date
    find(:xpath, "//input[@data-reactid='131']").click
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
    find(:xpath, "//table[@class='calendar__layout']//td[text()='#{day}']").click
  end

  def remove_contract_copy
    find(:xpath, "//div[@data-reactid='147']//button[@class='attach__clear']").click
  end

  def fill_bic_number(number)
    find(:xpath, "//input[@name='search-seller--bank-bik']").set('')
    find(:xpath, "//input[@name='search-seller--bank-bik']").set(number)
  end

  def fill_inn_number(number)
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
    find(:xpath, "//div[@data-reactid='176']//button[@class='attach__clear']").click
  end

  def press_new_purchase_button
    find(:xpath, "//button[contains(@class, 'button_view_extra')and contains(., 'Новая покупка')]").click
  end


end
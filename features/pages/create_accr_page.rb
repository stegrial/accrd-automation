require_relative '../../helpers/http_helper'
require_relative '../../features/support/utils'
require 'capybara'


include HTTPHelper
include Utils

module Create

  def open_page(user)
    url = "/new?token=#{HTTPHelper.get_token user}"
    puts url
    visit url
  end

  def fill_invoice_number(number)
    find(:xpath, "//input[@data-reactid='65']").set(number)
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

  def fill_current_contract_date
    current_date = Time.now.strftime('%d.%m.%Y')
    find(:xpath, "//input[@data-reactid='131']").set(current_date)
  end

  def fill_contract_name(name)
    find(:xpath, "//input[@data-reactid='144']").set(name)
  end

  def upload_contract_copy
    find(:xpath, "//input[@data-reactid='157']", visible: false).set(File.join(Dir.pwd, 'config/test.pdf'))
  end

  def fill_conditions(conditions)
    find(:xpath, "//textarea[@data-reactid='166']").set(conditions)
  end

  def print_statement
    find(:xpath, "//span[@data-reactid='175']").click
  end

  def upload_statement
    find(:xpath, "//input[@data-reactid='186']", visible: false).set(File.join(Dir.pwd, 'config/test.pdf'))
  end

  def open_accr
    find(:xpath, "//button[@data-reactid='190']").click
  end

  def select_pay_type(pay_type)
    find(:xpath, "//div[@data-reactid='48']").click
    find(:xpath, "//*[contains(text(), '#{pay_type}')]").click

  end

end
require_relative '../../helpers/http_helper'
require_relative '../../features/support/utils'
require 'capybara'


include HTTPHelper
include Utils

module Create_agency

  def select_seller_type(seller_type)
    find(:xpath, "//div[@data-reactid='57']//div[contains(@class,'select_mode_radio')]").click
    find(:xpath, "//span[@class='menu-item__control' and text()='#{seller_type}']").click
  end

  def fill_full_name(name)
    find(:xpath, "//input[@name='search-seller--individual--fullName']").set(name)
  end

  def fill_inn_number_ind(number)
    find(:xpath, "//input[@name='search-seller--individual--inn']").set('')
    find(:xpath, "//input[@name='search-seller--individual--inn']").set(number)
  end

  def fill_passport_series(series)
    find(:xpath, "//input[@name='search-seller--individual--passport-series']").set('')
    find(:xpath, "//input[@name='search-seller--individual--passport-series']").set(series)
  end

  def fill_passport_number(number)
    find(:xpath, "//input[@name='search-seller--individual--passport-number']").set(number)
  end

  def fill_issued_by(org)
    find(:xpath, "//input[@name='search-seller--individual--passport-issued-by']").set(org)
  end

  def fill_issued_date(date)
    find(:xpath, "//input[@tabindex='46']").set('')
    find(:xpath, "//input[@tabindex='46']").set(date)
  end

  def fill_birth_date(date)
    find(:xpath, "//input[@tabindex='47']").set('')
    find(:xpath, "//input[@tabindex='47']").set(date)
  end

  def fill_birth_place(birth_place)
    find(:xpath, "//input[@name='search-seller--individual--birth-place']").set(birth_place)
  end

  def select_citizenship(citizenship)
    # find(:xpath, "//input[@name='search-seller--individual--citizenship']").click - список по клику
    find(:xpath, "//input[@name='search-seller--individual--citizenship']").set(citizenship)
    find(:xpath, "//span[@class='label__inner' and text()='#{citizenship}']").click
  end

  def fill_registration_address(address)
    find(:xpath, "//input[@name='search-seller--individual--address']").set(address)
  end

  def click_issued_date
    find(:xpath, "//input[@tabindex='46']").click
  end

  def click_birth_date
    find(:xpath, "//input[@tabindex='47']").click
  end

end
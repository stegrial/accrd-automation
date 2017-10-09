# encoding: UTF-8

require_relative '../../helpers/http_helper'
require_relative '../../features/support/utils'
require_relative 'create_accr_dev_page'
require 'capybara'

include Create_dev
include HTTPHelper
include Utils


module Create_agency

  def select_seller_type(seller_type)
    begin
      find(:xpath, "//div[@data-reactid='57']//div[contains(@class,'select_mode_radio')]").click
      find(:xpath, "//span[@class='menu-item__control' and text()='#{seller_type}']").click
    rescue
      raise 'Не удалось выбрать тип продавца'
    end
  end

  def fill_seller_full_name(name)
    begin
      find(:xpath, "//input[@name='search-seller--individual--fullName']").set(name)
    rescue
      raise 'Не удалось заполнить поле - ФИО продавца'
    end
  end

  def fill_inn_number_ind(number)
    begin
      find(:xpath, "//input[@name='search-seller--individual--inn']").set('')
      find(:xpath, "//input[@name='search-seller--individual--inn']").set(number)
    rescue
      raise 'Не удалось заполнить поле - ИНН продавца физ.лица'
    end
  end

  def fill_passport_series(series)
    begin
      find(:xpath, "//input[@name='search-seller--individual--passport-series']").set('')
      find(:xpath, "//input[@name='search-seller--individual--passport-series']").set(series)
    rescue
      raise 'Не удалось заполнить поле - Серия паспорта'
    end
  end

  def fill_passport_number(number)
    begin
      find(:xpath, "//input[@name='search-seller--individual--passport-number']").set(number)
    rescue
      raise 'Не удалось заполнить поле - Номер паспорта'
    end
  end

  def fill_issued_by(org)
    begin
      find(:xpath, "//input[@name='search-seller--individual--passport-issued-by']").set(org)
    rescue
      raise 'Не удалось заполнить поле - Кем выдан паспорт'
    end
  end

  def fill_issued_date(date)
    begin
      find(:xpath, "//input[@name='search-seller--individual--passport-issued-date']").set('')
      find(:xpath, "//input[@name='search-seller--individual--passport-issued-date']").set(date)
    rescue
      raise 'Не удалось заполнить поле - Когда выдан паспорт'
    end
  end

  def fill_birth_date(date)
    begin
      find(:xpath, "//input[@name='search-seller--individual--birth-date']").set('')
      find(:xpath, "//input[@name='search-seller--individual--birth-date']").set(date)
    rescue
      raise 'Не удалось заполнить поле - Дата рождения'
    end
  end

  def fill_birth_place(birth_place)
    begin
      find(:xpath, "//input[@name='search-seller--individual--birth-place']").set(birth_place)
    rescue
      raise 'Не удалось заполнить поле - Место рождения'
    end
  end

  def select_citizenship(citizenship)
    begin
      # find(:xpath, "//input[@name='search-seller--individual--citizenship']").click - список по клику
      find(:xpath, "//input[@name='search-seller--individual--citizenship']").set(citizenship)
      find(:xpath, "//span[@class='label__inner' and text()='#{citizenship}']").click
    rescue
      raise 'Не удалось выбрать гражданство'
    end
  end

  def fill_registration_address(address)
    begin
      find(:xpath, "//input[@name='search-seller--individual--address']").set(address)
    rescue
      raise 'Не удалось заполнить поле - Адрес регистрации'
    end
  end

  def click_issued_date
    begin
      find(:xpath, "//input[@name='search-seller--individual--passport-issued-date']").click
    rescue
      raise 'Не удалось кликнуть по полю - Когда выдан паспорт'
    end
  end

  def click_birth_date
    begin
      find(:xpath, "//input[@name='search-seller--individual--birth-date']").click
    rescue
      raise 'Не удалось кликнуть по полю - Дата рождения'
    end
  end

  def check_block_fields_ind
    begin
      fields = ['ФИО продавца', 'ИНН продавца физ.лица', 'Серия паспорта', 'Номер паспорта', 'Кем выдан паспорт',
                'Когда выдан паспорт', 'Дата рождения', 'Место рождения', 'Гражданство', 'Адрес регистрации']
      fields.each do |field_name|
      find(:xpath, get_field_path(field_name)).value.should == ''
      end
    rescue
      raise 'В блоке данных физ.лицо есть заполненные поля'
    end
  end

end
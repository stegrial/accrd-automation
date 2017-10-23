# encoding: UTF-8

require_relative '../../helpers/http_helper'
require_relative '../../features/support/utils'
require 'capybara'
require 'mongo'
require 'json'


include HTTPHelper
include Utils


module Search_number

  def open_search_number_page(user)
    begin
      url = "/accrd-ui/accr/search?ad-token=#{HTTPHelper.get_token user}"
      # puts url
      visit url
    rescue
      raise 'Не удалось открыть страницу с формой поиска заявки по номеру'
    end
  end

  def press_find_button
    begin
      find(:xpath, "//button[@data-reactid='40' or @data-reactid='38']").click
      page.should_not have_xpath("//span[contains(@class, 'input_disabled')]")
    rescue
      raise 'Не удалось нажать на кнопку - Найти'
    end
  end

  def enter_search_value(search_value)
    begin
      find(:xpath, "//span[@data-reactid='35' or @data-reactid='33']//input").set('')
      find(:xpath, "//span[@data-reactid='35' or @data-reactid='33']//input").set(search_value)
    rescue
      raise 'Не удалось ввести значение для поиска'
    end
  end

  def remember_new_number
    begin
      $new_generated_accr_number = find(:xpath, "//span[@class='label__inner' and contains(., 'ACCD')]").text
    rescue
      raise 'Не удалось запомнить номер заявки на аккредитив'
    end
  end

  def some(accr_id)
    client = Mongo::Client.new(['172.28.59.23:27021'], database: 'accrd')

    database = client.database

    p database.collections #=> Returns an array of Collection objects.
    p database.collection_names #=> Returns an array of collection names as strings.

    collection_orders = client[:accreditiveOrders]
    accreditive = collection_orders.find({number: accr_id}).first
    p accreditive['accreditive']['coveringAccount']


    collection_settings = client[:settings]
    p collection_settings
    settings = collection_settings.find({_id: 'eq_unit_date'})
    p settings
    p settings['value']

  end

  def enter_no_exist_number
    begin
      no_exist_number = "#{$new_generated_accr_number[0...-1]}#{$new_generated_accr_number[-1].to_i+1}"
      find(:xpath, "//input[@data-reactid='37']").set(no_exist_number)
    rescue
      raise 'Не удалось ввести несуществующий номер заявки'
    end
  end

  def save_contract_copy
    begin
      find(:xpath, "//span[@class='button__text' and text()='contract_copy.pdf']").click
    rescue
      raise 'Не удалось сохранить копию договора купли-продажи'
    end
  end

  def save_statement
    begin
      find(:xpath, "//span[@class='button__text' and text()='statement.pdf']").click
    rescue
      raise 'Не удалось сохранить копию заявления'
    end
  end

  def press_edit_button
    begin
      find(:xpath, "//span[contains(@class, 'button__text')and contains(., 'Редактировать')]").click
    rescue
      raise 'Не удалось нажать на кнопку - Редактировать'
    end
  end

  def confirm_entered_data
    begin
      find(:xpath, "//button[contains(@class, 'new-accreditive__submit-button') and contains(., 'Открыть')]").click
    rescue
      raise 'Не удалось подтвердить введенные данные в заявке'
    end
  end

  def confirm_statement
    begin
      javascript_scroll 600
      find(:xpath, "//span[contains(@class, 'button__text') and contains(., 'Подтвердить')]").click

    rescue
      raise 'Не удалось подтвердить заявку на аккредитив'
    end
  end

  # def remember_account_balance проверка что деньги сняты со счета
  #   $account_balance = find(:xpath, "").text
  # end

end